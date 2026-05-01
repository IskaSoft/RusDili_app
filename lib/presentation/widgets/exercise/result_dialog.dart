import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ResultBanner extends StatelessWidget {
  final bool isCorrect;
  final String correctAnswer;
  final String? hint;
  final VoidCallback onNext;
  final bool isLast;

  const ResultBanner({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
    this.hint,
    required this.onNext,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.successSurface
            : AppColors.errorSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCorrect ? AppColors.success : AppColors.error,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isCorrect ? '✅' : '❌',
              style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? 'Dogry!' : 'Ýalňyş!',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: isCorrect
                          ? AppColors.success
                          : AppColors.error),
                ),
                if (!isCorrect) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Dogry jogap: $correctAnswer',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success),
                  ),
                ],
                if (hint != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '📌 $hint',
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: isCorrect
                  ? AppColors.success
                  : AppColors.primary,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              isLast ? 'Bitir' : 'İndiki →',
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
