import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/dialog_model.dart';
import '../../providers/lesson_provider.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  final int dialogId;
  const ConversationScreen({super.key, required this.dialogId});

  @override
  ConsumerState<ConversationScreen> createState() =>
      _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  int _currentLine = 0;
  bool _showTk = true;
  bool _isFinished = false;

  @override
  Widget build(BuildContext context) {
    // DÜZEDIŞ #2: Öňki kod her build-da täze FutureProvider döredýärdi —
    // Riverpod muny cache edip bilmeýärdi, her rebuild-da DB soragydy.
    // Indi global dialogByIdProvider ulanylýar — cache dogry işleýär.
    final dialogAsync = ref.watch(dialogByIdProvider(widget.dialogId));

    return dialogAsync.when(
      data: (dialog) {
        if (dialog == null) {
          return const Scaffold(
              body: Center(child: Text('Dialog tapylmady')));
        }
        return _buildScreen(context, dialog);
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) =>
          Scaffold(body: Center(child: Text('Ýalňyşlyk: $e'))),
    );
  }

  Widget _buildScreen(BuildContext context, DialogModel dialog) {
    final visibleLines = _isFinished
        ? dialog.lines
        : dialog.lines.sublist(0, _currentLine + 1);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Диалог ${dialog.dialogNumber ?? 1}'),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          // Translation toggle
          Row(
            children: [
              const Text('TK',
                  style: TextStyle(
                      fontSize: 11, color: AppColors.textTertiary)),
              Switch.adaptive(
                value: _showTk,
                onChanged: (v) => setState(() => _showTk = v),
                activeColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: dialog.lines.isEmpty
                ? 0
                : (_currentLine + 1) / dialog.lines.length,
            backgroundColor: AppColors.border,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.info),
            minHeight: 3,
          ),
        ),
      ),
      body: Column(
        children: [
          // Context note
          if (dialog.contextTk != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
              color: AppColors.secondarySurface,
              child: Text(
                '📍 ${dialog.contextTk}',
                style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic),
              ),
            ),

          // Messages area
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 16),
              itemCount: visibleLines.length,
              itemBuilder: (ctx, idx) {
                final line = visibleLines[idx];
                final isA = idx % 2 == 0;
                return _buildBubble(line, isA, idx);
              },
            ),
          ),

          // Control area
          _isFinished
              ? _buildFinishedBar(context, dialog)
              : _buildControls(context, dialog),
        ],
      ),
    );
  }

  Widget _buildBubble(DialogLine line, bool isA, int idx) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          isA ? 0 : 52, 4, isA ? 52 : 0, 4),
      child: Align(
        alignment:
            isA ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isA
                ? AppColors.infoSurface
                : AppColors.primarySurface,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isA ? 2 : 16),
              bottomRight: Radius.circular(isA ? 16 : 2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Speaker label
              if (line.speaker != null)
                Text(
                  line.speaker!,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isA
                          ? AppColors.info
                          : AppColors.primary),
                ),
              // Russian text
              Text(
                line.textRu,
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    height: 1.4),
              ),
              // Turkmen translation
              if (_showTk && line.textTk != null)
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    line.textTk!,
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ),
        ).animate(delay: (idx * 120).ms).fadeIn().slideY(begin: 0.2),
      ),
    );
  }

  Widget _buildControls(BuildContext context, DialogModel dialog) {
    final isLast = _currentLine >= dialog.lines.length - 1;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border:
            Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        children: [
          // Current line preview
          if (_currentLine < dialog.lines.length)
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${_currentLine + 1}/${dialog.lines.length} setir',
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textTertiary),
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (isLast) {
                  setState(() => _isFinished = true);
                } else {
                  setState(() => _currentLine++);
                }
              },
              icon: Icon(
                isLast
                    ? Icons.done_all_rounded
                    : Icons.arrow_forward_rounded,
                size: 18,
              ),
              label: Text(
                  isLast ? 'Dialog tamamlandy!' : 'Indiki →'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.info,
                padding:
                    const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishedBar(BuildContext context, DialogModel dialog) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        color: AppColors.successSurface,
        border: Border(
            top: BorderSide(
                color: AppColors.success.withOpacity(0.3))),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('✅',
                  style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text(
                'Dialog tamamlandy!',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.success),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => setState(() {
                    _currentLine = 0;
                    _isFinished = false;
                  }),
                  icon: const Icon(Icons.replay_rounded,
                      size: 18),
                  label: const Text('Täzeden'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.success,
                    side: const BorderSide(
                        color: AppColors.success),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_rounded,
                      size: 18),
                  label: const Text('Yza'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
