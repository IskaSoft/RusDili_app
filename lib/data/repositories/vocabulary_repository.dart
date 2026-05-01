import '../database/database_service.dart';
import '../models/vocabulary.dart';
import '../../core/constants/db_constants.dart';

class VocabularyRepository {
  final DatabaseService _db;

  VocabularyRepository(this._db);

  Future<List<Vocabulary>> getAllVocabulary() async {
    final maps = await _db.query(DbConstants.tVocabulary);
    return maps.map((m) => Vocabulary.fromMap(m)).toList();
  }

  Future<List<Vocabulary>> getVocabularyForLesson(int lessonId) async {
    final maps = await _db.query(
      DbConstants.tVocabulary,
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
    );
    return maps.map((m) => Vocabulary.fromMap(m)).toList();
  }

  Future<List<Vocabulary>> getVocabularyByCategory(String category) async {
    final maps = await _db.query(
      DbConstants.tVocabulary,
      where: '${DbConstants.colCategory} = ?',
      whereArgs: [category],
    );
    return maps.map((m) => Vocabulary.fromMap(m)).toList();
  }

  Future<List<String>> getAllCategories() async {
    final maps = await _db.rawQuery(
      'SELECT DISTINCT ${DbConstants.colCategory} FROM ${DbConstants.tVocabulary} WHERE ${DbConstants.colCategory} IS NOT NULL',
    );
    return maps
        .map((m) => m[DbConstants.colCategory] as String)
        .toList();
  }

  Future<int> getTotalWordCount() async {
    final maps = await _db.rawQuery(
        'SELECT COUNT(*) as count FROM ${DbConstants.tVocabulary}');
    return maps.first['count'] as int? ?? 0;
  }

  Future<List<Vocabulary>> searchVocabulary(String query) async {
    final q = '%${query.toLowerCase()}%';
    final maps = await _db.rawQuery(
      '''SELECT * FROM ${DbConstants.tVocabulary}
         WHERE LOWER(${DbConstants.colWordRu}) LIKE ?
            OR LOWER(${DbConstants.colWordTk}) LIKE ?''',
      [q, q],
    );
    return maps.map((m) => Vocabulary.fromMap(m)).toList();
  }
}
