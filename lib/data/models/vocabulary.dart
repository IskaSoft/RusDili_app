import 'dart:typed_data';
import '../../core/constants/db_constants.dart';

class Vocabulary {
  final int id;
  final int lessonId;
  final String wordRu;
  final String wordTk;
  final String? exampleRu;
  final String? exampleTk;
  final String? imagePath;
  final Uint8List? imageBlob;
  final String? audioPath;
  final String? category;
  final int difficulty;

  const Vocabulary({
    required this.id,
    required this.lessonId,
    required this.wordRu,
    required this.wordTk,
    this.exampleRu,
    this.exampleTk,
    this.imagePath,
    this.imageBlob,
    this.audioPath,
    this.category,
    this.difficulty = 1,
  });

  factory Vocabulary.fromMap(Map<String, dynamic> map) {
    return Vocabulary(
      id: map[DbConstants.colId] as int,
      lessonId: map[DbConstants.colLessonId] as int,
      wordRu: map[DbConstants.colWordRu] as String,
      wordTk: map[DbConstants.colWordTk] as String,
      exampleRu: map[DbConstants.colExampleRu] as String?,
      exampleTk: map[DbConstants.colExampleTk] as String?,
      imagePath: map[DbConstants.colImagePath] as String?,
      imageBlob: map[DbConstants.colImageBlob] as Uint8List?,
      audioPath: map[DbConstants.colAudioPath] as String?,
      category: map[DbConstants.colCategory] as String?,
      difficulty: map[DbConstants.colDifficulty] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbConstants.colId: id,
      DbConstants.colLessonId: lessonId,
      DbConstants.colWordRu: wordRu,
      DbConstants.colWordTk: wordTk,
      DbConstants.colExampleRu: exampleRu,
      DbConstants.colExampleTk: exampleTk,
      DbConstants.colImagePath: imagePath,
      DbConstants.colImageBlob: imageBlob,
      DbConstants.colAudioPath: audioPath,
      DbConstants.colCategory: category,
      DbConstants.colDifficulty: difficulty,
    };
  }

  Vocabulary copyWith({
    int? id,
    int? lessonId,
    String? wordRu,
    String? wordTk,
    String? exampleRu,
    String? exampleTk,
    String? imagePath,
    Uint8List? imageBlob,
    String? audioPath,
    String? category,
    int? difficulty,
  }) {
    return Vocabulary(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      wordRu: wordRu ?? this.wordRu,
      wordTk: wordTk ?? this.wordTk,
      exampleRu: exampleRu ?? this.exampleRu,
      exampleTk: exampleTk ?? this.exampleTk,
      imagePath: imagePath ?? this.imagePath,
      imageBlob: imageBlob ?? this.imageBlob,
      audioPath: audioPath ?? this.audioPath,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Vocabulary && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
