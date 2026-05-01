import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2200));
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Russian flag stripes
            Container(
              width: 100,
              height: 8,
              color: AppColors.russianWhite,
            ),
            Container(
              width: 100,
              height: 8,
              color: AppColors.russianBlue,
            ),
            Container(
              width: 100,
              height: 8,
              color: AppColors.russianRed,
            ),
            const SizedBox(height: 32),

            // App icon
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.russianRed,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.russianRed.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Я',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontFamily: 'serif',
                  ),
                ),
              ),
            )
                .animate()
                .scale(duration: 600.ms, curve: Curves.elasticOut)
                .fadeIn(duration: 400.ms),

            const SizedBox(height: 28),

            Text(
              'RUSÇA',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 6,
                shadows: [
                  Shadow(
                    color: AppColors.russianRed.withOpacity(0.6),
                    blurRadius: 12,
                  ),
                ],
              ),
            )
                .animate(delay: 300.ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 8),

            Text(
              'ÖWRENIŞ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.7),
                letterSpacing: 8,
              ),
            )
                .animate(delay: 500.ms)
                .fadeIn(duration: 500.ms),

            const SizedBox(height: 8),

            Text(
              'Türkmenler üçin · A1 Derejesi',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 1,
              ),
            )
                .animate(delay: 700.ms)
                .fadeIn(duration: 500.ms),

            const SizedBox(height: 60),

            // Loading dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.russianRed,
                    shape: BoxShape.circle,
                  ),
                )
                    .animate(delay: Duration(milliseconds: 900 + index * 200))
                    .fadeIn(duration: 300.ms)
                    .then()
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scaleXY(
                      begin: 1,
                      end: 1.5,
                      duration: 600.ms,
                      curve: Curves.easeInOut,
                    );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
