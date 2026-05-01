import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/exercise.dart';
import '../../data/repositories/exercise_repository.dart';
import '../../data/repositories/progress_repository.dart';
import 'lesson_provider.dart';

// ═══════════════════════════════════════════════════════════════
// PRACTICE STATE
// ═══════════════════════════════════════════════════════════════

enum PracticeStatus { idle, loading, active, checking, finished, error }

class PracticeState {
  final List<ExerciseQuestion> questions;
  final int currentIndex;
  final int correctCount;
  final int incorrectCount;
  final PracticeStatus status;
  final String? selectedAnswer;
  final bool? isCurrentCorrect;
  final bool showHint;
  final String? error;
  final ExerciseType exerciseType;
  final int lessonId;
  final DateTime? startTime;

  const PracticeState({
    this.questions = const [],
    this.currentIndex = 0,
    this.correctCount = 0,
    this.incorrectCount = 0,
    this.status = PracticeStatus.idle,
    this.selectedAnswer,
    this.isCurrentCorrect,
    this.showHint = false,
    this.error,
    this.exerciseType = ExerciseType.fillBlank,
    this.lessonId = 0,
    this.startTime,
  });

  // ── Getters used by UI screens ─────────────────────────────
  ExerciseQuestion? get currentQuestion =>
      currentIndex < questions.length ? questions[currentIndex] : null;

  bool get isLastQuestion => currentIndex >= questions.length - 1;

  double get scorePercent {
    final total = correctCount + incorrectCount;
    if (total == 0) return 0;
    return (correctCount / total) * 100; // Return 0-100, not 0-1
  }

  int get totalAnswered => correctCount + incorrectCount;

  // These names are what your screens expect:
  String? get errorMessage => error;
  String get progressText => '${currentIndex + 1}/${questions.length}';
  int get totalQuestions => questions.length;
  bool? get isAnswerCorrect => isCurrentCorrect;

