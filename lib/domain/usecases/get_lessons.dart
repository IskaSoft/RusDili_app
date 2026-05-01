import '../../data/models/lesson.dart';
import '../../data/models/user_progress.dart';
import '../../data/repositories/lesson_repository.dart';
import '../../data/repositories/progress_repository.dart';

class GetLessonsUseCase {
  final LessonRepository _lessonRepo;
  final ProgressRepository _progressRepo;

  GetLessonsUseCase(this._lessonRepo, this._progressRepo);

  /// Returns all lessons enriched with their progress
  Future<List<LessonWithProgress>> call() async {
    final lessons = await _lessonRepo.getAllLessons();
    final progressList = await _progressRepo.getAllLessonProgress();

    return lessons.map((lesson) {
      final progress = progressList.firstWhere(
        (p) => p.lessonId == lesson.id,
        orElse: () => LessonProgress(
          id: 0,
          lessonId: lesson.id,
          exercisesTotal: 3,
        ),
      );
      return LessonWithProgress(lesson: lesson, progress: progress);
    }).toList();
  }
}

class LessonWithProgress {
  final Lesson lesson;
  final LessonProgress progress;

  const LessonWithProgress({
    required this.lesson,
    required this.progress,
  });

  bool get isCompleted => progress.isCompleted;
  bool get isInProgress =>
      !isCompleted && progress.exercisesDone > 0;
  bool get isNotStarted =>
      !isCompleted && progress.exercisesDone == 0;
  double get progressPercent => progress.progressPercent;
}
