import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/level_provider.dart';

class LevelSelectScreen extends ConsumerWidget {
  /// isChange = true → Home-dan açyldy, geri düwme görünýär
  /// isChange = false → Splash-dan açyldy, ilkinji saýlaw
  final bool isChange;
  const LevelSelectScreen({super.key, this.isChange = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelState = ref.watch(levelProvider);
    final current = levelState.selectedLevel;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            // ── Üst bölüm ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                children: [
                  if (isChange)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.white70),
                      onPressed: () => context.pop(),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: isChange
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          isChange ? 'Dereje üýtget' : 'Derejeňi saýla',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isChange
                              ? 'Başga derejä geçip bilýärsiň, öňki ösüş saklanyp galýar'
                              : 'Häzirki rus dili derejeňi saýla',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 13,
                          ),
                          textAlign: isChange
                              ? TextAlign.start
                              : TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Dereje kartlary ─────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: AppLevel.values.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final level = entry.value;
                  final isSelected = current == level;

                  return _LevelCard(
                    level: level,
                    isSelected: isSelected,
                    isChange: isChange,
                    delay: idx * 80,
                    onTap: () async {
                      await ref
                          .read(levelProvider.notifier)
                          .selectLevel(level);
                      if (context.mounted) {
                        if (isChange) {
                          context.pop(); // Home-a gaýt
                        } else {
                          context.go('/home'); // Ilkinji saýlaw → Home
                        }
                      }
                    },
                  );
                }).toList(),
              ),
            ),

            // ── Aşaky bellik ────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Text(
                'Islän wagtyň derejäňi üýtgedip bilýärsiň.\nÖňki derejäňdäki ösüş saklanyp galýar.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.35),
                  fontSize: 12,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Bir dereje kartasy ───────────────────────────────────────

class _LevelCard extends StatelessWidget {
  final AppLevel level;
  final bool isSelected;
  final bool isChange;
  final int delay;
  final VoidCallback onTap;

  const _LevelCard({
    required this.level,
    required this.isSelected,
    required this.isChange,
    required this.delay,
    required this.onTap,
  });

  Color get _accentColor => switch (level) {
        AppLevel.a1 => const Color(0xFF4CAF50),
        AppLevel.a2 => const Color(0xFF2196F3),
        AppLevel.b1 => const Color(0xFFFF9800),
        AppLevel.b2 => const Color(0xFFE91E63),
      };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? _accentColor.withOpacity(0.15)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? _accentColor
                : Colors.white.withOpacity(0.12),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Emoji + badge
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(level.emoji,
                    style: const TextStyle(fontSize: 26)),
              ),
            ),

            const SizedBox(width: 16),

            // Mazmun
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: _accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          level.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        level.titleTk,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    level.descTk,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Saýlanan belgi
            if (isSelected)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _accentColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 18),
              )
            else
              Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withOpacity(0.25), size: 16),
          ],
        ),
      )
          .animate(delay: Duration(milliseconds: delay))
          .fadeIn(duration: 400.ms)
          .slideX(begin: 0.15, end: 0),
    );
  }
}
