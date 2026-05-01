import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/vocabulary.dart';
import '../../../data/models/dialog_model.dart';
import '../../../data/models/grammar_rule.dart';
import '../../../data/models/reading_text.dart';
import '../../providers/lesson_provider.dart';

class LessonDetailScreen extends ConsumerWidget {
  final int lessonId;
  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lessonDetailProvider(lessonId));

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.error != null) {
      return Scaffold(body: Center(child: Text('Ýalňyşlyk: ${state.error}')));
    }

    final lesson = state.lesson;
    if (lesson == null) {
      return const Scaffold(body: Center(child: Text('Sapak tapylmady')));
    }

    final tabCount = state.readingText != null ? 4 : 3;

    return DefaultTabController(
      length: tabCount,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 165,
              pinned: true,
              backgroundColor: const Color(0xFF1A1A2E),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.white),
                onPressed: () => context.pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.fitness_center_rounded,
                      color: Colors.white70),
                  onPressed: () => context.push('/practice/$lessonId'),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  decoration:
                      const BoxDecoration(gradient: AppColors.headerGradient),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 56, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Sapak ${lesson.sapakNumber.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(lesson.titleRu,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800)),
                          Text(lesson.titleTk,
                              style: const TextStyle(
                                  color: Colors.white60, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                isScrollable: tabCount > 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white38,
                indicatorColor: AppColors.primary,
                indicatorWeight: 3,
                tabs: [
                  const Tab(text: '📖 Sözler'),
                  const Tab(text: '💬 Dialog'),
                  const Tab(text: '📐 Grammatika'),
                  if (state.readingText != null) const Tab(text: '📄 Tekst'),
                ],
              ),
            ),
          ],
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    _VocabTab(vocab: state.vocabulary, lessonId: lessonId),
                    _DialogTab(dialogs: state.dialogs),
                    _GrammarTab(rules: state.grammarRules),
                    if (state.readingText != null)
                      _ReadingTab(text: state.readingText!),
                  ],
                ),
              ),
              _PracticeBar(lessonId: lessonId),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Bottom Practice Bar ──────────────────────────────────────────────────────
class _PracticeBar extends StatelessWidget {
  final int lessonId;
  const _PracticeBar({required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border:
            Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => context.push('/practice/$lessonId'),
              icon: const Icon(Icons.fitness_center_rounded, size: 18),
              label: const Text('Türgenleşige Başla'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.infoSurface,
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: AppColors.info.withOpacity(0.3)),
            ),
            child: IconButton(
              icon: const Icon(Icons.chat_bubble_rounded,
                  color: AppColors.info),
              onPressed: () => context.push('/conversations'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Vocabulary Tab ───────────────────────────────────────────────────────────
class _VocabTab extends StatelessWidget {
  final List<Vocabulary> vocab;
  final int lessonId;
  const _VocabTab({required this.vocab, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    if (vocab.isEmpty) {
      return const Center(child: Text('Sözler tapylmady'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vocab.length + 1,
      itemBuilder: (context, index) {
        if (index == vocab.length) {
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            child: OutlinedButton.icon(
              onPressed: () =>
                  context.push('/practice/$lessonId/flashcard'),
              icon: const Icon(Icons.style_rounded, size: 18),
              label: const Text('Flash Kart bilen öwren 🃏'),
            ),
          );
        }
        return _VocabCard(word: vocab[index], index: index);
      },
    );
  }
}

class _VocabCard extends StatefulWidget {
  final Vocabulary word;
  final int index;
  const _VocabCard({required this.word, required this.index});

  @override
  State<_VocabCard> createState() => _VocabCardState();
}

class _VocabCardState extends State<_VocabCard> {
  bool _expanded = false;

  Color _catColor(String? cat) => switch (cat) {
        'greeting' => AppColors.success,
        'family' => AppColors.secondary,
        'profession' => AppColors.info,
        'adjectives' => AppColors.primary,
        'verbs' => const Color(0xFF9C27B0),
        'days' => const Color(0xFF00BCD4),
        'time' => const Color(0xFFFF9800),
        'nationality' => const Color(0xFFE91E63),
        _ => AppColors.textTertiary,
      };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _expanded
                ? _catColor(widget.word.category).withOpacity(0.4)
                : AppColors.border,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: _expanded ? null : 36,
              constraints: const BoxConstraints(minHeight: 36),
              decoration: BoxDecoration(
                color: _catColor(widget.word.category),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.word.wordRu,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 18,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: _expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: Text(
                      widget.word.wordTk,
                      style: TextStyle(
                          fontSize: 13,
                          color: _catColor(widget.word.category),
                          fontWeight: FontWeight.w600),
                    ),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.word.wordTk,
                          style: TextStyle(
                              fontSize: 14,
                              color: _catColor(widget.word.category),
                              fontWeight: FontWeight.w600),
                        ),
                        if (widget.word.exampleRu != null) ...[
                          const SizedBox(height: 6),
                          Text(widget.word.exampleRu!,
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  fontStyle: FontStyle.italic)),
                        ],
                        if (widget.word.exampleTk != null)
                          Text(widget.word.exampleTk!,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.word.imagePath != null) ...[
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.word.imagePath!,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.image_outlined,
                        color: AppColors.textTertiary, size: 22),
                  ),
                ),
              ),
            ],
          ],
        ),
      ).animate(delay: (widget.index * 40).ms).fadeIn().slideX(begin: 0.1),
    );
  }
}

