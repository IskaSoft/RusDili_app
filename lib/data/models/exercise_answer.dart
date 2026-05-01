/// Represents a user's answer attempt to a single exercise question.
/// Used for in-memory tracking during a practice session.
class ExerciseAnswer {
  final int questionId;
  final int exerciseId;
  final int lessonId;
  final String givenAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final int attemptNumber;
  final DateTime answeredAt;
  final int? timeSpentSec;

  const ExerciseAnswer({
    required this.questionId,
    required this.exerciseId,
    required this.lessonId,
    required this.givenAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    this.attemptNumber = 1,
    required this.answeredAt,
    this.timeSpentSec,
  });

  factory ExerciseAnswer.create({
    required int questionId,
    required int exerciseId,
    required int lessonId,
    required String givenAnswer,
    required String correctAnswer,
    int attemptNumber = 1,
    int? timeSpentSec,
  }) {
    final given = givenAnswer.trim().toLowerCase();
    final accepted = correctAnswer
        .split('/')
        .map((a) => a.trim().toLowerCase())
        .toList();

    return ExerciseAnswer(
      questionId: questionId,
      exerciseId: exerciseId,
      lessonId: lessonId,
      givenAnswer: givenAnswer,
      correctAnswer: correctAnswer,
      isCorrect: accepted.contains(given),
      attemptNumber: attemptNumber,
      answeredAt: DateTime.now(),
      timeSpentSec: timeSpentSec,
    );
  }

  @override
  String toString() =>
      'ExerciseAnswer(q:$questionId, correct:$isCorrect, given:"$givenAnswer")';
}

/// Summary of a completed practice session
class PracticeSessionResult {
  final int lessonId;
  final List<ExerciseAnswer> answers;
  final DateTime startedAt;
  final DateTime finishedAt;

  const PracticeSessionResult({
    required this.lessonId,
    required this.answers,
    required this.startedAt,
    required this.finishedAt,
  });

  int get totalAnswered => answers.length;
  int get correctCount => answers.where((a) => a.isCorrect).length;
  int get incorrectCount => answers.where((a) => !a.isCorrect).length;

  double get scorePercent =>
      totalAnswered == 0 ? 0 : (correctCount / totalAnswered) * 100;

  Duration get sessionDuration => finishedAt.difference(startedAt);

  bool get isPassed => scorePercent >= 70;

  List<ExerciseAnswer> get wrongAnswers =>
      answers.where((a) => !a.isCorrect).toList();
}
