import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/lesson.dart';
import '../../../data/models/user_progress.dart';
import '../../providers/lesson_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/level_provider.dart';
import '../../widgets/common/progress_card.dart';
import '../../widgets/common/lesson_grid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(currentLevelProvider);
    final lessonsAsync = ref.watch(allLessonsProvider);
    final progressAsync = ref.watch(allLessonProgressProvider);
    final statsAsync = ref.watch(statsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 170,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A2E),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.headerGradient),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.russianRed,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text('Я', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('RUSÇA ÖWRENIŞ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                                Text('Türkmenler üçin', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
                              ],
                            ),
                            const Spacer(),
                            // ── Dereje badge — basyp üýtgedip bolýar ──
                            _LevelBadge(level: level),
                            const SizedBox(width: 8),
                            _buildFlag(),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text('Salam! 👋', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 22, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('Öwrenmäge dowam et!', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
              title: Row(
                children: [
                  const Text('Rusça Öwreniş', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  _LevelPill(level: level),
                ],
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
            ),
          ),

          SliverToBoxAdapter(
            child: statsAsync.when(
              data: (s) => _buildStatsRow(s),
              loading: () => const SizedBox(height: 80),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),

          SliverToBoxAdapter(
            child: statsAsync.when(
              data: (s) => ProgressCard(
                percent: (s['overallPercent'] as double) / 100,
                completedLessons: s['completedLessons'] as int,
                totalLessons: s['totalLessons'] as int,
              ),
              loading: () => const _Shimmer(height: 100),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),

          // ── Dowam et — şu derejedäki ilkinji tamamlanmadyk sapak ──
          SliverToBoxAdapter(
            child: progressAsync.when(
              data: (prog) => lessonsAsync.when(
                data: (all) => _buildContinue(context,
                    all.where((l) => level.containsLesson(l.id)).toList(), prog),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),

          SliverToBoxAdapter(child: _buildQuickAccess(context)),

          // ── Sapaklar başlygy ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text('📚 ${level.label} Sapaklar',
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  lessonsAsync.when(
                    data: (all) {
                      final cnt = all.where((l) => level.containsLesson(l.id)).length;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _levelColor(level).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('$cnt sapak',
                            style: TextStyle(fontSize: 12, color: _levelColor(level), fontWeight: FontWeight.w600)),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          // ── Sapak grid — diňe bu dereje ──
          SliverToBoxAdapter(
            child: lessonsAsync.when(
              data: (all) {
                final filtered = all.where((l) => level.containsLesson(l.id)).toList();
                if (filtered.isEmpty) return _buildEmpty(context, level);
                return progressAsync.when(
                  data: (prog) => LessonGrid(
                    lessons: filtered,
                    progressList: prog,
                    onLessonTap: (l) => context.push('/lesson/${l.id}'),
                  ),
                  loading: () => const _Shimmer(height: 300),
                  error: (_, __) => const SizedBox.shrink(),
                );
              },
              loading: () => const _Shimmer(height: 300),
              error: (_, __) => _buildError(context),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Color _levelColor(AppLevel l) => switch (l) {
    AppLevel.a1 => const Color(0xFF4CAF50),
    AppLevel.a2 => const Color(0xFF2196F3),
    AppLevel.b1 => const Color(0xFFFF9800),
    AppLevel.b2 => const Color(0xFFE91E63),
  };

  Widget _buildFlag() => SizedBox(
    width: 32, height: 22,
    child: Column(children: [
      Expanded(child: Container(color: Colors.white)),
      Expanded(child: Container(color: AppColors.russianBlue)),
      Expanded(child: Container(color: AppColors.russianRed)),
    ]),
  );

  Widget _buildStatsRow(Map<String, dynamic> s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(children: [
        _Chip(icon: '📝', label: 'Tamamlandy',
            value: '${s['completedLessons']}/${s['totalLessons']}', color: AppColors.success),
        const SizedBox(width: 12),
        _Chip(icon: '📖', label: 'Sözler', value: '${s['totalVocabStudied']}', color: AppColors.info),
        const SizedBox(width: 12),
        _Chip(icon: '🎯', label: 'Bäl',
            value: '${(s['avgScore'] as double).toStringAsFixed(0)}%', color: AppColors.secondary),
      ]),
    ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildContinue(BuildContext ctx, List<Lesson> lessons, List<LessonProgress> prog) {
    Lesson? cur;
    for (final l in lessons) {
      final p = prog.firstWhere((p) => p.lessonId == l.id,
          orElse: () => LessonProgress(id: 0, lessonId: l.id, exercisesTotal: 5));
      if (!p.isCompleted) { cur = l; break; }
    }
    if (cur == null) return const SizedBox.shrink();
    final p = prog.firstWhere((p) => p.lessonId == cur!.id,
        orElse: () => LessonProgress(id: 0, lessonId: cur!.id, exercisesTotal: 5));
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: GestureDetector(
        onTap: () => ctx.push('/lesson/${cur!.id}'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFCC0000), Color(0xFF880000)]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: AppColors.russianRed.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              _pill('Sapak ${cur.sapakNumber.toString().padLeft(2, '0')}'),
              const SizedBox(width: 8),
              Text('▶ Dowam et', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ]),
            const SizedBox(height: 8),
            Text(cur.titleRu, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            Text(cur.titleTk, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13)),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: p.progressPercent,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 4),
            Text('${(p.progressPercent * 100).toInt()}% tamamlandy',
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
          ]),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _pill(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
  );

  Widget _buildQuickAccess(BuildContext ctx) {
    final items = [
      ('💬', 'Söhbet', const Color(0xFF1565C0), () => ctx.push('/conversations')),
      ('📐', 'Grammatika', const Color(0xFF2E7D32), () => ctx.push('/grammar')),
      ('📚', 'Sapaklar', const Color(0xFFD4A017), () => ctx.push('/lessons')),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: items.asMap().entries.map((e) {
          final (icon, label, color, onTap) = e.value;
          return Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(right: e.key < 2 ? 12 : 0),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withOpacity(0.2)),
                ),
                child: Column(children: [
                  Text(icon, style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 6),
                  Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                ]),
              ),
            ).animate(delay: Duration(milliseconds: 400 + e.key * 100))
                .fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmpty(BuildContext ctx, AppLevel level) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
        ),
        child: Column(children: [
          Text(level.emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text('${level.label} derejesi henüz taýýar däl',
              style: Theme.of(ctx).textTheme.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('Bu dereje üçin sapaklar goşulyp barylýar.\nHäzir başga derejäni saýlap bilýärsiň.',
              style: Theme.of(ctx).textTheme.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => ctx.push('/level-select?change=true'),
            icon: const Icon(Icons.swap_horiz_rounded),
            label: const Text('Dereje üýtget'),
          ),
        ]),
      ),
    );
  }

  Widget _buildError(BuildContext ctx) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('⚠️', style: TextStyle(fontSize: 40)),
      const SizedBox(height: 12),
      Text(AppStrings.errorLoading, style: Theme.of(ctx).textTheme.titleMedium),
    ]),
  );

  Widget _buildBottomNav(BuildContext ctx) => Container(
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4)),
    ]),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _Nav(icon: Icons.home_rounded, label: 'Baş', selected: true, onTap: () {}),
          _Nav(icon: Icons.menu_book_rounded, label: 'Sapaklar', selected: false, onTap: () => ctx.push('/lessons')),
          _Nav(icon: Icons.chat_bubble_outline_rounded, label: 'Söhbet', selected: false, onTap: () => ctx.push('/conversations')),
          _Nav(icon: Icons.psychology_outlined, label: 'Grammatika', selected: false, onTap: () => ctx.push('/grammar')),
          _Nav(icon: Icons.local_library_rounded, label: 'Kitaphana', selected: false, onTap: () => ctx.push('/library')),
        ]),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Dereje badge (expanded halda) — bassaň /level-select?change=true
