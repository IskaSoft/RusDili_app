import '../database/database_service.dart';
import '../models/user_progress.dart';
import '../../core/constants/db_constants.dart';

class ProgressRepository {
  final DatabaseService _db;

  ProgressRepository(this._db);

  // ── User Progress ────────────────────────────────────────

  Future<void> saveAnswer({
    required int lessonId,
    required int exerciseId,
    required int questionId,
    required bool isCorrect,
    int? timeSpentSec,
  }) async {
    // GUARD: Skip if lessonId is invalid (0 or negative)
    if (lessonId <= 0) {
      await _saveUserProgressOnly(
        lessonId: lessonId,
        exerciseId: exerciseId,
        questionId: questionId,
        isCorrect: isCorrect,
        timeSpentSec: timeSpentSec,
      );
      return;
    }

    // Check if lesson exists before inserting lesson_progress
    final lessonExists = await _lessonExists(lessonId);
    if (!lessonExists) {
      await _saveUserProgressOnly(
        lessonId: lessonId,
        exerciseId: exerciseId,
        questionId: questionId,
        isCorrect: isCorrect,
        timeSpentSec: timeSpentSec,
      );
      return;
    }

    await _saveUserProgressOnly(
      lessonId: lessonId,
      exerciseId: exerciseId,
      questionId: questionId,
      isCorrect: isCorrect,
      timeSpentSec: timeSpentSec,
    );

    await _updateLessonProgress(lessonId);
  }

  /// Save only to user_progress (no FK constraints here)
  Future<void> _saveUserProgressOnly({
    required int lessonId,
    required int exerciseId,
    required int questionId,
    required bool isCorrect,
    int? timeSpentSec,
  }) async {
    final existing = await _db.query(
      DbConstants.tUserProgress,
      where: '${DbConstants.colQuestionId} = ?',
      whereArgs: [questionId],
    );

    if (existing.isEmpty) {
      await _db.insert(DbConstants.tUserProgress, {
        DbConstants.colLessonId: lessonId,
        DbConstants.colExerciseId: exerciseId,
        DbConstants.colQuestionId: questionId,
        DbConstants.colIsCorrect: isCorrect ? 1 : 0,
        DbConstants.colAttempts: 1,
        DbConstants.colCompletedAt: DateTime.now().toIso8601String(),
        DbConstants.colTimeSpentSec: timeSpentSec,
      });
    } else {
      final current = existing.first;
      final attempts = (current[DbConstants.colAttempts] as int? ?? 0) + 1;
      await _db.update(
        DbConstants.tUserProgress,
        {
          DbConstants.colIsCorrect: isCorrect ? 1 : 0,
          DbConstants.colAttempts: attempts,
          DbConstants.colCompletedAt: DateTime.now().toIso8601String(),
        },
        '${DbConstants.colQuestionId} = ?',
        [questionId],
      );
    }
  }

