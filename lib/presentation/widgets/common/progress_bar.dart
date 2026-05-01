import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LessonProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color? color;
  final double height;
  final String? label;

  const LessonProgressBar({
    super.key,
    required this.value,
    this.color,
    this.height = 8,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    final clamped = value.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label!,
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary)),
                Text(
                  '${(clamped * 100).toInt()}%',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: c),
                ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: clamped,
            backgroundColor: c.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(c),
            minHeight: height,
          ),
        ),
      ],
    );
  }
}

class CircularProgressRing extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final double size;
  final Color? color;
  final Widget? child;
  final double strokeWidth;

  const CircularProgressRing({
    super.key,
    required this.value,
    this.size = 64,
    this.color,
    this.child,
    this.strokeWidth = 6,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value.clamp(0.0, 1.0),
            backgroundColor: c.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(c),
            strokeWidth: strokeWidth,
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
