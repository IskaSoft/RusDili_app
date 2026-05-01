import '../../core/constants/db_constants.dart';

class Lesson {
  final int id;
  final int sapakNumber;
  final String titleRu;
  final String titleTk;
  final String? subtitleTk;
  final String? descriptionTk;
  final String? imagePath;
  final bool isCompleted;
  final int orderIndex;
  final String? createdAt;

  const Lesson({
    required this.id,
    required this.sapakNumber,
    required this.titleRu,
    required this.titleTk,
    this.subtitleTk,
    this.descriptionTk,
    this.imagePath,
    this.isCompleted = false,
    this.orderIndex = 0,
    this.createdAt,
  });

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map[DbConstants.colId] as int,
      sapakNumber: map[DbConstants.colSapakNumber] as int,
      titleRu: map[DbConstants.colTitleRu] as String,
      titleTk: map[DbConstants.colTitleTk] as String,
      subtitleTk: map[DbConstants.colSubtitleTk] as String?,
      descriptionTk: map[DbConstants.colDescriptionTk] as String?,
      imagePath: map[DbConstants.colImagePath] as String?,
      isCompleted: (map[DbConstants.colIsCompleted] as int? ?? 0) == 1,
      orderIndex: map[DbConstants.colOrderIndex] as int? ?? 0,
      createdAt: map[DbConstants.colCreatedAt] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbConstants.colId: id,
      DbConstants.colSapakNumber: sapakNumber,
      DbConstants.colTitleRu: titleRu,
      DbConstants.colTitleTk: titleTk,
      DbConstants.colSubtitleTk: subtitleTk,
      DbConstants.colDescriptionTk: descriptionTk,
      DbConstants.colImagePath: imagePath,
      DbConstants.colIsCompleted: isCompleted ? 1 : 0,
      DbConstants.colOrderIndex: orderIndex,
      DbConstants.colCreatedAt: createdAt,
    };
  }

  Lesson copyWith({
    int? id,
    int? sapakNumber,
    String? titleRu,
    String? titleTk,
    String? subtitleTk,
    String? descriptionTk,
    String? imagePath,
    bool? isCompleted,
    int? orderIndex,
    String? createdAt,
  }) {
    return Lesson(
      id: id ?? this.id,
      sapakNumber: sapakNumber ?? this.sapakNumber,
      titleRu: titleRu ?? this.titleRu,
      titleTk: titleTk ?? this.titleTk,
      subtitleTk: subtitleTk ?? this.subtitleTk,
      descriptionTk: descriptionTk ?? this.descriptionTk,
      imagePath: imagePath ?? this.imagePath,
      isCompleted: isCompleted ?? this.isCompleted,
      orderIndex: orderIndex ?? this.orderIndex,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'Lesson(id: $id, sapak: $sapakNumber, title: $titleRu)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Lesson && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