// ── Dialog Tab ───────────────────────────────────────────────────────────────
class _DialogTab extends StatelessWidget {
  final List<DialogModel> dialogs;
  const _DialogTab({required this.dialogs});

  @override
  Widget build(BuildContext context) {
    if (dialogs.isEmpty) {
      return const Center(child: Text('Dialoglar tapylmady'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dialogs.length,
      itemBuilder: (ctx, i) =>
          _DialogCard(dialog: dialogs[i], index: i),
    );
  }
}

class _DialogCard extends StatefulWidget {
  final DialogModel dialog;
  final int index;
  const _DialogCard({required this.dialog, required this.index});

  @override
  State<_DialogCard> createState() => _DialogCardState();
}

class _DialogCardState extends State<_DialogCard> {
  bool _expanded = false;
  bool _showTk = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.dialog.dialogNumber ?? widget.index + 1}',
                        style: const TextStyle(
                            color: AppColors.info,
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Диалог ${widget.dialog.dialogNumber ?? widget.index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        if (widget.dialog.dialogName != null)
                          Text(widget.dialog.dialogName!,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary)),
                        if (widget.dialog.lines.isNotEmpty)
                          Text('${widget.dialog.lines.length} setir',
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                const Divider(height: 1),
                if (widget.dialog.contextTk != null)
                  Container(
                    margin: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.secondarySurface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('📍 ${widget.dialog.contextTk}',
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic)),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Row(
                    children: [
                      const Text('Terjimesi:',
                          style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textTertiary)),
                      const SizedBox(width: 8),
                      Switch.adaptive(
                        value: _showTk,
                        onChanged: (v) => setState(() => _showTk = v),
                        activeColor: AppColors.primary,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),
                ...widget.dialog.lines.asMap().entries.map((e) =>
                    _buildLine(e.value, e.key % 2 == 0)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
                  child: OutlinedButton.icon(
                    onPressed: () => context
                        .push('/conversation/${widget.dialog.id}'),
                    icon: const Icon(Icons.play_arrow_rounded, size: 16),
                    label: const Text('Bu dialogu mashk et'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.info,
                      side: const BorderSide(color: AppColors.info),
                      minimumSize: const Size(double.infinity, 36),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: (widget.index * 70).ms).fadeIn();
  }

  Widget _buildLine(DialogLine line, bool isA) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(isA ? 14 : 48, 3, isA ? 48 : 14, 3),
      child: Align(
        alignment:
            isA ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isA ? AppColors.infoSurface : AppColors.primarySurface,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: Radius.circular(isA ? 2 : 12),
              bottomRight: Radius.circular(isA ? 12 : 2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (line.speaker != null)
                Text(line.speaker!,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isA ? AppColors.info : AppColors.primary)),
              Text(line.textRu,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textPrimary)),
              if (_showTk && line.textTk != null)
                Text(line.textTk!,
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Grammar Tab ──────────────────────────────────────────────────────────────
class _GrammarTab extends StatelessWidget {
  final List<GrammarRule> rules;
  const _GrammarTab({required this.rules});

  @override
  Widget build(BuildContext context) {
    if (rules.isEmpty) {
      return const Center(child: Text('Grammatika tapylmady'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rules.length,
      itemBuilder: (ctx, i) => _GrammarCard(rule: rules[i], index: i),
    );
  }
}

class _GrammarCard extends StatelessWidget {
  final GrammarRule rule;
  final int index;
  const _GrammarCard({required this.rule, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Text('📊', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    rule.titleTk ?? rule.titleRu ?? 'Tablisa',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          if (rule.explanationTk?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: Text(rule.explanationTk!,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary)),
            ),
          if (rule.noteTk?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.infoSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColors.info.withOpacity(0.25)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('📌 '),
                    Expanded(
                      child: Text(rule.noteTk!,
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.info,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
          if (rule.rows.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(14),
              child: _GrammarTable(rows: rule.rows),
            ),
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
    final headerRow =
        rows.firstWhere((r) => r.isHeader, orElse: () => rows.first);
    final colCount =
        headerRow.cells.where((c) => c.isNotEmpty).length.clamp(1, 7);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(8)),
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: rows.map((row) {
          final cells = row.cells.take(colCount).toList();
          while (cells.length < colCount) cells.add('');
          return TableRow(
            decoration: BoxDecoration(
              color: row.isHeader ? const Color(0xFF1A1A2E) : null,
            ),
            children: cells.asMap().entries.map((e) {
              final colIdx = e.key;
              final cell = e.value;
              final isRed =
                  !row.isHeader && row.isCellRed(colIdx);
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 9),
                child: Text(
                  cell,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: row.isHeader || colIdx == 0
                        ? FontWeight.w700
                        : FontWeight.w400,
                    color: row.isHeader
                        ? Colors.white
                        : isRed
                            ? AppColors.primary
                            : AppColors.textPrimary,
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

// ── Reading Tab ──────────────────────────────────────────────────────────────
class _ReadingTab extends StatelessWidget {
  final ReadingText text;
  const _ReadingTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: AppColors.headerGradient,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Text('📄', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Okuw Teksti',
                          style: TextStyle(
                              color: Colors.white54, fontSize: 11)),
                      Text(text.titleRu ?? 'Tekst',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              text.contentRu,
              style: const TextStyle(
                  fontSize: 15,
                  height: 1.9,
                  color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.successSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Text('💡', style: TextStyle(fontSize: 18)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Teksti birnäçe gezek okaň. Tanyş sözleri tapyň!',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.success,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
