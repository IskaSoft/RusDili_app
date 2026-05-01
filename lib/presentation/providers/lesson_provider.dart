import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/database_service.dart';
import '../../data/repositories/lesson_repository.dart';
import '../../data/repositories/exercise_repository.dart';
import '../../data/repositories/progress_repository.dart';
import '../../data/models/lesson.dart';
import '../../data/models/vocabulary.dart';
import '../../data/models/dialog_model.dart';
import '../../data/models/grammar_rule.dart';
import '../../data/models/reading_text.dart';
import '../../data/models/user_progress.dart';

// ── Repository Providers ─────────────────────────────────────

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService.instance;
});

final lessonRepositoryProvider = Provider<LessonRepository>((ref) {
  // DÜZEDIŞ #6: ref.watch ulanylýar — dependency tracking dogry işleýär
  return LessonRepository(ref.watch(databaseServiceProvider));
});

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return ExerciseRepository(ref.watch(databaseServiceProvider));
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepository(ref.watch(databaseServiceProvider));
});

// ── Lesson Providers ─────────────────────────────────────────

final allLessonsProvider = FutureProvider<List<Lesson>>((ref) async {
  // DÜZEDIŞ #6: ref.read → ref.watch (FutureProvider içinde)
  final repo = ref.watch(lessonRepositoryProvider);
  return repo.getAllLessons();
});

final lessonByIdProvider =
    FutureProvider.family<Lesson?, int>((ref, lessonId) async {
  final repo = ref.watch(lessonRepositoryProvider);
  return repo.getLessonById(lessonId);
});

final vocabularyForLessonProvider =
    FutureProvider.family<List<Vocabulary>, int>((ref, lessonId) async {
  final repo = ref.watch(lessonRepositoryProvider);
  return repo.getVocabularyForLesson(lessonId);
});

final dialogsForLessonProvider =
    FutureProvider.family<List<DialogModel>, int>((ref, lessonId) async {
  final repo = ref.watch(lessonRepositoryProvider);
  return repo.getDialogsForLesson(lessonId);
});

// DÜZEDIŞ #2: ConversationScreen inline FutureProvider döretmäge derek
// bu ýerde aýratyn global provider — cache dogry işleýär, her build-da
// täze provider döretmeýär.
final dialogByIdProvider =
    FutureProvider.family<DialogModel?, int>((ref, dialogId) async {
  final repo = ref.watch(lessonRepositoryProvider);
  return repo.getDialogById(dialogId);
});

final allDialogsProvider = FutureProvider<List<DialogModel>>((ref) async {
  final repo = ref.watch(lessonRepositoryProvider);
  return repo.getAllDialogs();
});

final grammarRulesForLessonProvider =
    FutureProvider.family<List<GrammarRule>, int>((ref, lessonId) async {
  final repo = ref.watch(exerciseRepositoryProvider);
  return repo.getGrammarRulesForLesson(lessonId);
});

final readingTextForLessonProvider =
    FutureProvider.family<ReadingText?, int>((ref, lessonId) async {
  final repo = ref.watch(lessonRepositoryProvider);
  return repo.getReadingTextForLesson(lessonId);
});

// ── Progress Providers ───────────────────────────────────────

final allLessonProgressProvider =
    FutureProvider<List<LessonProgress>>((ref) async {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.getAllLessonProgress();
});

final lessonProgressProvider =
    FutureProvider.family<LessonProgress?, int>((ref, lessonId) async {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.getLessonProgress(lessonId);
});

final overallStatsProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.getOverallStats();
});

// ── Lesson Detail State ──────────────────────────────────────

class LessonDetailState {
  final Lesson? lesson;
  final List<Vocabulary> vocabulary;
  final List<DialogModel> dialogs;
  final List<GrammarRule> grammarRules;
  final ReadingText? readingText;
  final LessonProgress? progress;
  final bool isLoading;
  final String? error;
  final int activeTab; // 0: vocab, 1: dialog, 2: grammar, 3: text

  const LessonDetailState({
    this.lesson,
    this.vocabulary = const [],
    this.dialogs = const [],
    this.grammarRules = const [],
    this.readingText,
    this.progress,
    this.isLoading = false,
    this.error,
    this.activeTab = 0,
  });

  LessonDetailState copyWith({
    Lesson? lesson,
    List<Vocabulary>? vocabulary,
    List<DialogModel>? dialogs,
    List<GrammarRule>? grammarRules,
    ReadingText? readingText,
    LessonProgress? progress,
    bool? isLoading,
    String? error,
    int? activeTab,
  }) {
    return LessonDetailState(
      lesson: lesson ?? this.lesson,
      vocabulary: vocabulary ?? this.vocabulary,
      dialogs: dialogs ?? this.dialogs,
      grammarRules: grammarRules ?? this.grammarRules,
      readingText: readingText ?? this.readingText,
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      activeTab: activeTab ?? this.activeTab,
    );
  }
}

class LessonDetailNotifier extends StateNotifier<LessonDetailState> {
  final LessonRepository _lessonRepo;
  final ExerciseRepository _exerciseRepo;
  final ProgressRepository _progressRepo;

  LessonDetailNotifier(
    this._lessonRepo,
    this._exerciseRepo,
    this._progressRepo,
  ) : super(const LessonDetailState());

  Future<void> loadLesson(int lessonId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final results = await Future.wait([
        _lessonRepo.getLessonById(lessonId),
        _lessonRepo.getVocabularyForLesson(lessonId),
        _lessonRepo.getDialogsForLesson(lessonId),
        _exerciseRepo.getGrammarRulesForLesson(lessonId),
        _lessonRepo.getReadingTextForLesson(lessonId),
        _progressRepo.getLessonProgress(lessonId),
      ]);

      state = state.copyWith(
        lesson: results[0] as Lesson?,
        vocabulary: results[1] as List<Vocabulary>,
        dialogs: results[2] as List<DialogModel>,
        grammarRules: results[3] as List<GrammarRule>,
        readingText: results[4] as ReadingText?,
        progress: results[5] as LessonProgress?,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setActiveTab(int tab) {
    state = state.copyWith(activeTab: tab);
  }

  Future<void> markVocabStudied() async {
    if (state.lesson == null) return;
    await _progressRepo.markVocabStudied(
        state.lesson!.id, state.vocabulary.length);
    final updated = await _progressRepo.getLessonProgress(state.lesson!.id);
    state = state.copyWith(progress: updated);
  }

  Future<void> markDialogRead() async {
    if (state.lesson == null) return;
    await _progressRepo.markDialogRead(state.lesson!.id);
    final updated = await _progressRepo.getLessonProgress(state.lesson!.id);
    state = state.copyWith(progress: updated);
  }
}

final lessonDetailProvider =
    StateNotifierProvider.family<LessonDetailNotifier, LessonDetailState, int>(
  (ref, lessonId) {
    final notifier = LessonDetailNotifier(
      ref.watch(lessonRepositoryProvider),
      ref.watch(exerciseRepositoryProvider),
      ref.watch(progressRepositoryProvider),
    );
    notifier.loadLesson(lessonId);
    return notifier;
  },
);