  PracticeState copyWith({
    List<ExerciseQuestion>? questions,
    int? currentIndex,
    int? correctCount,
    int? incorrectCount,
    PracticeStatus? status,
    String? selectedAnswer,
    bool? isCurrentCorrect,
    bool? showHint,
    String? error,
    ExerciseType? exerciseType,
    int? lessonId,
    DateTime? startTime,
    bool clearSelectedAnswer = false,
    bool clearIsCurrentCorrect = false,
  }) {
    return PracticeState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      status: status ?? this.status,
      selectedAnswer:
          clearSelectedAnswer ? null : (selectedAnswer ?? this.selectedAnswer),
      isCurrentCorrect:
          clearIsCurrentCorrect
              ? null
              : (isCurrentCorrect ?? this.isCurrentCorrect),
      showHint: showHint ?? this.showHint,
      error: error ?? this.error,
      exerciseType: exerciseType ?? this.exerciseType,
      lessonId: lessonId ?? this.lessonId,
      startTime: startTime ?? this.startTime,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// PRACTICE NOTIFIER (Fill Blank + Multiple Choice)
// ═══════════════════════════════════════════════════════════════

class PracticeNotifier extends StateNotifier<PracticeState> {
  final ExerciseRepository _exerciseRepo;
  final ProgressRepository _progressRepo;

  PracticeNotifier(this._exerciseRepo, this._progressRepo)
    : super(const PracticeState());

  // Screens call: loadExercises(lessonId, type: ExerciseType.xxx)
  Future<void> loadExercises(int lessonId, {required ExerciseType type}) async {
    state = state.copyWith(status: PracticeStatus.loading, error: null);
    try {
      final questions = await _exerciseRepo.getAllQuestionsForLesson(
        lessonId,
        type: type,
      );

      if (questions.isEmpty) {
        state = state.copyWith(
          status: PracticeStatus.error,
          error: 'Bu sapak üçin ýumuşlar tapylmady.',
        );
        return;
      }

      state = state.copyWith(
        questions: questions,
        currentIndex: 0,
        correctCount: 0,
        incorrectCount: 0,
        status: PracticeStatus.active,
        clearSelectedAnswer: true,
        clearIsCurrentCorrect: true,
        exerciseType: type,
        lessonId: lessonId,
        startTime: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(status: PracticeStatus.error, error: e.toString());
    }
  }

  // Screens call: submitAnswer(text)
  void submitAnswer(String answer) {
    final question = state.currentQuestion;
    if (question == null || state.status != PracticeStatus.active) return;

    final isCorrect = question.isCorrect(answer);
    final timeSpent =
        state.startTime != null
            ? DateTime.now().difference(state.startTime!).inSeconds
            : null;

    _progressRepo.saveAnswer(
      lessonId: state.lessonId,
      exerciseId: question.exerciseId,
      questionId: question.id,
      isCorrect: isCorrect,
      timeSpentSec: timeSpent,
    );

    state = state.copyWith(
      selectedAnswer: answer,
      isCurrentCorrect: isCorrect,
      status: PracticeStatus.checking,
      correctCount: isCorrect ? state.correctCount + 1 : state.correctCount,
      incorrectCount:
          !isCorrect ? state.incorrectCount + 1 : state.incorrectCount,
    );
  }

  void nextQuestion() {
    if (state.isLastQuestion) {
      state = state.copyWith(status: PracticeStatus.finished);
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        clearSelectedAnswer: true,
        clearIsCurrentCorrect: true,
        status: PracticeStatus.active,
        showHint: false,
        startTime: DateTime.now(),
      );
    }
  }

  void toggleHint() {
    state = state.copyWith(showHint: !state.showHint);
  }

  void restart() {
    final shuffled = [...state.questions]..shuffle();
    state = state.copyWith(
      questions: shuffled,
      currentIndex: 0,
      correctCount: 0,
      incorrectCount: 0,
      status: PracticeStatus.active,
      clearSelectedAnswer: true,
      clearIsCurrentCorrect: true,
      showHint: false,
      startTime: DateTime.now(),
    );
  }

  void reset() {
    state = const PracticeState();
  }
}

// ═══════════════════════════════════════════════════════════════
// FLASHCARD STATE & NOTIFIER
// ═══════════════════════════════════════════════════════════════

class FlashcardState {
  final List<ExerciseQuestion> cards;
  final int currentIndex;
  final bool isFlipped;
  final int knownCount;
  final int unknownCount;
  final bool isFinished;
  final int lessonId;

  const FlashcardState({
    this.cards = const [],
    this.currentIndex = 0,
    this.isFlipped = false,
    this.knownCount = 0,
    this.unknownCount = 0,
    this.isFinished = false,
    this.lessonId = 0,
  });

  ExerciseQuestion? get currentCard =>
      currentIndex < cards.length ? cards[currentIndex] : null;

  bool get isLastCard => currentIndex >= cards.length - 1;

  double get progressPercent =>
      cards.isEmpty ? 0 : (currentIndex / cards.length);

  // Getters screens expect:
  String get progressText => '${currentIndex + 1}/${cards.length}';
  int get totalCards => cards.length;

  FlashcardState copyWith({
    List<ExerciseQuestion>? cards,
    int? currentIndex,
    bool? isFlipped,
    int? knownCount,
    int? unknownCount,
    bool? isFinished,
    int? lessonId,
  }) {
    return FlashcardState(
      cards: cards ?? this.cards,
      currentIndex: currentIndex ?? this.currentIndex,
      isFlipped: isFlipped ?? this.isFlipped,
      knownCount: knownCount ?? this.knownCount,
      unknownCount: unknownCount ?? this.unknownCount,
      isFinished: isFinished ?? this.isFinished,
      lessonId: lessonId ?? this.lessonId,
    );
  }
}

class FlashcardNotifier extends StateNotifier<FlashcardState> {
  final ExerciseRepository _exerciseRepo;
  final ProgressRepository _progressRepo;

  FlashcardNotifier(this._exerciseRepo, this._progressRepo)
    : super(const FlashcardState());

  Future<void> loadCards(int lessonId) async {
    final questions = await _exerciseRepo.getAllQuestionsForLesson(
      lessonId,
      type: ExerciseType.flashcard,
    );

    final cards =
        questions.isEmpty
            ? await _exerciseRepo.getAllQuestionsForLesson(lessonId)
            : questions;

    cards.shuffle();
    state = FlashcardState(cards: cards, lessonId: lessonId);
  }

  // Screen calls: flipCard()
  void flipCard() {
    state = state.copyWith(isFlipped: !state.isFlipped);
  }

  void markKnown() {
    _saveProgress(true);
    _advance(knownIncrement: 1);
  }

  void markUnknown() {
    _saveProgress(false);
    _advance(unknownIncrement: 1);
  }

  void _saveProgress(bool isCorrect) {
    _progressRepo.saveAnswer(
      lessonId: state.lessonId,
      exerciseId: state.currentCard?.exerciseId ?? 0,
      questionId: state.currentCard?.id ?? 0,
      isCorrect: isCorrect,
    );
  }

  void _advance({int knownIncrement = 0, int unknownIncrement = 0}) {
    if (state.isLastCard) {
      state = state.copyWith(
        knownCount: state.knownCount + knownIncrement,
        unknownCount: state.unknownCount + unknownIncrement,
        isFinished: true,
      );
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        isFlipped: false,
        knownCount: state.knownCount + knownIncrement,
        unknownCount: state.unknownCount + unknownIncrement,
      );
    }
  }

  void restart() {
    final shuffled = [...state.cards]..shuffle();
    state = FlashcardState(cards: shuffled);
  }
}

// ═══════════════════════════════════════════════════════════════
// MATCHING STATE & NOTIFIER
// ═══════════════════════════════════════════════════════════════

class MatchingPair {
  final int id;
  final String left;
  final String right;
  bool isMatched;

