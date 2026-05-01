import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/practice_provider.dart';

class FlashcardScreen extends ConsumerStatefulWidget {
  final int lessonId;
  const FlashcardScreen({super.key, required this.lessonId});

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipCtrl;
  late Animation<double> _flipAnim;

  @override
  void initState() {
    super.initState();
    _flipCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _flipAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _flipCtrl, curve: Curves.easeInOut));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(flashcardProvider(widget.lessonId).notifier)
          .loadCards(widget.lessonId);
    });
  }

  @override
  void dispose() {
    _flipCtrl.dispose();
    super.dispose();
  }

  void _flip() {
    ref.read(flashcardProvider(widget.lessonId).notifier).flipCard();
    if (_flipCtrl.status == AnimationStatus.dismissed) {
      _flipCtrl.forward();
    } else {
      _flipCtrl.reverse();
    }
  }

  void _resetFlip() => _flipCtrl.reset();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(flashcardProvider(widget.lessonId));

    if (state.cards.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.isFinished) return _buildFinished(context, state);

    final card = state.currentCard!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Flash Kart · ${state.progressText}'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (state.currentIndex + 1) / state.totalCards,
            backgroundColor: AppColors.border,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ScorePill(
                  label: '✅ Bildim',
                  count: state.knownCount,
                  color: AppColors.success,
                ),
                const SizedBox(width: 16),
                _ScorePill(
                  label: '❌ Bilmedim',
                  count: state.unknownCount,
                  color: AppColors.error,
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Flip card
            Expanded(
              child: GestureDetector(
                onTap: _flip,
                child: AnimatedBuilder(
                  animation: _flipAnim,
                  builder: (_, __) {
                    final angle = _flipAnim.value * math.pi;
                    final isBack = angle > math.pi / 2;
                    return Transform(
                      transform:
                          Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(angle),
                      alignment: Alignment.center,
                      child:
                          isBack
                              ? Transform(
                                transform: Matrix4.identity()..rotateY(math.pi),
                                alignment: Alignment.center,
                                child: _CardBack(text: card.correctAnswer),
                              )
                              : _CardFront(text: card.questionText),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),
            Text(
              state.isFlipped ? 'Bildimi?' : 'Bas → Terjimesini gör',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            if (state.isFlipped)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _resetFlip();
                        ref
                            .read(flashcardProvider(widget.lessonId).notifier)
                            .markUnknown();
                      },
                      icon: const Icon(Icons.close_rounded, size: 20),
                      label: const Text('Bilmedim'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
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
                      onPressed: () {
                        _resetFlip();
                        ref
                            .read(flashcardProvider(widget.lessonId).notifier)
                            .markKnown();
                      },
                      icon: const Icon(Icons.check_rounded, size: 20),
                      label: const Text('Bildim!'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _flip,
                  icon: const Icon(Icons.flip_rounded, size: 20),
                  label: const Text('Öwür'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildFinished(BuildContext context, FlashcardState state) {
    final total = state.knownCount + state.unknownCount;
    final pct = total > 0 ? (state.knownCount / total) * 100 : 0.0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pct >= 80 ? '🏆' : '📚',
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
                '${state.knownCount}/$total kart bildim',
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
                                    flashcardProvider(widget.lessonId).notifier,
                                  )
                                  .restart(),
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
                      icon: const Icon(Icons.done_rounded),
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

class _CardFront extends StatelessWidget {
  final String text;
  const _CardFront({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🇷🇺', style: TextStyle(fontSize: 36)),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Türkmençe terjimesi näme?',
            style: TextStyle(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  final String text;
  const _CardBack({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.success.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🇹🇲', style: TextStyle(fontSize: 36)),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Dogrymy?',
            style: TextStyle(color: AppColors.textTertiary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ScorePill extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _ScorePill({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$label: $count',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
