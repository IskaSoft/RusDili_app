import '../../data/models/grammar_rule.dart';
import '../../data/repositories/exercise_repository.dart';

class GetGrammarUseCase {
  final ExerciseRepository _repo;

  GetGrammarUseCase(this._repo);

  /// Returns all grammar rules for a lesson, sorted by order
  Future<List<GrammarRule>> call(int lessonId) async {
    final rules = await _repo.getGrammarRulesForLesson(lessonId);
    return rules..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
  }

  /// Returns only rules that have table rows (for display)
  Future<List<GrammarRule>> getTablesOnly(int lessonId) async {
    final rules = await call(lessonId);
    return rules.where((r) => r.rows.isNotEmpty).toList();
  }

  /// Generate quick-quiz questions from grammar table cells
  List<Map<String, String>> generateQuizFromTable(GrammarRule rule) {
    final questions = <Map<String, String>>[];
    if (rule.rows.length < 2) return questions;

    final headerRow =
        rule.rows.firstWhere((r) => r.isHeader, orElse: () => rule.rows.first);
    final dataRows = rule.rows.where((r) => !r.isHeader).toList();

    for (final row in dataRows) {
      for (int ci = 1; ci < row.cells.length; ci++) {
        final cell = row.cells[ci];
        if (cell.isEmpty || cell == '—') continue;
        final header = ci < headerRow.cells.length
            ? headerRow.cells[ci]
            : 'Näme?';
        final rowLabel = row.cells[0];
        if (rowLabel.isEmpty) continue;

        questions.add({
          'question': '$rowLabel + $header = ?',
          'answer': cell,
          'hint': '${rule.titleTk ?? rule.titleRu ?? "Tablisa"}',
        });
      }
    }
    return questions;
  }
}
