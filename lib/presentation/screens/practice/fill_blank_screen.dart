import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/exercise.dart';
import '../../providers/practice_provider.dart';

class FillBlankScreen extends ConsumerStatefulWidget {
  final int lessonId;
  const FillBlankScreen({super.key, required this.lessonId});

  @override
  ConsumerState<FillBlankScreen> createState() => _FillBlankScreenState();
}

class _FillBlankScreenState extends ConsumerState<FillBlankScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(practiceProvider.notifier).loadExercises(
            widget.lessonId,
            type: ExerciseType.fillBlank,
          );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(practiceProvider);

    if (state.status == PracticeStatus.loading ||
        state.status == PracticeStatus.idle) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }
    if (state.status == PracticeStatus.finished) {
      return _FinishedView(
          state: state,
          onRestart: () =>
              ref.read(practiceProvider.notifier).restart(),
          onClose: () {
            ref.read(practiceProvider.notifier).reset();
            context.pop();
          });
    }
    if (state.status == PracticeStatus.error) {
      return Scaffold(
          body: Center(
              child: Text(state.errorMessage ?? 'Ýalňyşlyk')));
    }

    final question = state.currentQuestion;
    if (question == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Boş Ýer · ${state.progressText}'),
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
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 4,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Score + hint row
              Row(
                children: [
                  _ScoreBadge(
                      emoji: '✅',
                      count: state.correctCount,
                      color: AppColors.success),
                  const SizedBox(width: 8),
                  _ScoreBadge(
                      emoji: '❌',
                      count: state.incorrectCount,
                      color: AppColors.error),
                  const Spacer(),
                  if (question.hintTk != null)
                    TextButton.icon(
                      onPressed: () => ref
                          .read(practiceProvider.notifier)
                          .toggleHint(),
                      icon: const Icon(Icons.lightbulb_outline,
                          size: 16),
                      label: const Text('Maslahat'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.secondary,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        textStyle: const TextStyle(fontSize: 12),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Boş ýeri doldur:',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                          letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      question.questionText,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        height: 1.65,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: -0.1),

              // Hint banner
              if (state.showHint && question.hintTk != null)
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color:
                            AppColors.secondary.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Text('💡',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(question.hintTk!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                      AppColors.textSecondary))),
                    ],
                  ),
                ).animate().fadeIn(),

              const SizedBox(height: 16),

              // Answer result or text field
              if (state.status == PracticeStatus.checking)
                _AnswerResult(state: state, question: question)
              else
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: 'Jogabyny ýaz...',
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                size: 20),
                            onPressed: () =>
                                setState(() => _controller.clear()),
                          )
                        : null,
                  ),
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (_) => _submit(),
                ),

              const Spacer(),

              // Action button
              SizedBox(
                width: double.infinity,
                child: state.status == PracticeStatus.checking
                    ? ElevatedButton.icon(
                        onPressed: () {
                          ref
                              .read(practiceProvider.notifier)
                              .nextQuestion();
                          _controller.clear();
                          if (!state.isLastQuestion) {
                            Future.delayed(
                                const Duration(milliseconds: 300),
                                () => _focusNode.requestFocus());
                          }
                        },
                        icon: Icon(state.isLastQuestion
                            ? Icons.emoji_events_rounded
                            : Icons.arrow_forward_rounded),
                        label: Text(state.isLastQuestion
                            ? 'Netijeleri Gör'
                            : 'Indiki →'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16),
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14)),
                        ),
                      )
                    : ElevatedButton(
                        onPressed:
                            _controller.text.isNotEmpty
                                ? _submit
                                : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16),
                          backgroundColor: AppColors.primary,
                          disabledBackgroundColor:
                              AppColors.border,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14)),
                        ),
                        child: const Text('Barla ✓',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_controller.text.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    ref
        .read(practiceProvider.notifier)
        .submitAnswer(_controller.text.trim());
  }
}

class _AnswerResult extends StatelessWidget {
  final PracticeState state;
  final ExerciseQuestion question;
  const _AnswerResult({required this.state, required this.question});

  @override
  Widget build(BuildContext context) {
    final isCorrect = state.isAnswerCorrect ?? false;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.successSurface
            : AppColors.errorSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: isCorrect ? AppColors.success : AppColors.error,
            width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isCorrect ? '✅ Dogry!' : '❌ Ýalňyş!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isCorrect
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
              const Spacer(),
              Text(
                'Siz: ${state.selectedAnswer}',
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary),
              ),
            ],
          ),
          if (!isCorrect) ...[
            const SizedBox(height: 8),
            Text(
              'Dogry jogap: ${question.correctAnswer}',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.success),
            ),
          ],
          if (question.hintTk != null) ...[
            const SizedBox(height: 6),
            Text('📌 ${question.hintTk}',
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary)),
          ],
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _ScoreBadge extends StatelessWidget {
  final String emoji;
  final int count;
  final Color color;
  const _ScoreBadge(
      {required this.emoji,
      required this.count,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text('$emoji $count',
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color)),
    );
  }
}

// ── Shared Finished View ─────────────────────────────────────────────────────
class _FinishedView extends StatelessWidget {
  final PracticeState state;
  final VoidCallback onRestart;
  final VoidCallback onClose;
  const _FinishedView(
      {required this.state,
      required this.onRestart,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    final pct = state.scorePercent;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pct >= 80 ? '🏆' : pct >= 60 ? '🎯' : '💪',
                style: const TextStyle(fontSize: 72),
              ).animate().scale(
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1)),
              const SizedBox(height: 24),
              Text(
                '${pct.toStringAsFixed(0)}%',
                style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary),
              ).animate(delay: 200.ms).fadeIn(),
              Text(
                '${state.correctCount}/${state.totalQuestions} dogry',
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary),
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
                    color: AppColors.primary),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14))),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14))),
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
