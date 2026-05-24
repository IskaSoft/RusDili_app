import '../database/database_service.dart';
import '../models/exercise.dart';
import '../models/grammar_rule.dart';

class ExerciseRepository {
  final DatabaseService _db;

  ExerciseRepository(this._db);

  // ── Exercises ────────────────────────────────────────────

  // DÜZEDIŞ #3: N+1+N soraglar ýok edildi.
  // Öňki kod:
  //   1 sorag exercises → for her exercise: 1 sorag questions →
  //     for her question: 1 sorag options
  //   = 2 exercise × 5 sorag = 1 + 2 + 10 = 13 SQL!
  // Täze kod: 2 JOIN soragyň içinde ähli data — hemişe 2 SQL sorag.
  Future<List<Exercise>> getExercisesForLesson(int lessonId) async {
    // Sorag 1: exercises + questions bir gezekde
    const exSql = '''
      SELECT
        e.id            AS e_id,
        e.lesson_id     AS e_lesson_id,
        e.exercise_number AS e_exercise_number,
        e.title_tk      AS e_title_tk,
        e.instruction_tk AS e_instruction_tk,
        e.exercise_type AS e_exercise_type,
        e.note_tk       AS e_note_tk,
        e.order_index   AS e_order_index,
        q.id            AS q_id,
        q.question_order AS q_question_order,
        q.question_text AS q_question_text,
        q.correct_answer AS q_correct_answer,
        q.hint_tk       AS q_hint_tk,
        q.image_path    AS q_image_path
      FROM exercises e
      LEFT JOIN exercise_questions q ON q.exercise_id = e.id
      WHERE e.lesson_id = ?
      ORDER BY e.order_index, q.question_order
    ''';

    // Sorag 2: options (exercise_id arkaly)
    const optSql = '''
      SELECT
        o.id            AS o_id,
        o.question_id   AS o_question_id,
        o.option_text   AS o_option_text,
        o.is_correct    AS o_is_correct
      FROM exercise_options o
      INNER JOIN exercise_questions q ON q.id = o.question_id
      INNER JOIN exercises e ON e.id = q.exercise_id
      WHERE e.lesson_id = ?
    ''';

    final exRows = await _db.rawQuery(exSql, [lessonId]);
    final optRows = await _db.rawQuery(optSql, [lessonId]);

    return _groupExerciseRows(exRows, optRows);
  }

  Future<Exercise?> getExerciseById(int exerciseId) async {
    const exSql = '''
      SELECT
        e.id, e.lesson_id, e.exercise_number, e.title_tk,
        e.instruction_tk, e.exercise_type, e.note_tk, e.order_index,
        q.id AS q_id, q.question_order AS q_question_order,
        q.question_text AS q_question_text,
        q.correct_answer AS q_correct_answer,
        q.hint_tk AS q_hint_tk, q.image_path AS q_image_path
      FROM exercises e
      LEFT JOIN exercise_questions q ON q.exercise_id = e.id
      WHERE e.id = ?
      ORDER BY q.question_order
    ''';
    const optSql = '''
      SELECT o.id AS o_id, o.question_id AS o_question_id,
             o.option_text AS o_option_text, o.is_correct AS o_is_correct
      FROM exercise_options o
      INNER JOIN exercise_questions q ON q.id = o.question_id
      WHERE q.exercise_id = ?
    ''';
    final exRows = await _db.rawQuery(exSql, [exerciseId]);
    final optRows = await _db.rawQuery(optSql, [exerciseId]);
    final exercises = _groupExerciseRows(exRows, optRows);
    return exercises.isEmpty ? null : exercises.first;
  }

