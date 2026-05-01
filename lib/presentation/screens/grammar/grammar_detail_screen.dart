import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/grammar_rule.dart';
import '../../providers/lesson_provider.dart';

class GrammarDetailScreen extends ConsumerWidget {
  final int lessonId;
  const GrammarDetailScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonAsync = ref.watch(lessonByIdProvider(lessonId));
    final rulesAsync =
        ref.watch(grammarRulesForLessonProvider(lessonId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: lessonAsync.when(
          data: (l) => Text(l?.titleRu ?? 'Grammatika'),
          loading: () => const Text('Grammatika'),
          error: (_, __) => const Text('Grammatika'),
        ),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          // Practice grammar button
          lessonAsync.when(
            data: (l) => l != null
                ? TextButton.icon(
                    onPressed: () => context
                        .push('/practice/$lessonId/multiple-choice'),
                    icon: const Icon(Icons.quiz_rounded, size: 18),
                    label: const Text('Test'),
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.secondary),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: rulesAsync.when(
        data: (rules) => rules.isEmpty
            ? const Center(child: Text('Grammatika tapylmady'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: rules.length,
                itemBuilder: (ctx, i) =>
                    _GrammarRuleCard(rule: rules[i], index: i),
              ),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text('Ýalňyşlyk: $e')),
      ),
    );
  }
}

class _GrammarRuleCard extends StatelessWidget {
  final GrammarRule rule;
  final int index;
  const _GrammarRuleCard(
      {required this.rule, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Text('📊',
                    style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rule.titleTk ?? rule.titleRu ?? 'Tablisa',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.textPrimary),
                      ),
                      if (rule.titleRu != null &&
                          rule.titleTk != null)
                        Text(
                          rule.titleRu!,
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary),
                        ),
                    ],
                  ),
                ),
                // Table number badge
                if (rule.tableNumber != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.secondary
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'T${rule.tableNumber}',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary),
                    ),
                  ),
              ],
            ),
          ),

          // Explanation
          if (rule.explanationTk?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: Text(
                rule.explanationTk!,
                style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textSecondary,
                    height: 1.5),
              ),
            ),

          // Note box
          if (rule.noteTk?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.infoSurface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.info.withOpacity(0.25)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('📌 ',
                        style: TextStyle(fontSize: 13)),
                    Expanded(
                      child: Text(
                        rule.noteTk!,
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.info,
                            fontWeight: FontWeight.w500,
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Grammar table
          if (rule.rows.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(14),
              child: _GrammarTable(rows: rule.rows),
            )
          else
            const SizedBox(height: 4),
        ],
      ),
    ).animate(delay: (index * 80).ms).fadeIn().slideY(begin: 0.08);
  }
}

class _GrammarTable extends StatelessWidget {
  final List<GrammarTableRow> rows;
  const _GrammarTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();

    final headerRow =
        rows.firstWhere((r) => r.isHeader, orElse: () => rows.first);
    final colCount =
        headerRow.cells.where((c) => c.isNotEmpty).length.clamp(1, 7);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(
              color: AppColors.border, width: 0.8),
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: rows.map((row) {
            final cells = row.cells.take(colCount).toList();
            while (cells.length < colCount) cells.add('');

            return TableRow(
              decoration: BoxDecoration(
                color: row.isHeader
                    ? const Color(0xFF1A1A2E)
                    : rows.indexOf(row) % 2 == 0
                        ? AppColors.surface
                        : AppColors.surfaceVariant,
              ),
              children: cells.asMap().entries.map((e) {
                final colIdx = e.key;
                final cell = e.value;
                final isRed = !row.isHeader && row.isCellRed(colIdx);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  child: Text(
                    cell,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: row.isHeader || colIdx == 0
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: row.isHeader
                          ? Colors.white
                          : isRed
                              ? AppColors.primary
                              : colIdx == 0
                                  ? AppColors.textPrimary
                                  : AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
