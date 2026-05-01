import '../database/database_service.dart';
import '../models/exercise.dart';
import '../models/grammar_rule.dart';
import '../../core/constants/db_constants.dart';

class ExerciseRepository {
  final DatabaseService _db;

  ExerciseRepository(this._db);

  // ── Exercises ────────────────────────────────────────────

  Future<List<Exercise>> getExercisesForLesson(int lessonId) async {
    final maps = await _db.query(
      DbConstants.tExercises,
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
      orderBy: DbConstants.colOrderIndex,
    );

    final exercises = <Exercise>[];
    for (final map in maps) {
      final exerciseId = map[DbConstants.colId] as int;
      final questions = await _getQuestionsForExercise(exerciseId);
      exercises.add(Exercise.fromMap(map, questions: questions));
    }
    return exercises;
  }

  Future<Exercise?> getExerciseById(int exerciseId) async {
    final maps = await _db.query(
      DbConstants.tExercises,
      where: '${DbConstants.colId} = ?',
      whereArgs: [exerciseId],
    );
    if (maps.isEmpty) return null;
    final questions = await _getQuestionsForExercise(exerciseId);
    return Exercise.fromMap(maps.first, questions: questions);
  }

  Future<List<ExerciseQuestion>> getQuestionsForExercise(int exerciseId) {
    return _getQuestionsForExercise(exerciseId);
  }

  Future<List<ExerciseQuestion>> _getQuestionsForExercise(
      int exerciseId) async {
    final maps = await _db.query(
      DbConstants.tExerciseQuestions,
      where: '${DbConstants.colExerciseId} = ?',
      whereArgs: [exerciseId],
      orderBy: DbConstants.colQuestionOrder,
    );

    final questions = <ExerciseQuestion>[];
    for (final map in maps) {
      final questionId = map[DbConstants.colId] as int;
      final options = await _getOptionsForQuestion(questionId);
      questions.add(ExerciseQuestion.fromMap(map, options: options));
    }
    return questions;
  }

  Future<List<ExerciseOption>> _getOptionsForQuestion(int questionId) async {
    final maps = await _db.query(
      DbConstants.tExerciseOptions,
      where: '${DbConstants.colQuestionId} = ?',
      whereArgs: [questionId],
    );
    return maps.map((m) => ExerciseOption.fromMap(m)).toList();
  }

  // Get all questions for a lesson (across all exercises) shuffled
  Future<List<ExerciseQuestion>> getAllQuestionsForLesson(int lessonId,
      {ExerciseType? type}) async {
    final exercises = await getExercisesForLesson(lessonId);
    final filteredExercises = type != null
        ? exercises.where((e) => e.exerciseType == type).toList()
        : exercises;

    final allQuestions = <ExerciseQuestion>[];
    for (final exercise in filteredExercises) {
      allQuestions.addAll(exercise.questions);
    }
    allQuestions.shuffle();
    return allQuestions;
  }

  // ── Grammar Rules ────────────────────────────────────────

  Future<List<GrammarRule>> getGrammarRulesForLesson(int lessonId) async {
    final maps = await _db.query(
      DbConstants.tGrammarRules,
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
      orderBy: DbConstants.colOrderIndex,
    );

    final rules = <GrammarRule>[];
    for (final map in maps) {
      final grammarId = map[DbConstants.colId] as int;
      final rows = await _getTableRowsForGrammar(grammarId);
      rules.add(GrammarRule.fromMap(map, rows: rows));
    }
    return rules;
  }

  Future<List<GrammarTableRow>> _getTableRowsForGrammar(int grammarId) async {
    final maps = await _db.query(
      DbConstants.tGrammarTableRows,
      where: '${DbConstants.colGrammarId} = ?',
      whereArgs: [grammarId],
      orderBy: DbConstants.colRowOrder,
    );
    return maps.map((m) => GrammarTableRow.fromMap(m)).toList();
  }
}
