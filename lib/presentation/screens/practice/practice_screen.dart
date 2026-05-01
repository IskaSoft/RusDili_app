import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';

class PracticeScreen extends StatelessWidget {
  final int lessonId;
  const PracticeScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Türgenleşik Saýla'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Haýsy türgenleşigi etmek isleýärsiňiz?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.05,
                children: [
                  _PracticeTypeCard(
                    emoji: '🃏',
                    title: 'Flash Kartlar',
                    description: 'Sözleri öwren',
                    color: AppColors.primary,
                    onTap: () =>
                        context.push('/practice/$lessonId/flashcard'),
                  ).animate(delay: 50.ms).fadeIn().scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1)),
                  _PracticeTypeCard(
                    emoji: '✏️',
                    title: 'Boş Ýer Doldur',
                    description: 'Sözlemi tamamla',
                    color: AppColors.info,
                    onTap: () =>
                        context.push('/practice/$lessonId/fill-blank'),
                  ).animate(delay: 100.ms).fadeIn().scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1)),
                  _PracticeTypeCard(
                    emoji: '☑️',
                    title: 'Köp Saýlaw',
                    description: 'Dogry jogaby saýla',
                    color: AppColors.success,
                    onTap: () => context
                        .push('/practice/$lessonId/multiple-choice'),
                  ).animate(delay: 150.ms).fadeIn().scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1)),
                  _PracticeTypeCard(
                    emoji: '🔗',
                    title: 'Deňleşdir',
                    description: 'Sözleri deňleşdir',
                    color: AppColors.secondary,
                    onTap: () =>
                        context.push('/practice/$lessonId/matching'),
                  ).animate(delay: 200.ms).fadeIn().scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticeTypeCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _PracticeTypeCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(emoji,
                    style: const TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
