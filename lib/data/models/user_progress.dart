import '../../core/constants/db_constants.dart';

class UserProgress {
  final int id;
  final int? lessonId;
  final int? exerciseId;
  final int? questionId;
  final bool isCorrect;
  final int attempts;
  final String? completedAt;
  final int? timeSpentSec;

  const UserProgress({
    required this.id,
    this.lessonId,
    this.exerciseId,
    this.questionId,
    required this.isCorrect,
    this.attempts = 1,
    this.completedAt,
    this.timeSpentSec,
  });

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      id: map[DbConstants.colId] as int,
      lessonId: map[DbConstants.colLessonId] as int?,
      exerciseId: map[DbConstants.colExerciseId] as int?,
      questionId: map[DbConstants.colQuestionId] as int?,
      isCorrect: (map[DbConstants.colIsCorrect] as int? ?? 0) == 1,
      attempts: map[DbConstants.colAttempts] as int? ?? 1,
      completedAt: map[DbConstants.colCompletedAt] as String?,
      timeSpentSec: map[DbConstants.colTimeSpentSec] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbConstants.colLessonId: lessonId,
      DbConstants.colExerciseId: exerciseId,
      DbConstants.colQuestionId: questionId,
      DbConstants.colIsCorrect: isCorrect ? 1 : 0,
      DbConstants.colAttempts: attempts,
      DbConstants.colCompletedAt: completedAt,
      DbConstants.colTimeSpentSec: timeSpentSec,
    };
  }
}

class LessonProgress {
  final int id;
  final int lessonId;
  final int vocabStudied;
  final int dialogsRead;
  final int exercisesDone;
  final int exercisesTotal;
  final double scorePercent;
  final bool isCompleted;
  final String? lastStudied;

  const LessonProgress({
    required this.id,
    required this.lessonId,
    this.vocabStudied = 0,
    this.dialogsRead = 0,
    this.exercisesDone = 0,
    this.exercisesTotal = 0,
    this.scorePercent = 0.0,
    this.isCompleted = false,
    this.lastStudied,
  });

  double get progressPercent {
    if (exercisesTotal == 0) return 0;
    return (exercisesDone / exercisesTotal).clamp(0.0, 1.0);
  }

  factory LessonProgress.fromMap(Map<String, dynamic> map) {
    return LessonProgress(
      id: map[DbConstants.colId] as int,
      lessonId: map[DbConstants.colLessonId] as int,
      vocabStudied: map[DbConstants.colVocabStudied] as int? ?? 0,
      dialogsRead: map[DbConstants.colDialogsRead] as int? ?? 0,
      exercisesDone: map[DbConstants.colExercisesDone] as int? ?? 0,
      exercisesTotal: map[DbConstants.colExercisesTotal] as int? ?? 0,
      scorePercent: (map[DbConstants.colScorePercent] as num?)?.toDouble() ?? 0.0,
      isCompleted: (map[DbConstants.colIsCompleted] as int? ?? 0) == 1,
      lastStudied: map[DbConstants.colLastStudied] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbConstants.colLessonId: lessonId,
      DbConstants.colVocabStudied: vocabStudied,
      DbConstants.colDialogsRead: dialogsRead,
      DbConstants.colExercisesDone: exercisesDone,
      DbConstants.colExercisesTotal: exercisesTotal,
      DbConstants.colScorePercent: scorePercent,
      DbConstants.colIsCompleted: isCompleted ? 1 : 0,
      DbConstants.colLastStudied: lastStudied,
    };
  }

  LessonProgress copyWith({
    int? vocabStudied,
    int? dialogsRead,
    int? exercisesDone,
    int? exercisesTotal,
    double? scorePercent,
    bool? isCompleted,
    String? lastStudied,
  }) {
    return LessonProgress(
      id: id,
      lessonId: lessonId,
      vocabStudied: vocabStudied ?? this.vocabStudied,
      dialogsRead: dialogsRead ?? this.dialogsRead,
      exercisesDone: exercisesDone ?? this.exercisesDone,
      exercisesTotal: exercisesTotal ?? this.exercisesTotal,
      scorePercent: scorePercent ?? this.scorePercent,
      isCompleted: isCompleted ?? this.isCompleted,
      lastStudied: lastStudied ?? this.lastStudied,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LessonProgress && other.lessonId == lessonId;

  @override
  int get hashCode => lessonId.hashCode;
}