  MatchingPair({
    required this.id,
    required this.left,
    required this.right,
    this.isMatched = false,
  });
}

class MatchingState {
  final List<MatchingPair> pairs;
  final List<String> leftItems;
  final List<String> rightItems;
  final String? selectedLeft;
  final String? selectedRight;
  final int matchedCount;
  final bool isFinished;
  final int lessonId;
  final Map<String, String> userMatches;

  const MatchingState({
    this.pairs = const [],
    this.leftItems = const [],
    this.rightItems = const [],
    this.selectedLeft,
    this.selectedRight,
    this.matchedCount = 0,
    this.isFinished = false,
    this.lessonId = 0,
    this.userMatches = const {},
  });

  double get progressPercent => pairs.isEmpty ? 0 : matchedCount / pairs.length;

  // Getters screens expect:
  Map<String, String> get correctPairs {
    final map = <String, String>{};
    for (final pair in pairs) {
      map[pair.left] = pair.right;
    }
    return map;
  }

  int get correctCount => matchedCount;

  bool isPairCorrect(String leftItem) {
    if (!userMatches.containsKey(leftItem)) return false;
    return correctPairs[leftItem] == userMatches[leftItem];
  }

  MatchingState copyWith({
    List<MatchingPair>? pairs,
    List<String>? leftItems,
    List<String>? rightItems,
    String? selectedLeft,
    String? selectedRight,
    int? matchedCount,
    bool? isFinished,
    int? lessonId,
    Map<String, String>? userMatches,
    bool clearLeft = false,
    bool clearRight = false,
  }) {
    return MatchingState(
      pairs: pairs ?? this.pairs,
      leftItems: leftItems ?? this.leftItems,
      rightItems: rightItems ?? this.rightItems,
      selectedLeft: clearLeft ? null : (selectedLeft ?? this.selectedLeft),
      selectedRight: clearRight ? null : (selectedRight ?? this.selectedRight),
      matchedCount: matchedCount ?? this.matchedCount,
      isFinished: isFinished ?? this.isFinished,
      lessonId: lessonId ?? this.lessonId,
      userMatches: userMatches ?? this.userMatches,
    );
  }
}

class MatchingNotifier extends StateNotifier<MatchingState> {
  final ExerciseRepository _exerciseRepo;
  final ProgressRepository _progressRepo;

  MatchingNotifier(this._exerciseRepo, this._progressRepo)
    : super(const MatchingState());

  Future<void> loadMatching(int lessonId) async {
    final questions = await _exerciseRepo.getAllQuestionsForLesson(lessonId);
    final selected = questions.take(8).toList();

    final pairs =
        selected
            .asMap()
            .entries
            .map(
              (e) => MatchingPair(
                id: e.key,
                left: e.value.questionText
                    .replaceAll('_______ ', '')
                    .replaceAll(' → ?', ''),
                right: e.value.correctAnswer,
              ),
            )
            .toList();

    final leftItems = pairs.map((p) => p.left).toList()..shuffle();
    final rightItems = pairs.map((p) => p.right).toList()..shuffle();

    state = MatchingState(
      pairs: pairs,
      leftItems: leftItems,
      rightItems: rightItems,
      lessonId: lessonId,
    );
  }

