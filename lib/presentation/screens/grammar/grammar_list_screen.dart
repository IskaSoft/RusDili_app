import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/lesson_provider.dart';

class GrammarListScreen extends ConsumerWidget {
  const GrammarListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsAsync = ref.watch(allLessonsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Grammatika'),
        backgroundColor: AppColors.surface,
      ),
      body: lessonsAsync.when(
        data: (lessons) => Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4A017), Color(0xFFB8860B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Text('📐',
                      style: TextStyle(fontSize: 32)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Grammatika Tablisalary',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                        Text(
                          '${lessons.length} sapak · Ähli tablisalar',
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Lessons list
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16),
                itemCount: lessons.length,
                itemBuilder: (ctx, i) {
                  final lesson = lessons[i];
                  return GestureDetector(
                    onTap: () =>
                        context.push('/grammar/${lesson.id}'),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border:
                            Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.secondary
                                  .withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.secondary
                                      .withOpacity(0.3)),
                            ),
                            child: Center(
                              child: Text(
                                lesson.sapakNumber
                                    .toString()
                                    .padLeft(2, '0'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lesson.titleRu,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color:
                                          AppColors.textPrimary),
                                ),
                                if (lesson.subtitleTk != null)
                                  Text(
                                    lesson.subtitleTk!,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color:
                                            AppColors.textTertiary),
                                    maxLines: 1,
                                    overflow:
                                        TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                          const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: AppColors.textTertiary),
                        ],
                      ),
                    ).animate(delay: (i * 50).ms).fadeIn().slideX(
                        begin: 0.1),
                  );
                },
              ),
            ),
          ],
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text('Ýalňyşlyk: $e')),
      ),
    );
  }
}
