import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/db_constants.dart';
import '../../../data/models/dialog_model.dart';
import '../../../data/models/vocabulary.dart';
import '../../../data/models/exercise.dart';
import '../../providers/library_provider.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (ctx, inner) => [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A2E),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.headerGradient),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Text('📖 Kitaphana',
                            style: TextStyle(color: Colors.white, fontSize: 24,
                                fontWeight: FontWeight.w800)),
                        Text('Frazalar · Sözlük · Gönükme · Saýlananlar',
                            style: TextStyle(color: Colors.white.withOpacity(0.55),
                                fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
              title: const Text('Kitaphana',
                  style: TextStyle(color: Colors.white, fontSize: 16,
                      fontWeight: FontWeight.w700)),
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: AppColors.secondary,
              indicatorWeight: 3,
              labelColor: AppColors.secondary,
              unselectedLabelColor: Colors.white54,
              labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              tabs: const [
                Tab(text: '💬 Frazalar'),
                Tab(text: '📖 Sözlük'),
                Tab(text: '✏️ Gönükme'),
                Tab(text: '⭐ Saýlananlar'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [
            _PhrasesTab(),
            _DictionaryTab(),
            _ExercisesTab(),
            _FavoritesTab(),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1 — FRAZALAR
// Gündelik frazalar + Ýagdaý dialoglar
// ═══════════════════════════════════════════════════════════
class _PhrasesTab extends ConsumerWidget {
  const _PhrasesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phrasesAsync = ref.watch(phraseDialogsProvider);
    final sitAsync = ref.watch(situationalDialogsProvider);

    return CustomScrollView(
      slivers: [
        // ── Gündelik frazalar ──
        const SliverToBoxAdapter(
          child: _SectionHeader(
            icon: '🗣️',
            title: 'Gündelik frazalar',
            subtitle: 'Hemme ýerde gerekli 10 tema',
          ),
        ),
        phrasesAsync.when(
          data: (dialogs) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => _DialogCard(
                dialog: dialogs[i],
                favType: DbConstants.favTypePhrase,
              ).animate(delay: Duration(milliseconds: i * 50))
                  .fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0),
              childCount: dialogs.length,
            ),
          ),
          loading: () => const SliverToBoxAdapter(child: _LoadingWidget()),
          error: (e, _) => SliverToBoxAdapter(child: _ErrorWidget(e.toString())),
        ),

        // ── Ýagdaý dialoglar ──
        const SliverToBoxAdapter(
          child: _SectionHeader(
            icon: '🎭',
            title: 'Ýagdaý dialoglar',
            subtitle: 'Hakyky durmuş söhbetleri — restoran, lukman, bank...',
          ),
        ),
        sitAsync.when(
          data: (dialogs) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => _DialogCard(
                dialog: dialogs[i],
                favType: DbConstants.favTypeDialog,
              ).animate(delay: Duration(milliseconds: i * 50))
                  .fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0),
              childCount: dialogs.length,
            ),
          ),
          loading: () => const SliverToBoxAdapter(child: _LoadingWidget()),
          error: (e, _) => SliverToBoxAdapter(child: _ErrorWidget(e.toString())),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2 — SÖZLÜK
// A→Z sözlük + iň köp ulanylýan sözler + söz düzümleri
// ═══════════════════════════════════════════════════════════
class _DictionaryTab extends ConsumerStatefulWidget {
  const _DictionaryTab();

  @override
  ConsumerState<_DictionaryTab> createState() => _DictionaryTabState();
}

class _DictionaryTabState extends ConsumerState<_DictionaryTab> {
  final _searchCtrl = TextEditingController();
  String _activeSection = 'verbs'; // default: işlikler

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(dictionarySearchProvider);
    final topVerbsAsync    = ref.watch(topVerbsProvider);
    final topPhrasesAsync  = ref.watch(topPhrasesVocabProvider);
    final connectorsAsync  = ref.watch(connectorsProvider);
    final topWordsAsync    = ref.watch(topWordsProvider);
    final dictAsync        = ref.watch(dictionaryProvider(search));

    return CustomScrollView(
      slivers: [
        // ── Gözleg ──
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Söz gözle... (rus ýa türkmen)',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: search.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchCtrl.clear();
                          ref.read(dictionarySearchProvider.notifier).state = '';
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (v) =>
                  ref.read(dictionarySearchProvider.notifier).state = v,
            ),
          ),
        ),

        if (search.isNotEmpty)
          dictAsync.when(
            data: (words) => words.isEmpty
                ? SliverToBoxAdapter(
                    child: _EmptyState(
                      icon: '🔍',
                      message: '"$search" üçin netije tapylmady',
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => _VocabCard(
                        vocab: words[i],
                        favType: DbConstants.favTypeWord,
                      ),
                      childCount: words.length,
                    ),
                  ),
            loading: () => const SliverToBoxAdapter(child: _LoadingWidget()),
            error: (e, _) =>
                SliverToBoxAdapter(child: _ErrorWidget(e.toString())),
          )
        else ...[
          // ── 5 bölüm chip ──
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _SectionChip(
                    label: '🔥 Işlikler',
                    selected: _activeSection == 'verbs',
                    onTap: () => setState(() => _activeSection = 'verbs'),
                  ),
                  const SizedBox(width: 8),
                  _SectionChip(
                    label: '💬 Köp aýdylýanlar',
                    selected: _activeSection == 'top_phrases',
                    onTap: () => setState(() => _activeSection = 'top_phrases'),
                  ),
                  const SizedBox(width: 8),
                  _SectionChip(
                    label: '🔗 Baglaýjylar',
                    selected: _activeSection == 'connectors',
                    onTap: () => setState(() => _activeSection = 'connectors'),
                  ),
                  const SizedBox(width: 8),
                  _SectionChip(
                    label: '⭐ Iň köp sözler',
                    selected: _activeSection == 'top',
                    onTap: () => setState(() => _activeSection = 'top'),
                  ),
                  const SizedBox(width: 8),
                  _SectionChip(
                    label: '🔤 A→Z',
                    selected: _activeSection == 'az',
                    onTap: () => setState(() => _activeSection = 'az'),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // Bölüm mazmuny
          if (_activeSection == 'verbs')
            _buildVocabSliver(topVerbsAsync)
          else if (_activeSection == 'top_phrases')
            _buildVocabSliver(topPhrasesAsync)
          else if (_activeSection == 'connectors')
            _buildVocabSliver(connectorsAsync)
          else if (_activeSection == 'top')
            _buildVocabSliver(topWordsAsync)
          else
            _buildVocabSliver(dictAsync),
        ],

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  Widget _buildVocabSliver(AsyncValue<List<Vocabulary>> asyncVal) {
    return asyncVal.when(
      data: (words) => words.isEmpty
          ? SliverToBoxAdapter(
              child: _EmptyState(
                icon: '📖',
                message: 'Mazmun ýüklenýär...',
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _VocabCard(
                  vocab: words[i],
                  favType: DbConstants.favTypeWord,
                ).animate(delay: Duration(milliseconds: i * 25))
                    .fadeIn(duration: 250.ms),
                childCount: words.length,
              ),
            ),
      loading: () => const SliverToBoxAdapter(child: _LoadingWidget()),
      error: (e, _) => SliverToBoxAdapter(child: _ErrorWidget(e.toString())),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3 — GÖNÜKME
// Özbaşdak gönükmeler — sapaga bagly däl
// ═══════════════════════════════════════════════════════════
class _ExercisesTab extends ConsumerWidget {
  const _ExercisesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(standaloneExercisesProvider);

    return exercisesAsync.when(
      data: (exercises) {
        if (exercises.isEmpty) {
          return const _EmptyState(icon: '✏️', message: 'Gönükme tapylmady');
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          itemCount: exercises.length,
          itemBuilder: (ctx, i) => _ExerciseCard(exercise: exercises[i])
              .animate(delay: Duration(milliseconds: i * 80))
              .fadeIn(duration: 350.ms)
              .slideY(begin: 0.15, end: 0),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _ErrorWidget(e.toString()),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 4 — SAÝLANANLAR
// ⭐ basyp saýlanan dialoglar + sözler
// ═══════════════════════════════════════════════════════════
class _FavoritesTab extends ConsumerWidget {
  const _FavoritesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favDialogsAsync = ref.watch(favoriteDialogsProvider);
    final favWordsAsync = ref.watch(favoriteWordsProvider);

    return CustomScrollView(
      slivers: [
        // ── Saýlanan dialoglar ──
        const SliverToBoxAdapter(
          child: _SectionHeader(icon: '💬', title: 'Saýlanan dialoglar', subtitle: ''),
        ),
        favDialogsAsync.when(
          data: (dialogs) => dialogs.isEmpty
              ? SliverToBoxAdapter(
                  child: _EmptyState(
                    icon: '💬',
                    message: 'Henüz dialog saýlanmady.\nDialog kartynda ⭐ bas.',
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _DialogCard(
                      dialog: dialogs[i],
                      favType: DbConstants.favTypeDialog,
                    ),
                    childCount: dialogs.length,
                  ),
                ),
          loading: () => const SliverToBoxAdapter(child: _LoadingWidget()),
          error: (e, _) => SliverToBoxAdapter(child: _ErrorWidget(e.toString())),
        ),

        // ── Saýlanan sözler ──
        const SliverToBoxAdapter(
          child: _SectionHeader(icon: '📖', title: 'Saýlanan sözler', subtitle: ''),
        ),
        favWordsAsync.when(
          data: (words) => words.isEmpty
              ? SliverToBoxAdapter(
                  child: _EmptyState(
                    icon: '📖',
                    message: 'Henüz söz saýlanmady.\nSöz kartynda ⭐ bas.',
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _VocabCard(
                      vocab: words[i],
                      favType: DbConstants.favTypeWord,
                    ),
                    childCount: words.length,
                  ),
                ),
          loading: () => const SliverToBoxAdapter(child: _LoadingWidget()),
          error: (e, _) => SliverToBoxAdapter(child: _ErrorWidget(e.toString())),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// KART WIDGETLERI
// ═══════════════════════════════════════════════════════════

class _DialogCard extends ConsumerStatefulWidget {
  final DialogModel dialog;
  final String favType;
  const _DialogCard({required this.dialog, required this.favType});

  @override
  ConsumerState<_DialogCard> createState() => _DialogCardState();
}

class _DialogCardState extends ConsumerState<_DialogCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final favArg = (type: widget.favType, id: widget.dialog.id);
    final favAsync = ref.watch(favoriteToggleProvider(favArg));
    final isFav = favAsync.valueOrNull ?? false;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06),
              blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          // ── Başlyk ──
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
            title: Text(widget.dialog.dialogName ?? '',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            subtitle: widget.dialog.contextTk?.isNotEmpty == true
                ? Text(widget.dialog.contextTk!,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12))
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ⭐ Saýla düwmesi
                IconButton(
                  icon: Icon(
                    isFav ? Icons.star_rounded : Icons.star_border_rounded,
                    color: isFav ? AppColors.secondary : AppColors.textTertiary,
                  ),
                  onPressed: () => ref
                      .read(favoriteToggleProvider(favArg).notifier)
                      .toggle(),
                ),
                // Giňelt / daralt
                IconButton(
                  icon: Icon(_expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded),
                  onPressed: () => setState(() => _expanded = !_expanded),
                ),
              ],
            ),
            onTap: () => setState(() => _expanded = !_expanded),
          ),

          // ── Dialog setirler (giňelende) ──
          if (_expanded) ...[
            const Divider(height: 1, indent: 16, endIndent: 16),
            ...widget.dialog.lines.map(
              (line) => _DialogLine(line: line),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _DialogLine extends StatelessWidget {
  final DialogLine line;
  const _DialogLine({required this.line});

  @override
  Widget build(BuildContext context) {
    final isMark = line.speaker == '—' || line.speaker == null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMark)
            Container(
              width: 28, height: 28,
              margin: const EdgeInsets.only(right: 10, top: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(line.speaker ?? '?',
                    style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w700, color: AppColors.primary)),
              ),
            )
          else
            Container(
              width: 28, height: 28,
              margin: const EdgeInsets.only(right: 10, top: 2),
              child: const Icon(Icons.remove_rounded, size: 16, color: Colors.grey),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(line.textRu,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(line.textTk ?? '',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VocabCard extends ConsumerWidget {
  final Vocabulary vocab;
  final String favType;
  const _VocabCard({required this.vocab, required this.favType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favArg = (type: favType, id: vocab.id);
    final favAsync = ref.watch(favoriteToggleProvider(favArg));
    final isFav = favAsync.valueOrNull ?? false;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05),
              blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vocab.wordRu,
                    style: const TextStyle(fontWeight: FontWeight.w700,
                        fontSize: 16, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(vocab.wordTk,
                    style: TextStyle(color: AppColors.primary,
                        fontSize: 14, fontWeight: FontWeight.w500)),
                if (vocab.exampleRu?.isNotEmpty == true) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vocab.exampleRu ?? '',
                            style: const TextStyle(fontSize: 12,
                                fontStyle: FontStyle.italic, color: AppColors.textPrimary)),
                        Text(vocab.exampleTk ?? '',
                            style: TextStyle(fontSize: 12,
                                color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isFav ? Icons.star_rounded : Icons.star_border_rounded,
              color: isFav ? AppColors.secondary : AppColors.textTertiary,
            ),
            onPressed: () =>
                ref.read(favoriteToggleProvider(favArg).notifier).toggle(),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  const _ExerciseCard({required this.exercise});

  IconData get _typeIcon => switch (exercise.exerciseType) {
        ExerciseType.flashcard => Icons.style_rounded,
        ExerciseType.fillBlank => Icons.edit_note_rounded,
        ExerciseType.multipleChoice => Icons.checklist_rounded,
        ExerciseType.matching => Icons.compare_arrows_rounded,
        ExerciseType.wordOrder => Icons.swap_vert_rounded,
        ExerciseType.translation => Icons.translate_rounded,
        ExerciseType.textQuestion => Icons.menu_book_rounded,
      };

  String get _typeLabel => exercise.exerciseType.displayName;

  Color get _typeColor => switch (exercise.exerciseType) {
        ExerciseType.flashcard => const Color(0xFF1565C0),
        ExerciseType.fillBlank => const Color(0xFF2E7D32),
        ExerciseType.multipleChoice => const Color(0xFFE65100),
        ExerciseType.matching => const Color(0xFF6A1B9A),
        ExerciseType.wordOrder => const Color(0xFF00838F),
        ExerciseType.translation => const Color(0xFFAD1457),
        ExerciseType.textQuestion => const Color(0xFF4527A0),
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.07),
              blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Üst bölüm ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _typeColor.withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _typeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_typeIcon, color: _typeColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exercise.titleTk ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w700,
                              fontSize: 15, color: AppColors.textPrimary)),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _typeColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(_typeLabel,
                                style: const TextStyle(color: Colors.white,
                                    fontSize: 11, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(width: 8),
                          Text('${exercise.questions.length} sorag',
                              style: TextStyle(color: AppColors.textSecondary,
                                  fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ── Bellik ──
          if (exercise.noteTk?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Text(exercise.noteTk!,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ),
          // ── Başla düwmesi ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _typeColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Başla', style: TextStyle(fontWeight: FontWeight.w700)),
                onPressed: () {
                  final lessonId = exercise.lessonId;
                  final path = switch (exercise.exerciseType) {
                    ExerciseType.flashcard => '/practice/$lessonId/flashcard',
                    ExerciseType.fillBlank => '/practice/$lessonId/fill-blank',
                    ExerciseType.multipleChoice =>
                      '/practice/$lessonId/multiple-choice',
                    ExerciseType.matching => '/practice/$lessonId/matching',
                    ExerciseType.wordOrder => '/practice/$lessonId/fill-blank',
                    ExerciseType.translation => '/practice/$lessonId/fill-blank',
                    ExerciseType.textQuestion =>
                      '/practice/$lessonId/multiple-choice',
                  };
                  context.push(path);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ÝARDAMÇY WIDGETLER
// ═══════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String icon, title, subtitle;
  const _SectionHeader(
      {required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w800,
                        fontSize: 16, color: AppColors.textPrimary)),
                if (subtitle.isNotEmpty)
                  Text(subtitle,
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SectionChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Text(label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.textSecondary,
            )),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  const _ErrorWidget(this.message);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text('Ýalňyşlyk: $message',
              style: const TextStyle(color: AppColors.error)),
        ),
      );
}

class _EmptyState extends StatelessWidget {
  final String icon, message;
  const _EmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          ],
        ),
      );
}
