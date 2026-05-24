import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dialog_model.dart';
import '../../data/models/vocabulary.dart';
import '../../data/models/exercise.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../core/constants/db_constants.dart';
import 'lesson_provider.dart';

// ── Favorites Repository ─────────────────────────────────────

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository(ref.watch(databaseServiceProvider));
});

// ── Gündelik Frazalar — category='phrase' ───────────────────

final phraseDialogsProvider = FutureProvider<List<DialogModel>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  const sql = '''
    SELECT
      d.id AS d_id, d.lesson_id AS d_lesson_id,
      d.dialog_number AS d_dialog_number, d.dialog_name AS d_dialog_name,
      d.context_tk AS d_context_tk, d.image_path AS d_image_path,
      l.id AS l_id, l.line_order AS l_line_order, l.speaker AS l_speaker,
      l.text_ru AS l_text_ru, l.text_tk AS l_text_tk
    FROM dialogs d
    LEFT JOIN dialog_lines l ON l.dialog_id = d.id
    WHERE d.category = 'phrase'
    ORDER BY d.dialog_number, l.line_order
  ''';
  final rows = await db.rawQuery(sql);
  return _groupDialogRows(rows);
});

// ── Ýagdaý Dialoglar — category='situational' ───────────────

final situationalDialogsProvider =
    FutureProvider<List<DialogModel>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  const sql = '''
    SELECT
      d.id AS d_id, d.lesson_id AS d_lesson_id,
      d.dialog_number AS d_dialog_number, d.dialog_name AS d_dialog_name,
      d.context_tk AS d_context_tk, d.image_path AS d_image_path,
      l.id AS l_id, l.line_order AS l_line_order, l.speaker AS l_speaker,
      l.text_ru AS l_text_ru, l.text_tk AS l_text_tk
    FROM dialogs d
    LEFT JOIN dialog_lines l ON l.dialog_id = d.id
    WHERE d.category = 'situational'
    ORDER BY d.dialog_number, l.line_order
  ''';
  final rows = await db.rawQuery(sql);
  return _groupDialogRows(rows);
});

// ── Iň köp ulanylýan sözler — category='top_words' ──────────

final topWordsProvider = FutureProvider<List<Vocabulary>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  final rows = await db.rawQuery('''
    SELECT * FROM vocabulary
    WHERE category = 'top_words'
    ORDER BY difficulty ASC, word_ru ASC
  ''');
  return rows.map((r) => Vocabulary.fromMap(r)).toList();
});

// ── Iň köp ulanylýan işlikler — category='top_verbs' ────────

final topVerbsProvider = FutureProvider<List<Vocabulary>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  final rows = await db.rawQuery('''
    SELECT * FROM vocabulary
    WHERE category = '${DbConstants.vocabCategoryTopVerbs}'
    ORDER BY word_ru ASC
  ''');
  return rows.map((r) => Vocabulary.fromMap(r)).toList();
});

// ── Iň köp aýdylýan sözler — category='top_phrases' ─────────

final topPhrasesVocabProvider = FutureProvider<List<Vocabulary>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  final rows = await db.rawQuery('''
    SELECT * FROM vocabulary
    WHERE category = '${DbConstants.vocabCategoryTopPhrases}'
    ORDER BY word_ru ASC
  ''');
  return rows.map((r) => Vocabulary.fromMap(r)).toList();
});

// ── Baglaýjy sözler — category='connectors' ─────────────────

final connectorsProvider = FutureProvider<List<Vocabulary>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  final rows = await db.rawQuery('''
    SELECT * FROM vocabulary
    WHERE category = '${DbConstants.vocabCategoryConnectors}'
    ORDER BY word_ru ASC
  ''');
  return rows.map((r) => Vocabulary.fromMap(r)).toList();
});

// ── Söz düzümleri — category='phrases' ──────────────────────

final wordPhrasesProvider = FutureProvider<List<Vocabulary>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  final rows = await db.rawQuery('''
    SELECT * FROM vocabulary
    WHERE category = 'phrases'
    ORDER BY word_ru ASC
  ''');
  return rows.map((r) => Vocabulary.fromMap(r)).toList();
});

// ── A→Z Sözlük — ähli sözler elipbiý tertibinde ─────────────

final dictionaryProvider =
    FutureProvider.family<List<Vocabulary>, String>((ref, search) async {
  final db = ref.watch(databaseServiceProvider);
  // Gözleg bar bolsa süzgüç goş
  final whereClause = search.isEmpty
      ? ''
      : "AND (word_ru LIKE '%$search%' OR word_tk LIKE '%$search%')";
  final rows = await db.rawQuery('''
    SELECT * FROM vocabulary
    WHERE lesson_id IS NOT NULL $whereClause
    ORDER BY word_ru COLLATE NOCASE ASC
  ''');
  return rows.map((r) => Vocabulary.fromMap(r)).toList();
});

// ── Özbaşdak gönükmeler — is_standalone=1 ───────────────────

