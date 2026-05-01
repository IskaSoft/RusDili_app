import '../../core/constants/db_constants.dart';

class DialogModel {
  final int id;
  final int lessonId;
  final int? dialogNumber;
  final String? dialogName;
  final String? contextTk;
  final String? imagePath;
  final List<DialogLine> lines;

  const DialogModel({
    required this.id,
    required this.lessonId,
    this.dialogNumber,
    this.dialogName,
    this.contextTk,
    this.imagePath,
    this.lines = const [],
  });

  factory DialogModel.fromMap(Map<String, dynamic> map,
      {List<DialogLine> lines = const []}) {
    return DialogModel(
      id: map[DbConstants.colId] as int,
      lessonId: map[DbConstants.colLessonId] as int,
      dialogNumber: map[DbConstants.colDialogNumber] as int?,
      dialogName: map[DbConstants.colDialogName] as String?,
      contextTk: map[DbConstants.colContextTk] as String?,
      imagePath: map[DbConstants.colImagePath] as String?,
      lines: lines,
    );
  }

  DialogModel copyWith({
    int? id,
    int? lessonId,
    int? dialogNumber,
    String? dialogName,
    String? contextTk,
    String? imagePath,
    List<DialogLine>? lines,
  }) {
    return DialogModel(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      dialogNumber: dialogNumber ?? this.dialogNumber,
      dialogName: dialogName ?? this.dialogName,
      contextTk: contextTk ?? this.contextTk,
      imagePath: imagePath ?? this.imagePath,
      lines: lines ?? this.lines,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DialogModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class DialogLine {
  final int id;
  final int dialogId;
  final int? lineOrder;
  final String? speaker;
  final String textRu;
  final String? textTk;

  const DialogLine({
    required this.id,
    required this.dialogId,
    this.lineOrder,
    this.speaker,
    required this.textRu,
    this.textTk,
  });

  factory DialogLine.fromMap(Map<String, dynamic> map) {
    return DialogLine(
      id: map[DbConstants.colId] as int,
      dialogId: map[DbConstants.colDialogId] as int,
      lineOrder: map[DbConstants.colLineOrder] as int?,
      speaker: map[DbConstants.colSpeaker] as String?,
      textRu: map[DbConstants.colTextRu] as String,
      textTk: map[DbConstants.colTextTk] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbConstants.colId: id,
      DbConstants.colDialogId: dialogId,
      DbConstants.colLineOrder: lineOrder,
      DbConstants.colSpeaker: speaker,
      DbConstants.colTextRu: textRu,
      DbConstants.colTextTk: textTk,
    };
  }

  bool get isSpeakerA => speaker == 'A' || (speaker?.contains('Merdan') ?? false);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DialogLine && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