  Future<bool> _lessonExists(int lessonId) async {
    final result = await _db.query(
      DbConstants.tLessons,
      where: '${DbConstants.colId} = ?',
      whereArgs: [lessonId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<void> _updateLessonProgress(int lessonId) async {
    if (lessonId <= 0) return; // Skip invalid IDs

    final lessonExists = await _lessonExists(lessonId);
    if (!lessonExists) return; // Skip if lesson doesn't exist

    final results = await _db.rawQuery(
      '''
      SELECT 
        COUNT(*) as total,
        SUM(CASE WHEN is_correct = 1 THEN 1 ELSE 0 END) as correct
      FROM ${DbConstants.tUserProgress}
      WHERE ${DbConstants.colLessonId} = ?
    ''',
      [lessonId],
    );

    if (results.isEmpty) return;

    final total = results.first['total'] as int? ?? 0;
    final correct = results.first['correct'] as int? ?? 0;
    final scorePercent = total > 0 ? (correct / total) * 100 : 0.0;

    final existing = await _db.query(
      DbConstants.tLessonProgress,
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
    );

    if (existing.isEmpty) {
      await _db.insert(DbConstants.tLessonProgress, {
        DbConstants.colLessonId: lessonId,
        DbConstants.colExercisesDone: total,
        DbConstants.colScorePercent: scorePercent,
        DbConstants.colLastStudied: DateTime.now().toIso8601String(),
      });
    } else {
      await _db.update(
        DbConstants.tLessonProgress,
        {
          DbConstants.colExercisesDone: total,
          DbConstants.colScorePercent: scorePercent,
          DbConstants.colLastStudied: DateTime.now().toIso8601String(),
        },
        '${DbConstants.colLessonId} = ?',
        [lessonId],
      );
    }
  }

  // ── Lesson Progress ──────────────────────────────────────

  Future<LessonProgress?> getLessonProgress(int lessonId) async {
    final maps = await _db.query(
      DbConstants.tLessonProgress,
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
    );
    if (maps.isEmpty) return null;
    return LessonProgress.fromMap(maps.first);
  }

  Future<List<LessonProgress>> getAllLessonProgress() async {
    final maps = await _db.query(DbConstants.tLessonProgress);
    return maps.map((m) => LessonProgress.fromMap(m)).toList();
  }

  Future<void> markVocabStudied(int lessonId, int count) async {
    final existing = await _db.query(
      DbConstants.tLessonProgress,
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
    );

    if (existing.isEmpty) {
      await _db.insert(DbConstants.tLessonProgress, {
        DbConstants.colLessonId: lessonId,
        DbConstants.colVocabStudied: count,
        DbConstants.colLastStudied: DateTime.now().toIso8601String(),
      });
    } else {
      await _db.update(
        DbConstants.tLessonProgress,
        {
          DbConstants.colVocabStudied: count,
          DbConstants.colLastStudied: DateTime.now().toIso8601String(),
        },
        '${DbConstants.colLessonId} = ?',
        [lessonId],
      );
    }
  }

  Future<void> markDialogRead(int lessonId) async {
    final existing = await _db.query(
      DbConstants.tLessonProgress,
      where: '${DbConstants.colLessonId} = ?',
      whereArgs: [lessonId],
    );

    if (existing.isNotEmpty) {
      final current = existing.first;
      final dialogsRead =
          (current[DbConstants.colDialogsRead] as int? ?? 0) + 1;
      await _db.update(
        DbConstants.tLessonProgress,
        {
          DbConstants.colDialogsRead: dialogsRead,
          DbConstants.colLastStudied: DateTime.now().toIso8601String(),
        },
        '${DbConstants.colLessonId} = ?',
        [lessonId],
      );
    }
  }

  Future<void> markLessonCompleted(int lessonId) async {
    await _db.update(
      DbConstants.tLessonProgress,
      {
        DbConstants.colIsCompleted: 1,
        DbConstants.colLastStudied: DateTime.now().toIso8601String(),
      },
      '${DbConstants.colLessonId} = ?',
      [lessonId],
    );
  }

  // ── Stats ────────────────────────────────────────────────

  Future<Map<String, dynamic>> getOverallStats() async {
    final progressList = await getAllLessonProgress();
    final completedLessons = progressList.where((p) => p.isCompleted).length;
    final totalVocabStudied = progressList.fold<int>(
      0,
      (sum, p) => sum + p.vocabStudied,
    );

    final allProgress = await _db.query(DbConstants.tUserProgress);
    final totalAnswered = allProgress.length;
    final correctAnswers = allProgress
        .where((p) => (p[DbConstants.colIsCorrect] as int) == 1)
        .length;

    final avgScore =
        totalAnswered > 0 ? (correctAnswers / totalAnswered) * 100 : 0.0;

    // DÜZEDIŞ #5: 'totalLessons: 10' hardcoded däl — A2/B1 goşulanda
    // ýalňyş görkezerdi. Indi DB-den dinamiki alynýar.
    final lessonCountResult = await _db.rawQuery(
      'SELECT COUNT(*) as cnt FROM ${DbConstants.tLessons}',
    );
    final totalLessons =
        lessonCountResult.first['cnt'] as int? ?? 10;

    return {
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'totalVocabStudied': totalVocabStudied,
      'totalAnswered': totalAnswered,
      'correctAnswers': correctAnswers,
      'avgScore': avgScore,
      'overallPercent':
          totalLessons > 0 ? (completedLessons / totalLessons) * 100 : 0.0,
    };
  }

  Future<void> resetLessonProgress(int lessonId) async {
    await _db.delete(
      DbConstants.tUserProgress,
      '${DbConstants.colLessonId} = ?',
      [lessonId],
    );
    await _db.update(
      DbConstants.tLessonProgress,
      {
        DbConstants.colVocabStudied: 0,
        DbConstants.colDialogsRead: 0,
        DbConstants.colExercisesDone: 0,
        DbConstants.colScorePercent: 0.0,
        DbConstants.colIsCompleted: 0,
        DbConstants.colLastStudied: null,
      },
      '${DbConstants.colLessonId} = ?',
      [lessonId],
    );
  }
}