// ─────────────────────────────────────────────────────────────
class _LevelBadge extends ConsumerWidget {
  final AppLevel level;
  const _LevelBadge({required this.level});

  Color get _c => switch (level) {
    AppLevel.a1 => const Color(0xFF4CAF50),
    AppLevel.a2 => const Color(0xFF2196F3),
    AppLevel.b1 => const Color(0xFFFF9800),
    AppLevel.b2 => const Color(0xFFE91E63),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.push('/level-select?change=true'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _c.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _c.withOpacity(0.5)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(level.emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(level.label, style: TextStyle(color: _c, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
          const SizedBox(width: 4),
          Icon(Icons.expand_more_rounded, color: _c, size: 16),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Dereje pill (pinned AppBar-da kiçi)
// ─────────────────────────────────────────────────────────────
class _LevelPill extends StatelessWidget {
  final AppLevel level;
  const _LevelPill({required this.level});

  Color get _c => switch (level) {
    AppLevel.a1 => const Color(0xFF4CAF50),
    AppLevel.a2 => const Color(0xFF2196F3),
    AppLevel.b1 => const Color(0xFFFF9800),
    AppLevel.b2 => const Color(0xFFE91E63),
  };

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(color: _c, borderRadius: BorderRadius.circular(10)),
    child: Text(level.label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
  );
}

// ─────────────────────────────────────────────────────────────
// Kiçi helper widgetler
// ─────────────────────────────────────────────────────────────
class _Chip extends StatelessWidget {
  final String icon, label, value; final Color color;
  const _Chip({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$icon $value', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
      ]),
    ),
  );
}

class _Nav extends StatelessWidget {
  final IconData icon; final String label; final bool selected; final VoidCallback onTap;
  const _Nav({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: selected ? AppColors.primary : AppColors.textTertiary, size: 24),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 11,
          color: selected ? AppColors.primary : AppColors.textTertiary,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
    ]),
  );
}

class _Shimmer extends StatelessWidget {
  final double height;
  const _Shimmer({required this.height});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    height: height,
    decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(16)),
  );
}
