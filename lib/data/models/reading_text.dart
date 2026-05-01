import '../../core/constants/db_constants.dart';

class ReadingText {
  final int id;
  final int lessonId;
  final String? titleRu;
  final String contentRu;
  final String? imagePath;

  const ReadingText({
    required this.id,
    required this.lessonId,
    this.titleRu,
    required this.contentRu,
    this.imagePath,
  });

  factory ReadingText.fromMap(Map<String, dynamic> map) {
    return ReadingText(
      id: map[DbConstants.colId] as int,
      lessonId: map[DbConstants.colLessonId] as int,
      titleRu: map[DbConstants.colTitleRu] as String?,
      contentRu: map[DbConstants.colTextRu] as String? ?? map['content_ru'] as String,
      imagePath: map[DbConstants.colImagePath] as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ReadingText && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
