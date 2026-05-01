import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'lesson_provider.dart';
import '../../data/models/user_progress.dart';
// ADD THIS LINE:

// Re-export the stats provider with a cleaner name
final statsProvider = overallStatsProvider;

final refreshableProgressProvider = FutureProvider<List<LessonProgress>>((
  ref,
) async {
  final repo = ref.read(progressRepositoryProvider);
  return repo.getAllLessonProgress();
});

// Streak tracker (days studied consecutively)
class StreakNotifier extends StateNotifier<int> {
  StreakNotifier() : super(0) {
    _loadStreak();
  }

  void _loadStreak() {
    // In a real app, load from SharedPreferences
    state = 0;
  }

  void incrementStreak() {
    state = state + 1;
  }
}

final streakProvider = StateNotifierProvider<StreakNotifier, int>(
  (ref) => StreakNotifier(),
);
