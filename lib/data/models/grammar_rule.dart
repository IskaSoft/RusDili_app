import 'dart:typed_data';
import '../../core/constants/db_constants.dart';

class GrammarRule {
  final int id;
  final int lessonId;
  final int? tableNumber;
  final String? titleRu;
  final String? titleTk;
  final String? explanationTk;
  final String? noteTk;
  final String ruleType;
  final String? imagePath;
  final Uint8List? imageBlob;
  final int orderIndex;
  final List<GrammarTableRow> rows;

  const GrammarRule({
    required this.id,
    required this.lessonId,
    this.tableNumber,
    this.titleRu,
    this.titleTk,
    this.explanationTk,
    this.noteTk,
    this.ruleType = DbConstants.ruleTypeTable,
    this.imagePath,
    this.imageBlob,
    this.orderIndex = 0,
    this.rows = const [],
  });

  bool get isTable => ruleType == DbConstants.ruleTypeTable;
  bool get isWarning => ruleType == DbConstants.ruleTypeWarning;
  bool get isNote => ruleType == DbConstants.ruleTypeNote;

  factory GrammarRule.fromMap(Map<String, dynamic> map,
      {List<GrammarTableRow> rows = const []}) {
    return GrammarRule(
      id: map[DbConstants.colId] as int,
      lessonId: map[DbConstants.colLessonId] as int,
      tableNumber: map[DbConstants.colTableNumber] as int?,
      titleRu: map[DbConstants.colTitleRu] as String?,
      titleTk: map[DbConstants.colTitleTk] as String?,
      explanationTk: map[DbConstants.colExplanation] as String?,
      noteTk: map[DbConstants.colNote] as String?,
      ruleType: map[DbConstants.colRuleType] as String? ?? DbConstants.ruleTypeTable,
      imagePath: map[DbConstants.colImagePath] as String?,
      imageBlob: map[DbConstants.colImageBlob] as Uint8List?,
      orderIndex: map[DbConstants.colOrderIndex] as int? ?? 0,
      rows: rows,
    );
  }

  GrammarRule copyWith({List<GrammarTableRow>? rows}) {
    return GrammarRule(
      id: id,
      lessonId: lessonId,
      tableNumber: tableNumber,
      titleRu: titleRu,
      titleTk: titleTk,
      explanationTk: explanationTk,
      noteTk: noteTk,
      ruleType: ruleType,
      imagePath: imagePath,
      imageBlob: imageBlob,
      orderIndex: orderIndex,
      rows: rows ?? this.rows,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is GrammarRule && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class GrammarTableRow {
  final int id;
  final int grammarId;
  final int rowOrder;
  final bool isHeader;
  final List<String> cells;
  final List<int> redCellIndices; // Which columns should be red

  const GrammarTableRow({
    required this.id,
    required this.grammarId,
    required this.rowOrder,
    required this.isHeader,
    required this.cells,
    required this.redCellIndices,
  });

  factory GrammarTableRow.fromMap(Map<String, dynamic> map) {
    final cells = <String>[];
    for (int i = 1; i <= 7; i++) {
      final cell = map['cell_$i'] as String?;
      if (cell != null && cell.isNotEmpty) {
        cells.add(cell);
      } else if (i <= 4) {
        // Keep empty cells for alignment up to col 4
        cells.add('');
      } else {
        break;
      }
    }

    // Parse red_cells: "0,1,3" → [0, 1, 3]
    final redCellsStr = map[DbConstants.colRedCells] as String? ?? '';
    final redCells = redCellsStr.isNotEmpty
        ? redCellsStr
            .split(',')
            .map((e) => int.tryParse(e.trim()) ?? -1)
            .where((e) => e >= 0)
            .toList()
        : <int>[];

    return GrammarTableRow(
      id: map[DbConstants.colId] as int,
      grammarId: map[DbConstants.colGrammarId] as int,
      rowOrder: map[DbConstants.colRowOrder] as int? ?? 0,
      isHeader: (map[DbConstants.colIsHeader] as int? ?? 0) == 1,
      cells: cells,
      redCellIndices: redCells,
    );
  }

  bool isCellRed(int colIndex) => redCellIndices.contains(colIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is GrammarTableRow && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