final standaloneExercisesProvider =
    FutureProvider<List<Exercise>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  const exSql = '''
    SELECT
      e.id AS e_id, e.lesson_id AS e_lesson_id,
      e.exercise_number AS e_exercise_number, e.title_tk AS e_title_tk,
      e.instruction_tk AS e_instruction_tk, e.exercise_type AS e_exercise_type,
      e.note_tk AS e_note_tk, e.order_index AS e_order_index,
      q.id AS q_id, q.question_order AS q_question_order,
      q.question_text AS q_question_text, q.correct_answer AS q_correct_answer,
      q.hint_tk AS q_hint_tk, q.image_path AS q_image_path
    FROM exercises e
    LEFT JOIN exercise_questions q ON q.exercise_id = e.id
    WHERE e.is_standalone = 1
    ORDER BY e.order_index, q.question_order
  ''';
  const optSql = '''
    SELECT o.id AS o_id, o.question_id AS o_question_id,
           o.option_text AS o_option_text, o.is_correct AS o_is_correct
    FROM exercise_options o
    INNER JOIN exercise_questions q ON q.id = o.question_id
    INNER JOIN exercises e ON e.id = q.exercise_id
    WHERE e.is_standalone = 1
  ''';
  final exRows = await db.rawQuery(exSql);
  final optRows = await db.rawQuery(optSql);

  // ExerciseRepository-daky _groupExerciseRows-y göni ulanýarys
  final repo = ref.watch(exerciseRepositoryProvider);
  return repo.groupExerciseRowsPublic(exRows, optRows);
});

// ── Saýlananlar ──────────────────────────────────────────────

final favoriteIdsProvider =
    FutureProvider.family<Set<int>, String>((ref, itemType) async {
  final repo = ref.watch(favoritesRepositoryProvider);
  return repo.getFavoriteIds(itemType);
});

// Toggle — AsyncNotifier bilen real-time toggle
class FavoriteToggleNotifier
    extends FamilyAsyncNotifier<bool, ({String type, int id})> {
  @override
  Future<bool> build(({String type, int id}) arg) async {
    final repo = ref.watch(favoritesRepositoryProvider);
    return repo.isFavorite(arg.type, arg.id);
  }

  Future<void> toggle() async {
    final repo = ref.read(favoritesRepositoryProvider);
    final arg = this.arg;
    final newState = await repo.toggle(arg.type, arg.id);
    state = AsyncData(newState);
    // favoriteIdsProvider-y täzele
    ref.invalidate(favoriteIdsProvider(arg.type));
  }
}

final favoriteToggleProvider = AsyncNotifierProviderFamily<
    FavoriteToggleNotifier, bool, ({String type, int id})>(
  FavoriteToggleNotifier.new,
);

// ── Saýlanan dialoglar ───────────────────────────────────────

final favoriteDialogsProvider =
    FutureProvider<List<DialogModel>>((ref) async {
  final ids = await ref.watch(
    favoriteIdsProvider(DbConstants.favTypeDialog).future,
  );
  if (ids.isEmpty) return [];
  final db = ref.watch(databaseServiceProvider);
  final idList = ids.join(',');
  const sql = '''
    SELECT
      d.id AS d_id, d.lesson_id AS d_lesson_id,
      d.dialog_number AS d_dialog_number, d.dialog_name AS d_dialog_name,
      d.context_tk AS d_context_tk, d.image_path AS d_image_path,
      l.id AS l_id, l.line_order AS l_line_order, l.speaker AS l_speaker,
      l.text_ru AS l_text_ru, l.text_tk AS l_text_tk
    FROM dialogs d
    LEFT JOIN dialog_lines l ON l.dialog_id = d.id
    WHERE d.id IN
  ''';
  final rows = await db.rawQuery('$sql($idList) ORDER BY d.dialog_number, l.line_order');
  return _groupDialogRows(rows);
});

// ── Saýlanan sözler ──────────────────────────────────────────

final favoriteWordsProvider = FutureProvider<List<Vocabulary>>((ref) async {
  final ids = await ref.watch(
    favoriteIdsProvider(DbConstants.favTypeWord).future,
  );
  if (ids.isEmpty) return [];
  final db = ref.watch(databaseServiceProvider);
  final idList = ids.join(',');
  final rows = await db.rawQuery(
    'SELECT * FROM vocabulary WHERE id IN ($idList) ORDER BY word_ru',
  );
  return rows.map((r) => Vocabulary.fromMap(r)).toList();
});

// ── Gözleg state ─────────────────────────────────────────────

final dictionarySearchProvider = StateProvider<String>((ref) => '');

// ── Helper — JOIN rows → DialogModel list ────────────────────

List<DialogModel> _groupDialogRows(List<Map<String, dynamic>> rows) {
  final Map<int, Map<String, dynamic>> dialogMap = {};
  final Map<int, List<Map<String, dynamic>>> linesMap = {};

  for (final row in rows) {
    final dId = row['d_id'] as int;
    if (!dialogMap.containsKey(dId)) {
      dialogMap[dId] = {
        'id': dId,
        'lesson_id': row['d_lesson_id'],
        'dialog_number': row['d_dialog_number'],
        'dialog_name': row['d_dialog_name'],
        'context_tk': row['d_context_tk'],
        'image_path': row['d_image_path'],
      };
      linesMap[dId] = [];
    }
    if (row['l_id'] != null) {
      linesMap[dId]!.add({
        'id': row['l_id'],
        'dialog_id': dId,
        'line_order': row['l_line_order'],
        'speaker': row['l_speaker'],
        'text_ru': row['l_text_ru'],
        'text_tk': row['l_text_tk'],
      });
    }
  }

  return dialogMap.keys.map((dId) {
    final lines = linesMap[dId]!.map((l) => DialogLine.fromMap(l)).toList();
    return DialogModel.fromMap(dialogMap[dId]!, lines: lines);
  }).toList();
}
