import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/practice_provider.dart';
import '../../providers/lesson_provider.dart';

class MatchingScreen extends ConsumerStatefulWidget {
  final int lessonId;
  const MatchingScreen({super.key, required this.lessonId});

  @override
  ConsumerState<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends ConsumerState<MatchingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Load vocab for matching
      final repo = ref.read(lessonRepositoryProvider);
      final vocab = await repo.getVocabularyForLesson(widget.lessonId);

      if (vocab.isEmpty) return;

      // Build pairs from vocabulary (up to 6 pairs)
      final pairs = <String, String>{};
      for (final v in vocab.take(6)) {
        pairs[v.wordRu] = v.wordTk;
      }

      // FIXED: Use ref.read(matchingProvider(widget.lessonId).notifier)
      ref.read(matchingProvider(widget.lessonId).notifier).loadPairs(pairs);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(matchingProvider(widget.lessonId));

    if (state.leftItems.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.isFinished) return _buildFinished(context, state);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Deňleşdir · ${state.userMatches.length}/${state.correctPairs.length}',
        ),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value:
                    state.correctPairs.isEmpty
                        ? 0
                        : state.userMatches.length / state.correctPairs.length,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.secondary,
                ),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Çep we sag sütünden gabat gelenleri saýla!',
              style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
            ),
            const SizedBox(height: 20),

            // Two-column matching
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column
                  Expanded(
                    child: Column(
                      children:
                          state.leftItems.asMap().entries.map((entry) {
                            final item = entry.value;
                            final isMatched = state.userMatches.containsKey(
                              item,
                            );
                            final isCorrect =
                                isMatched && state.isPairCorrect(item);
                            final isSelected = state.selectedLeft == item;
                            return _MatchTile(
                              text: item,
                              isMatched: isMatched,
                              isCorrect: isCorrect,
                              isSelected: isSelected,
                              onTap:
                                  isMatched
                                      ? null
                                      : () => ref
                                          .read(
                                            matchingProvider(
                                              widget.lessonId,
                                            ).notifier,
                                          )
                                          .selectLeft(item),
                              index: entry.key,
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Right column
                  Expanded(
                    child: Column(
                      children:
                          state.rightItems.asMap().entries.map((entry) {
                            final item = entry.value;
                            final isMatched = state.userMatches.containsValue(
                              item,
                            );
                            final isSelected = state.selectedRight == item;
                            return _MatchTile(
                              text: item,
                              isMatched: isMatched,
                              isCorrect: isMatched,
                              isSelected: isSelected,
                              onTap:
                                  isMatched
                                      ? null
                                      : () => ref
                                          .read(
                                            matchingProvider(
                                              widget.lessonId,
                                            ).notifier,
                                          )
                                          .selectRight(item),
                              index: entry.key,
                              isRight: true,
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed:
                    () =>
                        ref
                            .read(matchingProvider(widget.lessonId).notifier)
                            .reset(),
                icon: const Icon(Icons.shuffle_rounded, size: 18),
                label: const Text('Täzeden gatyşdyr'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildFinished(BuildContext context, MatchingState state) {
    final pct =
        state.correctPairs.isEmpty
            ? 0.0
            : (state.correctCount / state.correctPairs.length) * 100;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pct == 100 ? '🏆' : '🎯',
                style: const TextStyle(fontSize: 72),
              ).animate().scale(begin: const Offset(0, 0)),
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
                '${state.correctCount}/${state.correctPairs.length} jübüt dogry',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          () =>
                              ref
                                  .read(
                                    matchingProvider(widget.lessonId).notifier,
                                  )
                                  .reset(),
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Täzeden'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Tamamla'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
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

class _MatchTile extends StatelessWidget {
  final String text;
  final bool isMatched;
  final bool isCorrect;
  final bool isSelected;
  final VoidCallback? onTap;
  final int index;
  final bool isRight;

  const _MatchTile({
    required this.text,
    required this.isMatched,
    required this.isCorrect,
    required this.isSelected,
    required this.onTap,
    required this.index,
    this.isRight = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = AppColors.surface;
    Color border = AppColors.border;
    Color textColor = AppColors.textPrimary;

    if (isMatched && isCorrect) {
      bg = AppColors.successSurface;
      border = AppColors.success;
      textColor = AppColors.success;
    } else if (isMatched && !isCorrect) {
      bg = AppColors.errorSurface;
      border = AppColors.error;
      textColor = AppColors.error;
    } else if (isSelected) {
      bg = AppColors.secondarySurface;
      border = AppColors.secondary;
      textColor = AppColors.secondary;
    }

    return GestureDetector(
      onTap: onTap,
      child:
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: border, width: isSelected ? 2 : 1),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: textColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: isRight ? TextAlign.end : TextAlign.start,
            ),
          ).animate(delay: (index * 60).ms).fadeIn(),
    );
  }
}
