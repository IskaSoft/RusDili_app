import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Dereje modeli ────────────────────────────────────────────

enum AppLevel {
  a1,
  a2,
  b1,
  b2;

  String get label => name.toUpperCase(); // 'A1', 'A2', ...

  String get titleTk => switch (this) {
        AppLevel.a1 => 'Başlangyç',
        AppLevel.a2 => 'Elementar',
        AppLevel.b1 => 'Orta',
        AppLevel.b2 => 'Orta-ýokary',
      };

  String get descTk => switch (this) {
        AppLevel.a1 => 'Ilkinji sözler, salam berme, özüňi tanyşdyrma',
        AppLevel.a2 => 'Eýelik, iýmit, eşik, şäher, howa, saglyk, syýahat (Sapak 11–20)',
        AppLevel.b1 => 'Daça, medeni durmuş, maşgala, watan, haýwanlar, baýramlar (УРОК 21–28)',
        AppLevel.b2 => 'Çylşyrymly mowzuklar, ýazuw, prezentasiýa',
      };

  String get emoji => switch (this) {
        AppLevel.a1 => '🌱',
        AppLevel.a2 => '🌿',
        AppLevel.b1 => '🌳',
        AppLevel.b2 => '🏆',
      };

  // DB-daky sapak ID aralyklary
  int get minLessonId => switch (this) {
        AppLevel.a1 => 1,
        AppLevel.a2 => 24,
        AppLevel.b1 => 34,   // Red Kalinka: УРОК 21–28 → ID 34–41
        AppLevel.b2 => 51,
      };

  int get maxLessonId => switch (this) {
        AppLevel.a1 => 23,
        AppLevel.a2 => 33,   // A2 Kitap: Sapak 11–20 → ID 24–33
        AppLevel.b1 => 41,   // Red Kalinka: УРОК 21–28 → ID 34–41
        AppLevel.b2 => 80,
      };

  bool containsLesson(int lessonId) =>
      lessonId >= minLessonId && lessonId <= maxLessonId;

  // SharedPreferences key
  static const _prefKey = 'selected_level';

  static AppLevel fromString(String? s) => switch (s) {
        'a2' => AppLevel.a2,
        'b1' => AppLevel.b1,
        'b2' => AppLevel.b2,
        _ => AppLevel.a1,
      };
}

// ── Level State ──────────────────────────────────────────────

class LevelState {
  final AppLevel? selectedLevel; // null = henüz saýlanmadyk
  final bool isLoaded;           // SharedPreferences-dan okalan

  const LevelState({this.selectedLevel, this.isLoaded = false});

  bool get hasSelected => selectedLevel != null;

  LevelState copyWith({AppLevel? selectedLevel, bool? isLoaded}) =>
      LevelState(
        selectedLevel: selectedLevel ?? this.selectedLevel,
        isLoaded: isLoaded ?? this.isLoaded,
      );
}

// ── Level Notifier ───────────────────────────────────────────

class LevelNotifier extends StateNotifier<LevelState> {
  LevelNotifier() : super(const LevelState()) {
    _load();
  }

  // App açylanda SharedPreferences-dan ýükle
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(AppLevel._prefKey);
    state = LevelState(
      selectedLevel: saved != null ? AppLevel.fromString(saved) : null,
      isLoaded: true,
    );
  }

  // Dereje saýlananda ýazuw + state
  Future<void> selectLevel(AppLevel level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppLevel._prefKey, level.name);
    state = LevelState(selectedLevel: level, isLoaded: true);
  }

  // Dereje üýtgetmek (Home-dan)
  Future<void> changeLevel(AppLevel level) => selectLevel(level);

  // Dereje sifirla (developer üçin ýa-da debug)
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppLevel._prefKey);
    state = const LevelState(isLoaded: true);
  }
}

// ── Provider ────────────────────────────────────────────────

final levelProvider = StateNotifierProvider<LevelNotifier, LevelState>(
  (ref) => LevelNotifier(),
);

// Convenience — diňe saýlanan dereje gerek ýerler üçin
final currentLevelProvider = Provider<AppLevel>((ref) {
  return ref.watch(levelProvider).selectedLevel ?? AppLevel.a1;
});
