import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/dialog_model.dart';
import '../../providers/lesson_provider.dart';

class ConversationListScreen extends ConsumerWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogsAsync = ref.watch(allDialogsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dialoglar'),
        backgroundColor: AppColors.surface,
      ),
      body: dialogsAsync.when(
        data: (dialogs) => dialogs.isEmpty
            ? const Center(child: Text('Dialog tapylmady'))
            : Column(
                children: [
                  // Header banner
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1565C0), Color(0xFF003DA5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Text('💬',
                            style: TextStyle(fontSize: 32)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text('Söhbetdeşlik Tejribesi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                              Text(
                                  '${dialogs.length} dialog · 10 sapak',
                                  style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Dialog list
                  Expanded(
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: dialogs.length,
                      itemBuilder: (ctx, i) => _DialogListTile(
                          dialog: dialogs[i], index: i),
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

class _DialogListTile extends StatelessWidget {
  final DialogModel dialog;
  final int index;
  const _DialogListTile(
      {required this.dialog, required this.index});

  @override
  Widget build(BuildContext context) {
    // Pick color per lesson
    final colors = [
      AppColors.primary,
      AppColors.info,
      AppColors.success,
      AppColors.secondary,
      const Color(0xFF9C27B0),
    ];
    final color = colors[dialog.lessonId % colors.length];

    return GestureDetector(
      onTap: () => context.push('/conversation/${dialog.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: color.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('💬',
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Диалог ${dialog.dialogNumber ?? index + 1}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.textPrimary),
                  ),
                  if (dialog.dialogName != null)
                    Text(
                      dialog.dialogName!,
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary),
                    ),
                  if (dialog.contextTk != null)
                    Text(
                      dialog.contextTk!,
                      style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textTertiary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Sapak ${dialog.lessonId}',
                          style: TextStyle(
                              fontSize: 10,
                              color: color,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${dialog.lines.length} setir',
                        style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.play_circle_rounded,
                color: color, size: 30),
          ],
        ),
      ).animate(delay: (index * 40).ms).fadeIn().slideX(begin: 0.1),
    );
  }
}