  Future<List<ExerciseQuestion>> getQuestionsForExercise(
      int exerciseId) async {
    const sql = '''
      SELECT
        q.id, q.exercise_id, q.question_order, q.question_text,
        q.correct_answer, q.hint_tk, q.image_path,
        o.id AS o_id, o.question_id AS o_question_id,
        o.option_text AS o_option_text, o.is_correct AS o_is_correct
      FROM exercise_questions q
      LEFT JOIN exercise_options o ON o.question_id = q.id
      WHERE q.exercise_id = ?
      ORDER BY q.question_order
    ''';
    final rows = await _db.rawQuery(sql, [exerciseId]);
    return _groupQuestionRows(rows);
  }

  // Get all questions for a lesson shuffled — type filter optional
  Future<List<ExerciseQuestion>> getAllQuestionsForLesson(int lessonId,
      {ExerciseType? type}) async {
    final exercises = await getExercisesForLesson(lessonId);
    final filtered = type != null
        ? exercises.where((e) => e.exerciseType == type).toList()
        : exercises;
    final allQuestions = <ExerciseQuestion>[];
    for (final ex in filtered) {
      allQuestions.addAll(ex.questions);
    }
    allQuestions.shuffle();
    return allQuestions;
  }

  // ── Grammar Rules ────────────────────────────────────────

  // DÜZEDIŞ #3 (dowamy): grammar N+1 hem JOIN bilen çözüldi
  Future<List<GrammarRule>> getGrammarRulesForLesson(int lessonId) async {
    const sql = '''
      SELECT
        g.id            AS g_id,
        g.lesson_id     AS g_lesson_id,
        g.table_number  AS g_table_number,
        g.title_ru      AS g_title_ru,
        g.title_tk      AS g_title_tk,
        g.explanation_tk AS g_explanation_tk,
        g.note_tk       AS g_note_tk,
        g.rule_type     AS g_rule_type,
        g.image_path    AS g_image_path,
        g.order_index   AS g_order_index,
        r.id            AS r_id,
        r.row_order     AS r_row_order,
        r.is_header     AS r_is_header,
        r.cell_1        AS r_cell_1,
        r.cell_2        AS r_cell_2,
        r.cell_3        AS r_cell_3,
        r.cell_4        AS r_cell_4,
        r.cell_5        AS r_cell_5,
        r.cell_6        AS r_cell_6,
        r.cell_7        AS r_cell_7,
        r.red_cells     AS r_red_cells
      FROM grammar_rules g
      LEFT JOIN grammar_table_rows r ON r.grammar_id = g.id
      WHERE g.lesson_id = ?
      ORDER BY g.order_index, r.row_order
    ''';
    final rows = await _db.rawQuery(sql, [lessonId]);
    return _groupGrammarRows(rows);
  }

  // Public wrapper — library_provider standalone exercises üçin çagyrýar
  List<Exercise> groupExerciseRowsPublic(
    List<Map<String, dynamic>> exRows,
    List<Map<String, dynamic>> optRows,
  ) =>
      _groupExerciseRows(exRows, optRows);

  List<Exercise> _groupExerciseRows(
    List<Map<String, dynamic>> exRows,
    List<Map<String, dynamic>> optRows,
  ) {
    // options -> question_id -> list
    final Map<int, List<ExerciseOption>> optsByQuestion = {};
    for (final row in optRows) {
      final qId = row['o_question_id'] as int;
      optsByQuestion.putIfAbsent(qId, () => []).add(ExerciseOption(
        id: row['o_id'] as int,
        questionId: qId,
        optionText: row['o_option_text'] as String,
        isCorrect: (row['o_is_correct'] as int? ?? 0) == 1,
      ));
    }

    final Map<int, Map<String, dynamic>> exerciseMap = {};
    final Map<int, List<ExerciseQuestion>> questionsByEx = {};

    for (final row in exRows) {
      final eId = row['e_id'] as int;
      if (!exerciseMap.containsKey(eId)) {
        exerciseMap[eId] = {
          'id': eId,
          'lesson_id': row['e_lesson_id'],
          'exercise_number': row['e_exercise_number'],
          'title_tk': row['e_title_tk'],
          'instruction_tk': row['e_instruction_tk'],
          'exercise_type': row['e_exercise_type'],
          'note_tk': row['e_note_tk'],
          'order_index': row['e_order_index'],
        };
        questionsByEx[eId] = [];
      }
      if (row['q_id'] != null) {
        final qId = row['q_id'] as int;
        questionsByEx[eId]!.add(ExerciseQuestion(
          id: qId,
          exerciseId: eId,
          questionOrder: row['q_question_order'] as int? ?? 0,
          questionText: row['q_question_text'] as String,
          correctAnswer: row['q_correct_answer'] as String,
          hintTk: row['q_hint_tk'] as String?,
          imagePath: row['q_image_path'] as String?,
          options: optsByQuestion[qId] ?? [],
        ));
      }
    }

    return exerciseMap.keys.map((eId) {
      return Exercise.fromMap(exerciseMap[eId]!,
          questions: questionsByEx[eId]!);
    }).toList();
  }

