import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/lesson/lesson_list_screen.dart';
import 'presentation/screens/lesson/lesson_detail_screen.dart';
import 'presentation/screens/practice/practice_screen.dart';
import 'presentation/screens/practice/flashcard_screen.dart';
import 'presentation/screens/practice/fill_blank_screen.dart';
import 'presentation/screens/practice/multiple_choice_screen.dart';
import 'presentation/screens/practice/matching_screen.dart';
import 'presentation/screens/conversation/conversation_list_screen.dart';
import 'presentation/screens/conversation/conversation_screen.dart';
import 'presentation/screens/grammar/grammar_list_screen.dart';
import 'presentation/screens/grammar/grammar_detail_screen.dart';

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: '/lessons',
      builder: (_, __) => const LessonListScreen(),
    ),
    GoRoute(
      path: '/lesson/:id',
      builder: (_, state) => LessonDetailScreen(
        lessonId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/practice/:lessonId',
      builder: (_, state) => PracticeScreen(
        lessonId: int.parse(state.pathParameters['lessonId']!),
      ),
    ),
    GoRoute(
      path: '/practice/:lessonId/flashcard',
      builder: (_, state) => FlashcardScreen(
        lessonId: int.parse(state.pathParameters['lessonId']!),
      ),
    ),
    GoRoute(
      path: '/practice/:lessonId/fill-blank',
      builder: (_, state) => FillBlankScreen(
        lessonId: int.parse(state.pathParameters['lessonId']!),
      ),
    ),
    GoRoute(
      path: '/practice/:lessonId/multiple-choice',
      builder: (_, state) => MultipleChoiceScreen(
        lessonId: int.parse(state.pathParameters['lessonId']!),
      ),
    ),
    GoRoute(
      path: '/practice/:lessonId/matching',
      builder: (_, state) => MatchingScreen(
        lessonId: int.parse(state.pathParameters['lessonId']!),
      ),
    ),
    GoRoute(
      path: '/conversations',
      builder: (_, __) => const ConversationListScreen(),
    ),
    GoRoute(
      path: '/conversation/:id',
      builder: (_, state) => ConversationScreen(
        dialogId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/grammar',
      builder: (_, __) => const GrammarListScreen(),
    ),
    GoRoute(
      path: '/grammar/:lessonId',
      builder: (_, state) => GrammarDetailScreen(
        lessonId: int.parse(state.pathParameters['lessonId']!),
      ),
    ),
  ],
);

class RusDiliApp extends ConsumerWidget {
  const RusDiliApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Rusça Öwreniş',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}
