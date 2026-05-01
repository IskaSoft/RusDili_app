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
import '../../widgets/common/progress_card.dart';
import '../../widgets/common/lesson_grid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsAsync = ref.watch(allLessonsProvider);
    final progressAsync = ref.watch(allLessonProgressProvider);
    final statsAsync = ref.watch(statsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ───────────────────────────────────────
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A2E),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.headerGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.russianRed,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Я',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'RUSÇA ÖWRENIŞ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  'Türkmenler üçin · A1',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 11,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Flag
                            _buildRussianFlag(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Salam! 👋',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Öwrenmäge dowam et!',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: const Text(
                'Rusça Öwreniş',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
            ),
          ),

          // ── Stats Row ─────────────────────────────────────
          SliverToBoxAdapter(
            child: statsAsync.when(
              data: (stats) => _buildStatsRow(stats),
              loading: () => const SizedBox(height: 80),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),

          // ── Overall Progress ──────────────────────────────
          SliverToBoxAdapter(
            child: statsAsync.when(
              data:
                  (stats) => ProgressCard(
                    percent: (stats['overallPercent'] as double) / 100,
                    completedLessons: stats['completedLessons'] as int,
                    totalLessons: stats['totalLessons'] as int,
                  ),
              loading: () => const _ShimmerCard(height: 100),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),

          // ── Continue Lesson ───────────────────────────────
          SliverToBoxAdapter(
            child: progressAsync.when(
              data:
                  (progressList) => lessonsAsync.when(
                    data:
                        (lessons) => _buildContinueSection(
                          context,
                          lessons,
                          progressList,
                        ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),

          // ── Quick Access ──────────────────────────────────
          SliverToBoxAdapter(child: _buildQuickAccess(context)),

          // ── Lesson Grid ───────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                '📚 ${AppStrings.allLessons}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: lessonsAsync.when(
              data:
                  (lessons) => progressAsync.when(
                    data:
                        (progressList) => LessonGrid(
                          lessons: lessons,
                          progressList: progressList,
                          onLessonTap:
                              (lesson) => context.push('/lesson/${lesson.id}'),
                        ),
                    loading: () => const _ShimmerCard(height: 300),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
              loading: () => const _ShimmerCard(height: 300),
              error: (_, __) => _buildErrorState(context),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),

      // ── Bottom Nav ─────────────────────────────────────────
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildRussianFlag() {
    return SizedBox(
      width: 32,
      height: 22,
      child: Column(
        children: [
          Expanded(child: Container(color: Colors.white)),
          Expanded(child: Container(color: AppColors.russianBlue)),
          Expanded(child: Container(color: AppColors.russianRed)),
        ],
      ),
    );
  }

  Widget _buildStatsRow(Map<String, dynamic> stats) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              _StatChip(
                icon: '📝',
                label: 'Tamamlandy',
                value: '${stats['completedLessons']}/10',
                color: AppColors.success,
              ),
              const SizedBox(width: 12),
              _StatChip(
                icon: '📖',
                label: 'Sözler',
                value: '${stats['totalVocabStudied']}',
                color: AppColors.info,
              ),
              const SizedBox(width: 12),
              _StatChip(
                icon: '🎯',
                label: 'Bäl',
                value: '${(stats['avgScore'] as double).toStringAsFixed(0)}%',
                color: AppColors.secondary,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 500.ms, delay: 200.ms)
        .slideX(begin: -0.2, end: 0);
  }

  Widget _buildContinueSection(
    BuildContext context,
    List<Lesson> lessons,
    List<LessonProgress> progressList,
  ) {
    // Find the last in-progress or next lesson
    Lesson? currentLesson;
    for (final lesson in lessons) {
      final progress = progressList.firstWhere(
        (p) => p.lessonId == lesson.id,
        orElse:
            () => LessonProgress(id: 0, lessonId: lesson.id, exercisesTotal: 5),
      );
      if (!progress.isCompleted) {
        currentLesson = lesson;
        break;
      }
    }

    if (currentLesson == null) return const SizedBox.shrink();

    final progress = progressList.firstWhere(
      (p) => p.lessonId == currentLesson!.id,
      orElse:
          () => LessonProgress(
            id: 0,
            lessonId: currentLesson!.id,
            exercisesTotal: 5,
          ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: GestureDetector(
        onTap: () => context.push('/lesson/${currentLesson!.id}'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFCC0000), Color(0xFF880000)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.russianRed.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Sapak ${currentLesson.sapakNumber.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                currentLesson.titleRu,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                currentLesson.titleTk,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress.progressPercent,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${(progress.progressPercent * 100).toInt()}% tamamlandy',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildQuickAccess(BuildContext context) {
    final items = [
      _QuickItem(
        icon: '💬',
        label: 'Söhbetdeşlik',
        color: const Color(0xFF1565C0),
        onTap: () => context.push('/conversations'),
      ),
      _QuickItem(
        icon: '📐',
        label: 'Grammatika',
        color: const Color(0xFF2E7D32),
        onTap: () => context.push('/grammar'),
      ),
      _QuickItem(
        icon: '📚',
        label: 'Sapaklar',
        color: const Color(0xFFD4A017),
        onTap: () => context.push('/lessons'),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children:
            items
                .asMap()
                .entries
                .map(
                  (e) => Expanded(
                    child: GestureDetector(
                          onTap: e.value.onTap,
                          child: Container(
                            margin: EdgeInsets.only(right: e.key < 2 ? 12 : 0),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: e.value.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: e.value.color.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  e.value.icon,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  e.value.label,
                                  style: TextStyle(
                                    color: e.value.color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate(
                          delay: Duration(milliseconds: 400 + e.key * 100),
                        )
                        .fadeIn(duration: 400.ms)
                        .scale(begin: const Offset(0.9, 0.9)),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            AppStrings.errorLoading,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Baş',
                isSelected: true,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.menu_book_rounded,
                label: 'Sapaklar',
                isSelected: false,
                onTap: () => context.push('/lessons'),
              ),
              _NavItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Söhbet',
                isSelected: false,
                onTap: () => context.push('/conversations'),
              ),
              _NavItem(
                icon: Icons.psychology_outlined,
                label: 'Grammatika',
                isSelected: false,
                onTap: () => context.push('/grammar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$icon $value',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickItem {
  final String icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textTertiary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  final double height;

  const _ShimmerCard({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
