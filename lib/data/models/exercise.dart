import '../../core/constants/db_constants.dart';

enum ExerciseType {
  fillBlank,
  multipleChoice,
  matching,
  wordOrder,
  translation,
  flashcard,
  textQuestion;

  static ExerciseType fromString(String value) {
    return switch (value) {
      DbConstants.exerciseFillBlank => fillBlank,
      DbConstants.exerciseMultipleChoice => multipleChoice,
      DbConstants.exerciseMatching => matching,
      DbConstants.exerciseWordOrder => wordOrder,
      DbConstants.exerciseTranslation => translation,
      DbConstants.exerciseFlashcard => flashcard,
      DbConstants.exerciseTextQuestion => textQuestion,
      _ => fillBlank,
    };
  }

  String get displayName {
    return switch (this) {
      fillBlank => 'Boş Ýer Doldur',
      multipleChoice => 'Köp Saýlaw',
      matching => 'Deňleşdir',
      wordOrder => 'Sözlemi Düz',
      translation => 'Terjime Et',
      flashcard => 'Flash Kart',
      textQuestion => 'Tekste Soraglar',
    };
  }

  String get iconEmoji {
    return switch (this) {
      fillBlank => '✏️',
      multipleChoice => '☑️',
      matching => '🔗',
      wordOrder => '🔀',
      translation => '🔄',
      flashcard => '🃏',
      textQuestion => '📖',
    };
  }
}

class Exercise {
  final int id;
  final int lessonId;
  final int? exerciseNumber;
  final String? titleTk;
  final String? instructionTk;
  final ExerciseType exerciseType;
  final String? noteTk;
  final int orderIndex;
  final List<ExerciseQuestion> questions;

  const Exercise({
    required this.id,
    required this.lessonId,
    this.exerciseNumber,
    this.titleTk,
    this.instructionTk,
    required this.exerciseType,
    this.noteTk,
    this.orderIndex = 0,
    this.questions = const [],
  });

  factory Exercise.fromMap(Map<String, dynamic> map,
      {List<ExerciseQuestion> questions = const []}) {
    return Exercise(
      id: map[DbConstants.colId] as int,
      lessonId: map[DbConstants.colLessonId] as int,
      exerciseNumber: map[DbConstants.colExerciseNumber] as int?,
      titleTk: map[DbConstants.colTitleTk] as String?,
      instructionTk: map[DbConstants.colInstructionTk] as String?,
      exerciseType: ExerciseType.fromString(
          map[DbConstants.colExerciseType] as String? ?? ''),
      noteTk: map[DbConstants.colNote] as String?,
      orderIndex: map[DbConstants.colOrderIndex] as int? ?? 0,
      questions: questions,
    );
  }

  Exercise copyWith({List<ExerciseQuestion>? questions}) {
    return Exercise(
      id: id,
      lessonId: lessonId,
      exerciseNumber: exerciseNumber,
      titleTk: titleTk,
      instructionTk: instructionTk,
      exerciseType: exerciseType,
      noteTk: noteTk,
      orderIndex: orderIndex,
      questions: questions ?? this.questions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Exercise && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class ExerciseQuestion {
  final int id;
  final int exerciseId;
  final int questionOrder;
  final String questionText;
  final String correctAnswer;
  final String? hintTk;
  final String? imagePath;
  final List<ExerciseOption> options;

  const ExerciseQuestion({
    required this.id,
    required this.exerciseId,
    required this.questionOrder,
    required this.questionText,
    required this.correctAnswer,
    this.hintTk,
    this.imagePath,
    this.options = const [],
  });

  factory ExerciseQuestion.fromMap(Map<String, dynamic> map,
      {List<ExerciseOption> options = const []}) {
    return ExerciseQuestion(
      id: map[DbConstants.colId] as int,
      exerciseId: map[DbConstants.colExerciseId] as int,
      questionOrder: map[DbConstants.colQuestionOrder] as int? ?? 0,
      questionText: map[DbConstants.colQuestionText] as String,
      correctAnswer: map[DbConstants.colCorrectAnswer] as String,
      hintTk: map[DbConstants.colHintTk] as String?,
      imagePath: map[DbConstants.colImagePath] as String?,
      options: options,
    );
  }

  bool isCorrect(String answer) {
    // Accept multiple correct answers separated by /
    final acceptedAnswers = correctAnswer
        .split('/')
        .map((a) => a.trim().toLowerCase())
        .toList();
    return acceptedAnswers.contains(answer.trim().toLowerCase());
  }

  ExerciseQuestion copyWith({List<ExerciseOption>? options}) {
    return ExerciseQuestion(
      id: id,
      exerciseId: exerciseId,
      questionOrder: questionOrder,
      questionText: questionText,
      correctAnswer: correctAnswer,
      hintTk: hintTk,
      imagePath: imagePath,
      options: options ?? this.options,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ExerciseQuestion && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class ExerciseOption {
  final int id;
  final int questionId;
  final String optionText;
  final bool isCorrect;

  const ExerciseOption({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.isCorrect,
  });

  factory ExerciseOption.fromMap(Map<String, dynamic> map) {
    return ExerciseOption(
      id: map[DbConstants.colId] as int,
      questionId: map[DbConstants.colQuestionId] as int,
      optionText: map[DbConstants.colOptionText] as String,
      isCorrect: (map[DbConstants.colIsCorrect] as int? ?? 0) == 1,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ExerciseOption && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