  // Screen calls: loadPairs(map)
  void loadPairs(Map<String, String> pairs) {
    final matchingPairs =
        pairs.entries
            .toList()
            .asMap()
            .entries
            .map(
              (e) => MatchingPair(
                id: e.key,
                left: e.value.key,
                right: e.value.value,
              ),
            )
            .toList();

    final leftItems = pairs.keys.toList()..shuffle();
    final rightItems = pairs.values.toList()..shuffle();

    state = MatchingState(
      pairs: matchingPairs,
      leftItems: leftItems,
      rightItems: rightItems,
    );
  }

  void selectLeft(String item) {
    if (state.selectedLeft == item) {
      state = state.copyWith(clearLeft: true);
      return;
    }
    final newState = state.copyWith(selectedLeft: item);
    state = newState;
    _tryMatch(newState);
  }

  void selectRight(String item) {
    if (state.selectedRight == item) {
      state = state.copyWith(clearRight: true);
      return;
    }
    final newState = state.copyWith(selectedRight: item);
    state = newState;
    _tryMatch(newState);
  }

  void _tryMatch(MatchingState currentState) {
    if (currentState.selectedLeft == null || currentState.selectedRight == null)
      return;

    final matchedPair = currentState.pairs.firstWhere(
      (p) =>
          (p.left == currentState.selectedLeft &&
              p.right == currentState.selectedRight) ||
          (p.right == currentState.selectedLeft &&
              p.left == currentState.selectedRight),
      orElse: () => MatchingPair(id: -1, left: '', right: ''),
    );

    if (matchedPair.id != -1) {
      matchedPair.isMatched = true;
      final newMatchedCount = currentState.matchedCount + 1;
      final isFinished = newMatchedCount >= currentState.pairs.length;

      final newUserMatches = Map<String, String>.from(currentState.userMatches);
      newUserMatches[currentState.selectedLeft!] = currentState.selectedRight!;

      _progressRepo.saveAnswer(
        lessonId: currentState.lessonId,
        exerciseId: 0,
        questionId: matchedPair.id,
        isCorrect: true,
      );

      state = currentState.copyWith(
        pairs: currentState.pairs,
        matchedCount: newMatchedCount,
        isFinished: isFinished,
        clearLeft: true,
        clearRight: true,
        userMatches: newUserMatches,
      );
    } else {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          state = state.copyWith(clearLeft: true, clearRight: true);
        }
      });
    }
  }

  // Screen calls: reset()
  void reset() {
    final leftItems = state.pairs.map((p) => p.left).toList()..shuffle();
    final rightItems = state.pairs.map((p) => p.right).toList()..shuffle();
    for (final pair in state.pairs) {
      pair.isMatched = false;
    }
    state = MatchingState(
      pairs: state.pairs,
      leftItems: leftItems,
      rightItems: rightItems,
      lessonId: state.lessonId,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// PROVIDER DECLARATIONS (Fixed Riverpod types)
// ═══════════════════════════════════════════════════════════════

final practiceProvider =
    StateNotifierProvider.autoDispose<PracticeNotifier, PracticeState>(
      (ref) => PracticeNotifier(
        ref.read(exerciseRepositoryProvider),
        ref.read(progressRepositoryProvider),
      ),
    );

// FIXED: Use StateNotifierProvider.family (screens use .notifier)
final flashcardProvider =
    StateNotifierProvider.family<FlashcardNotifier, FlashcardState, int>((
      ref,
      lessonId,
    ) {
      final notifier = FlashcardNotifier(
        ref.read(exerciseRepositoryProvider),
        ref.read(progressRepositoryProvider),
      );
      notifier.loadCards(lessonId);
      return notifier;
    });

// FIXED: Same pattern
final matchingProvider =
    StateNotifierProvider.family<MatchingNotifier, MatchingState, int>((
      ref,
      lessonId,
    ) {
      final notifier = MatchingNotifier(
        ref.read(exerciseRepositoryProvider),
        ref.read(progressRepositoryProvider),
      );
      notifier.loadMatching(lessonId);
      return notifier;
    });