  List<ExerciseQuestion> _groupQuestionRows(
      List<Map<String, dynamic>> rows) {
    final Map<int, ExerciseQuestion> questionMap = {};
    final Map<int, List<ExerciseOption>> optionsMap = {};

    for (final row in rows) {
      final qId = row['id'] as int;
      if (!questionMap.containsKey(qId)) {
        questionMap[qId] = ExerciseQuestion(
          id: qId,
          exerciseId: row['exercise_id'] as int,
          questionOrder: row['question_order'] as int? ?? 0,
          questionText: row['question_text'] as String,
          correctAnswer: row['correct_answer'] as String,
          hintTk: row['hint_tk'] as String?,
          imagePath: row['image_path'] as String?,
        );
        optionsMap[qId] = [];
      }
      if (row['o_id'] != null) {
        optionsMap[qId]!.add(ExerciseOption(
          id: row['o_id'] as int,
          questionId: qId,
          optionText: row['o_option_text'] as String,
          isCorrect: (row['o_is_correct'] as int? ?? 0) == 1,
        ));
      }
    }

    return questionMap.keys
        .map((qId) => questionMap[qId]!.copyWith(options: optionsMap[qId]))
        .toList();
  }

  List<GrammarRule> _groupGrammarRows(List<Map<String, dynamic>> rows) {
    final Map<int, Map<String, dynamic>> grammarMap = {};
    final Map<int, List<GrammarTableRow>> rowsMap = {};

    for (final row in rows) {
      final gId = row['g_id'] as int;
      if (!grammarMap.containsKey(gId)) {
        grammarMap[gId] = {
          'id': gId,
          'lesson_id': row['g_lesson_id'],
          'table_number': row['g_table_number'],
          'title_ru': row['g_title_ru'],
          'title_tk': row['g_title_tk'],
          'explanation_tk': row['g_explanation_tk'],
          'note_tk': row['g_note_tk'],
          'rule_type': row['g_rule_type'],
          'image_path': row['g_image_path'],
          'order_index': row['g_order_index'],
        };
        rowsMap[gId] = [];
      }
      if (row['r_id'] != null) {
        // GrammarTableRow.fromMap formatyna öwür
        rowsMap[gId]!.add(GrammarTableRow.fromMap({
          'id': row['r_id'],
          'grammar_id': gId,
          'row_order': row['r_row_order'],
          'is_header': row['r_is_header'],
          'cell_1': row['r_cell_1'],
          'cell_2': row['r_cell_2'],
          'cell_3': row['r_cell_3'],
          'cell_4': row['r_cell_4'],
          'cell_5': row['r_cell_5'],
          'cell_6': row['r_cell_6'],
          'cell_7': row['r_cell_7'],
          'red_cells': row['r_red_cells'],
        }));
      }
    }

    return grammarMap.keys.map((gId) {
      return GrammarRule.fromMap(grammarMap[gId]!, rows: rowsMap[gId]!);
    }).toList();
  }
}
