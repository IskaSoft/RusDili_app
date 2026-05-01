import '../../data/models/exercise.dart';

class CheckAnswerUseCase {
  /// Checks whether the given answer matches the correct answer.
  /// Supports multiple accepted answers separated by '/'.
  /// Case-insensitive and trims whitespace.
  bool call({
    required ExerciseQuestion question,
    required String answer,
  }) {
    return question.isCorrect(answer);
  }

  /// Returns score label based on percent
  static String scoreLabel(double percent) {
    if (percent >= 90) return 'Ajaýyp! 🏆';
    if (percent >= 75) return 'Gowy! 🎯';
    if (percent >= 60) return 'Bolýar 👍';
    if (percent >= 40) return 'Tagalla et 💪';
    return 'Gaýtadan synanyş! 📚';
  }

  /// Returns score color based on percent
  static String scoreEmoji(double percent) {
    if (percent >= 80) return '🏆';
    if (percent >= 60) return '🎯';
    return '💪';
  }
}
