import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/lesson.dart';
import '../../../data/models/user_progress.dart';
import '../../providers/lesson_provider.dart';
import '../../providers/progress_provider.dart';

class LessonListScreen extends ConsumerWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsAsync = ref.watch(allLessonsProvider);
    final progressAsync = ref.watch(refreshableProgressProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ähli Sapaklar'),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: lessonsAsync.when(
        data: (lessons) => progressAsync.when(
          data: (progress) => _buildList(context, lessons, progress),
          loading: () => _buildList(context, lessons, []),
          error: (_, __) => _buildList(context, lessons, []),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ýalňyşlyk: $e')),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Lesson> lessons,
      List<LessonProgress> progressList) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        final progress = progressList.firstWhere(
          (p) => p.lessonId == lesson.id,
          orElse: () =>
              LessonProgress(id: 0, lessonId: lesson.id, exercisesTotal: 3),
        );
        return _LessonListTile(lesson: lesson, progress: progress, index: index);
      },
    );
  }
}

class _LessonListTile extends StatelessWidget {
  final Lesson lesson;
  final LessonProgress progress;
  final int index;

  const _LessonListTile({
    required this.lesson,
    required this.progress,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = progress.isCompleted;
    final isInProgress = !isCompleted && progress.exercisesDone > 0;
    final percent = progress.progressPercent;

    final accentColor = isCompleted
        ? AppColors.success
        : isInProgress
            ? AppColors.info
            : AppColors.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => context.push('/lesson/${lesson.id}'),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCompleted
                  ? AppColors.success.withOpacity(0.4)
                  : AppColors.border,
              width: isCompleted ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.success
                      : accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isCompleted
                        ? AppColors.success
                        : accentColor.withOpacity(0.3),
                  ),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check_rounded,
                          color: Colors.white, size: 22)
                      : Text(
                          lesson.sapakNumber.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: accentColor,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.titleRu,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      lesson.titleTk,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (lesson.subtitleTk != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        lesson.subtitleTk!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (isInProgress || isCompleted) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: isCompleted ? 1.0 : percent,
                              backgroundColor:
                                  accentColor.withOpacity(0.12),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  accentColor),
                              minHeight: 4,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isCompleted
                                ? '100%'
                                : '${(percent * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: accentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: (index * 60).ms).fadeIn().slideX(begin: 0.1);
  }
}
