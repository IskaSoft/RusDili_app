import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/lesson.dart';
import '../../../../data/models/user_progress.dart';

class LessonGrid extends StatelessWidget {
  final List<Lesson> lessons;
  final List<LessonProgress> progressList;
  final Function(Lesson) onLessonTap;

  const LessonGrid({
    super.key,
    required this.lessons,
    required this.progressList,
    required this.onLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.15,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        final progress = progressList.firstWhere(
          (p) => p.lessonId == lesson.id,
          orElse:
              () =>
                  LessonProgress(id: 0, lessonId: lesson.id, exercisesTotal: 5),
        );

        final isCompleted = progress.isCompleted;
        final isInProgress = !isCompleted && progress.exercisesDone > 0;
        final pct = progress.progressPercent;

        final accentColor =
            isCompleted
                ? AppColors.success
                : isInProgress
                ? AppColors.info
                : AppColors.primary;

        return GestureDetector(
              onTap: () => onLessonTap(lesson),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isCompleted
                            ? accentColor.withOpacity(0.4)
                            : AppColors.border,
                    width: isCompleted ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color:
                                isCompleted
                                    ? accentColor
                                    : accentColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child:
                                isCompleted
                                    ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                    : Text(
                                      lesson.sapakNumber.toString().padLeft(
                                        2,
                                        '0',
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color:
                                            isCompleted
                                                ? Colors.white
                                                : accentColor,
                                      ),
                                    ),
                          ),
                        ),
                        if (isInProgress)
                          Text(
                            '${(pct * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: accentColor,
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      lesson.titleRu,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.titleTk,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (isInProgress) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: pct,
                          backgroundColor: accentColor.withOpacity(0.12),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            accentColor,
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            )
            .animate(delay: (index * 50).ms)
            .fadeIn()
            .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
      },
    );
  }
}
