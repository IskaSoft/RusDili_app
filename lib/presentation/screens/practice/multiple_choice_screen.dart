import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/exercise.dart';
import '../../providers/practice_provider.dart';
import 'fill_blank_screen.dart';

class MultipleChoiceScreen extends ConsumerWidget {
  final int lessonId;
  const MultipleChoiceScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(practiceProvider);

    // Load on first build
    if (state.status == PracticeStatus.idle ||
        (state.status == PracticeStatus.active && state.lessonId != lessonId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(practiceProvider.notifier)
            .loadExercises(lessonId, type: ExerciseType.multipleChoice);
      });
    }

    if (state.status == PracticeStatus.loading ||
        (state.status == PracticeStatus.idle)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.status == PracticeStatus.finished) {
      return _FinishedView(
        state: state,
        onRestart: () => ref.read(practiceProvider.notifier).restart(),
        onClose: () {
          ref.read(practiceProvider.notifier).reset();
          context.pop();
        },
      );
    }

    if (state.status == PracticeStatus.error) {
      return Scaffold(
        body: Center(child: Text(state.errorMessage ?? 'Ýalňyşlyk')),
      );
    }

    final question = state.currentQuestion;
    if (question == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Build options — from DB or generate from correctAnswer
    final options =
        question.options.isNotEmpty
            ? question.options
            : [
              ExerciseOption(
                id: 0,
                questionId: question.id,
                optionText: question.correctAnswer,
                isCorrect: true,
              ),
            ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Köp Saýlaw · ${state.progressText}'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            ref.read(practiceProvider.notifier).reset();
            context.pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (state.currentIndex + 1) / state.totalQuestions,
            backgroundColor: AppColors.border,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.info),
            minHeight: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Score row
            Row(
              children: [
                _ScoreBadge(
                  emoji: '✅',
                  count: state.correctCount,
                  color: AppColors.success,
                ),
                const SizedBox(width: 8),
                _ScoreBadge(
                  emoji: '❌',
                  count: state.incorrectCount,
                  color: AppColors.error,
                ),
                const Spacer(),
                Text(
                  '${state.currentIndex + 1}/${state.totalQuestions}',
                  style: const TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Question card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                question.questionText,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 1.65,
                  color: AppColors.textPrimary,
                ),
              ),
            ).animate().fadeIn().slideY(begin: -0.1),
            const SizedBox(height: 20),

            // Options list
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return _OptionTile(
                    option: option,
                    isSelected: state.selectedAnswer == option.optionText,
                    isChecking: state.status == PracticeStatus.checking,
                    onTap:
                        state.status == PracticeStatus.active
                            ? () => ref
                                .read(practiceProvider.notifier)
                                .submitAnswer(option.optionText)
                            : null,
                    index: index,
                  );
                },
              ),
            ),

            // Next button after checking
            if (state.status == PracticeStatus.checking) ...[
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      () => ref.read(practiceProvider.notifier).nextQuestion(),
                  icon: Icon(
                    state.isLastQuestion
                        ? Icons.emoji_events_rounded
                        : Icons.arrow_forward_rounded,
                  ),
                  label: Text(
                    state.isLastQuestion ? 'Netijeleri Gör' : 'Indiki →',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final ExerciseOption option;
  final bool isSelected;
  final bool isChecking;
  final VoidCallback? onTap;
  final int index;

  const _OptionTile({
    required this.option,
    required this.isSelected,
    required this.isChecking,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = AppColors.surface;
    Color border = AppColors.border;
    Color textColor = AppColors.textPrimary;
    Widget? trailing;

    if (isChecking && isSelected) {
      if (option.isCorrect) {
        bg = AppColors.successSurface;
        border = AppColors.success;
        textColor = AppColors.success;
        trailing = const Icon(
          Icons.check_circle_rounded,
          color: AppColors.success,
          size: 22,
        );
      } else {
        bg = AppColors.errorSurface;
        border = AppColors.error;
        textColor = AppColors.error;
        trailing = const Icon(
          Icons.cancel_rounded,
          color: AppColors.error,
          size: 22,
        );
      }
    } else if (isChecking && option.isCorrect) {
      bg = AppColors.successSurface;
      border = AppColors.success;
      textColor = AppColors.success;
      trailing = const Icon(
        Icons.check_circle_outlined,
        color: AppColors.success,
        size: 22,
      );
    } else if (isSelected) {
      bg = AppColors.infoSurface;
      border = AppColors.info;
      textColor = AppColors.info;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: border,
            width: (isSelected || (isChecking && option.isCorrect)) ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: border.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(color: border),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index), // A,B,C,D
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: border,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.optionText,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ).animate(delay: (index * 60).ms).fadeIn().slideX(begin: 0.1),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  final String emoji;
  final int count;
  final Color color;
  const _ScoreBadge({
    required this.emoji,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$emoji $count',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// ── Shared Finished View ───────────────────────────────────────────────────
class _FinishedView extends StatelessWidget {
  final PracticeState state;
  final VoidCallback onRestart;
  final VoidCallback onClose;
  const _FinishedView({
    required this.state,
    required this.onRestart,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final pct = state.scorePercent * 100; // Convert to percentage
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pct >= 80
                    ? '🏆'
                    : pct >= 60
                    ? '🎯'
                    : '💪',
                style: const TextStyle(fontSize: 72),
              ),
              const SizedBox(height: 24),
              Text(
                '${pct.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${state.correctCount}/${state.totalQuestions} dogry',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                pct >= 80
                    ? 'Ajaýyp! 🔥'
                    : pct >= 60
                    ? 'Gowy netije! 👍'
                    : 'Gaýtadan synanyş! 💪',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onRestart,
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Täzeden'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onClose,
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Tamamla'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
