import '../database/database_service.dart';
import '../models/lesson.dart';
import '../models/vocabulary.dart';
import '../models/dialog_model.dart';
import '../models/reading_text.dart';
import '../../core/constants/db_constants.dart';

class LessonRepository {
  final DatabaseService _db;

  LessonRepository(this._db);

  // ── Lessons ──────────────────────────────────────────────

  // DÜZEDIŞ: image_blob sütünini soraga goşmadyk.
  // Öňki kod ähli sütünleri çekýärdi — BLOB hem RAM-a girýärdi.
  // Indi diňe gerekli sütünler saýlanýar.
  Future<List<Lesson>> getAllLessons() async {
    final maps = await _db.query(
      DbConstants.tLessons,
      columns: [
        DbConstants.colId,
        DbConstants.colSapakNumber,
        DbConstants.colTitleRu,
        DbConstants.colTitleTk,
        DbConstants.colSubtitleTk,
        DbConstants.colDescriptionTk,
        DbConstants.colImagePath,
        DbConstants.colIsCompleted,
        DbConstants.colOrderIndex,
      ],
      orderBy: DbConstants.colOrderIndex,
    );
    return maps.map((m) => Lesson.fromMap(m)).toList();
  }

  Future<Lesson?> getLessonById(int id) async {
    final maps = await _db.query(
      DbConstants.tLessons,
      columns: [
        DbConstants.colId,
        DbConstants.colSapakNumber,
        DbConstants.colTitleRu,
        DbConstants.colTitleTk,
        DbConstants.colSubtitleTk,
        DbConstants.colDescriptionTk,
        DbConstants.colImagePath,
        DbConstants.colIsCompleted,
        DbConstants.colOrderIndex,
      ],
      where: '${DbConstants.colId} = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Lesson.fromMap(maps.first);
  }

  Future<void> markLessonCompleted(int lessonId) async {
    await _db.update(
      DbConstants.tLessons,
      {DbConstants.colIsCompleted: 1},
      '${DbConstants.colId} = ?',
      [lessonId],
    );
  }

  // ── Vocabulary ───────────────────────────────────────────

  Future<List<Vocabulary>> getVocabularyForLesson(int lessonId) async {
    // DÜZEDIŞ: image_blob çekilmeýär — diňe tekst we metadata.
    final maps = await _db.query(
      DbConstants.tVocabulary,
      columns: [
        DbConstants.colId,
        DbConstants.colLessonId,
        DbConstants.colWordRu,
        DbConstants.colWordTk,
        DbConstants.colExampleRu,
        DbConstants.colExampleTk,
        DbConstants.colImagePath,
        DbConstants.colAudioPath,
        DbConstants.colCategory,
        DbConstants.colDifficulty,
      ],
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
    );
    return maps.map((m) => Vocabulary.fromMap(m)).toList();
  }

  Future<List<Vocabulary>> getVocabularyByCategory(
    int lessonId,
    String category,
  ) async {
    final maps = await _db.query(
      DbConstants.tVocabulary,
      columns: [
        DbConstants.colId,
        DbConstants.colLessonId,
        DbConstants.colWordRu,
        DbConstants.colWordTk,
        DbConstants.colExampleRu,
        DbConstants.colExampleTk,
        DbConstants.colImagePath,
        DbConstants.colAudioPath,
        DbConstants.colCategory,
        DbConstants.colDifficulty,
      ],
      where:
          '${DbConstants.colLessonId} = ? AND ${DbConstants.colCategory} = ?',
      whereArgs: [lessonId, category],
    );
    return maps.map((m) => Vocabulary.fromMap(m)).toList();
  }

  Future<List<Vocabulary>> getAllVocabulary() async {
    final maps = await _db.query(
      DbConstants.tVocabulary,
      columns: [
        DbConstants.colId,
        DbConstants.colLessonId,
        DbConstants.colWordRu,
        DbConstants.colWordTk,
        DbConstants.colExampleRu,
        DbConstants.colExampleTk,
        DbConstants.colImagePath,
        DbConstants.colAudioPath,
        DbConstants.colCategory,
        DbConstants.colDifficulty,
      ],
    );
    return maps.map((m) => Vocabulary.fromMap(m)).toList();
  }

  // ── Dialogs ──────────────────────────────────────────────

  // DÜZEDIŞ: N+1 sorag ýok edildi.
  // Öňki kod: 1 dialog soragy + her dialog üçin 1 lines soragy
  //   → 5 dialog = 6 SQL sorag
  // Täze kod: JOIN bilen 1 SQL soragyň içinde ähli setir gelýär
  //   → 5 dialog = 1 SQL sorag
  Future<List<DialogModel>> getDialogsForLesson(int lessonId) async {
    const sql = '''
      SELECT
        d.id            AS d_id,
        d.lesson_id     AS d_lesson_id,
        d.dialog_number AS d_dialog_number,
        d.dialog_name   AS d_dialog_name,
        d.context_tk    AS d_context_tk,
        d.image_path    AS d_image_path,
        l.id            AS l_id,
        l.line_order    AS l_line_order,
        l.speaker       AS l_speaker,
        l.text_ru       AS l_text_ru,
        l.text_tk       AS l_text_tk
      FROM dialogs d
      LEFT JOIN dialog_lines l ON l.dialog_id = d.id
      WHERE d.lesson_id = ?
      ORDER BY d.dialog_number, l.line_order
    ''';

    final rows = await _db.rawQuery(sql, [lessonId]);
    return _groupDialogRows(rows);
  }

  Future<DialogModel?> getDialogById(int dialogId) async {
    const sql = '''
      SELECT
        d.id            AS d_id,
        d.lesson_id     AS d_lesson_id,
        d.dialog_number AS d_dialog_number,
        d.dialog_name   AS d_dialog_name,
        d.context_tk    AS d_context_tk,
        d.image_path    AS d_image_path,
        l.id            AS l_id,
        l.line_order    AS l_line_order,
        l.speaker       AS l_speaker,
        l.text_ru       AS l_text_ru,
        l.text_tk       AS l_text_tk
      FROM dialogs d
      LEFT JOIN dialog_lines l ON l.dialog_id = d.id
      WHERE d.id = ?
      ORDER BY l.line_order
    ''';
    final rows = await _db.rawQuery(sql, [dialogId]);
    final dialogs = _groupDialogRows(rows);
    return dialogs.isEmpty ? null : dialogs.first;
  }

  Future<List<DialogModel>> getAllDialogs() async {
    const sql = '''
      SELECT
        d.id            AS d_id,
        d.lesson_id     AS d_lesson_id,
        d.dialog_number AS d_dialog_number,
        d.dialog_name   AS d_dialog_name,
        d.context_tk    AS d_context_tk,
        d.image_path    AS d_image_path,
        l.id            AS l_id,
        l.line_order    AS l_line_order,
        l.speaker       AS l_speaker,
        l.text_ru       AS l_text_ru,
        l.text_tk       AS l_text_tk
      FROM dialogs d
      LEFT JOIN dialog_lines l ON l.dialog_id = d.id
      ORDER BY d.lesson_id, d.dialog_number, l.line_order
    ''';
    final rows = await _db.rawQuery(sql);
    return _groupDialogRows(rows);
  }

  // JOIN netijesini DialogModel-e öwür
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
      // LEFT JOIN — setir ýok bolsa l_id null bolýar
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

  // ── Reading Texts ────────────────────────────────────────

  Future<ReadingText?> getReadingTextForLesson(int lessonId) async {
    final maps = await _db.query(
      DbConstants.tReadingTexts,
      columns: [
        DbConstants.colId,
        DbConstants.colLessonId,
        DbConstants.colTitleRu,
        'content_ru',
        DbConstants.colImagePath,
      ],
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
    );
    if (maps.isEmpty) return null;
    return ReadingText.fromMap(maps.first);
  }
}
