import '../../data/repositories/progress_repository.dart';

class SaveProgressUseCase {
  final ProgressRepository _repo;

  SaveProgressUseCase(this._repo);

  Future<void> saveAnswer({
    required int lessonId,
    required int exerciseId,
    required int questionId,
    required bool isCorrect,
    int? timeSpentSec,
  }) async {
    await _repo.saveAnswer(
      lessonId: lessonId,
      exerciseId: exerciseId,
      questionId: questionId,
      isCorrect: isCorrect,
      timeSpentSec: timeSpentSec,
    );
  }

  Future<void> markVocabStudied(int lessonId, int count) async {
    await _repo.markVocabStudied(lessonId, count);
  }

  Future<void> markDialogRead(int lessonId) async {
    await _repo.markDialogRead(lessonId);
  }

  Future<void> markLessonComplete(int lessonId) async {
    await _repo.markLessonCompleted(lessonId);
  }

  Future<void> reset(int lessonId) async {
    await _repo.resetLessonProgress(lessonId);
  }
}
