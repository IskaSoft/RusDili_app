import 'package:sqflite/sqflite.dart';
import '../../core/constants/db_constants.dart';

/// A2 Kitabynyň ähli datasy (Sapak 11-20)
/// Sözler, dialoglar, grammatika tablisalary, gönükmeler
class DatabaseSeederA2 {
  static Future<void> seed(Database db) async {
    await db.transaction((txn) async {
      await _seedLessons(txn);
      await _seedVocabulary(txn);
      await _seedDialogs(txn);
      await _seedGrammar(txn);
      await _seedExercises(txn);
      await _seedReadingTexts(txn);
      await _seedLessonProgress(txn);
    });
  }

  // ── SAPAKLAR (ID 24–33) ──────────────────────────────
  static Future<void> _seedLessons(Transaction txn) async {
    final lessons = [
      {
        'id': 24, 'sapak_number': 24,
        'title_ru': 'У МЕНЯ ЕСТЬ!',
        'title_tk': 'Mende Bar!',
        'subtitle_tk': 'Eýelik bildirme, reňkler, рисовать işligi',
        'description_tk': 'Eýelik bildirme, reňkler, рисовать işligi.',
        'image_path': 'assets/images/lessons/a2_01_mende_bar.png',
        'order_index': 24,
      },
      {
        'id': 25, 'sapak_number': 25,
        'title_ru': 'ЕДА И ПРОДУКТЫ',
        'title_tk': 'Iýmit we Önümler',
        'subtitle_tk': 'Iýmit atlary, есть/пить/покупать, Вин. падёж',
        'description_tk': 'Iýmit atlary, есть/пить/покупать, Вин. падёж.',
        'image_path': 'assets/images/lessons/a2_02_iyimit.png',
        'order_index': 25,
      },
      {
        'id': 26, 'sapak_number': 26,
        'title_ru': 'ОДЕЖДА И ОБУВЬ',
        'title_tk': 'Egin-Eşik we Aýakgap',
        'subtitle_tk': 'Egin-eşik atlary, sanlar, bahalar, носить',
        'description_tk': 'Egin-eşik atlary, sanlar, bahalar, носить.',
        'image_path': 'assets/images/lessons/a2_03_eşik.png',
        'order_index': 26,
      },
      {
        'id': 27, 'sapak_number': 27,
        'title_ru': 'МОЯ КВАРТИРА',
        'title_tk': 'Meniň Kwarteram',
        'subtitle_tk': 'Öý otaglary, мебель, Предл. падёж',
        'description_tk': 'Öý otaglary, мебель, Предл. падёж.',
        'image_path': 'assets/images/lessons/a2_04_kwarter.png',
        'order_index': 27,
      },
      {
        'id': 28, 'sapak_number': 28,
        'title_ru': 'МОЙ ГОРОД',
        'title_tk': 'Meniň Şäherim',
        'subtitle_tk': 'Şäher ýerleri, Дательный падёж, ulag',
        'description_tk': 'Şäher ýerleri, Дательный падёж, ulag.',
        'image_path': 'assets/images/lessons/a2_05_şäher.png',
        'order_index': 28,
      },
      {
        'id': 29, 'sapak_number': 29,
        'title_ru': 'СКОЛЬКО ТЕБЕ ЛЕТ?',
        'title_tk': 'Saňa Näçe Ýaş?',
        'subtitle_tk': 'Ýaş, doglan gün, Дат. падёж',
        'description_tk': 'Ýaş, doglan gün, Дат. падёж.',
        'image_path': 'assets/images/lessons/a2_06_ýaş.png',
        'order_index': 29,
      },
      {
        'id': 30, 'sapak_number': 30,
        'title_ru': 'ПОГОДА',
        'title_tk': 'Howa',
        'subtitle_tk': 'Pasyllar, howa, gündogar/günbatar',
        'description_tk': 'Pasyllar, howa, gündogar/günbatar.',
        'image_path': 'assets/images/lessons/a2_07_howa.png',
        'order_index': 30,
      },
      {
        'id': 31, 'sapak_number': 31,
        'title_ru': 'Я ИДУ В БОЛЬНИЦУ',
        'title_tk': 'Men Hassahana Barýaryn',
        'subtitle_tk': 'Beden agzalary, kesel, lukmana barmak',
        'description_tk': 'Beden agzalary, kesel, lukmana barmak.',
        'image_path': 'assets/images/lessons/a2_08_hassahana.png',
        'order_index': 31,
      },
      {
        'id': 32, 'sapak_number': 32,
        'title_ru': 'ПЛАНЫ НА ОТПУСК',
        'title_tk': 'Dynç Alyş Meýilnamalary',
        'subtitle_tk': 'Syýahat, ulag, geljek zaman',
        'description_tk': 'Syýahat, ulag, geljek zaman.',
        'image_path': 'assets/images/lessons/a2_09_syýahat.png',
        'order_index': 32,
      },
      {
        'id': 33, 'sapak_number': 33,
        'title_ru': 'Я ИДУ В РЕСТОРАН',
        'title_tk': 'Men Restorana Barýaryn',
        'subtitle_tk': 'Restoran, nahar sargyt etmek, sypat derejesi',
        'description_tk': 'Restoran, nahar sargyt etmek, sypat derejesi.',
        'image_path': 'assets/images/lessons/a2_10_restoran.png',
        'order_index': 33,
      },
    ];
    for (final l in lessons) {
      await txn.insert(DbConstants.tLessons, l,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ── SÖZLÜK (26 söz × 10 sapak = 260 söz) ───────────
  static Future<void> _seedVocabulary(Transaction txn) async {
    final vocab = [
      {'lesson_id': 24, 'word_ru': 'белый', 'word_tk': 'ak', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'чёрный', 'word_tk': 'gara', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'серый', 'word_tk': 'çal', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'красный', 'word_tk': 'gyzyl', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'зелёный', 'word_tk': 'ýaşyl', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'синий', 'word_tk': 'goýy gök', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'голубой', 'word_tk': 'açyk gök', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'жёлтый', 'word_tk': 'sary', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'коричневый', 'word_tk': 'goňur', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'оранжевый', 'word_tk': 'mämişi', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'розовый', 'word_tk': 'gülgün', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'фиолетовый', 'word_tk': 'benewşe reňk', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'умный', 'word_tk': 'глупый  — akylly — akmak', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'цвет', 'word_tk': 'цвета  — reňk — reňkler', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'карандаш', 'word_tk': 'galam', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'ручка', 'word_tk': 'ruçka', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'театр', 'word_tk': 'teatr', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'новость', 'word_tk': 'новости  — habar — habarlar', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'снег', 'word_tk': 'gar', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'жизнь', 'word_tk': 'durmuş, ömür', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'характер', 'word_tk': 'häsiýet', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'поэтому', 'word_tk': 'şonuň üçin', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'слишком', 'word_tk': 'gereginden artyk', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'все / всё', 'word_tk': 'hemmeler / hemme zat', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'рисовать', 'word_tk': 'çekmek (surat)', 'category': 'a2'},
      {'lesson_id': 24, 'word_ru': 'правда', 'word_tk': 'dogru, hakykat', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'еда', 'word_tk': 'iýmit', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'продукт', 'word_tk': 'önüm', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'мясо', 'word_tk': 'et', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'рыба', 'word_tk': 'balyk', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'курица', 'word_tk': 'towuk', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'сыр', 'word_tk': 'peýnir', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'картошка', 'word_tk': 'kartoşka', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'хлеб', 'word_tk': 'çörek', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'рис', 'word_tk': 'tüwi', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'колбаса', 'word_tk': 'kolbasa', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'салат', 'word_tk': 'salat', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'суп', 'word_tk': 'çorba', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'бутерброд', 'word_tk': 'buterbrod', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'овощ', 'word_tk': 'gök önüm', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'фрукт', 'word_tk': 'miwe', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'печенье', 'word_tk': 'süýji köke', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'каша', 'word_tk': 'şöhle-ham', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'вода', 'word_tk': 'suw', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'сок', 'word_tk': 'şire', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'молоко', 'word_tk': 'süýt', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'вино', 'word_tk': 'şerap', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'вкусный', 'word_tk': 'datly', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'есть', 'word_tk': 'iýmek', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'пить', 'word_tk': 'içmek', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'покупать', 'word_tk': 'satyn almak', 'category': 'a2'},
      {'lesson_id': 25, 'word_ru': 'рынок', 'word_tk': 'bazar', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'одежда', 'word_tk': 'egin-eşik', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'обувь', 'word_tk': 'aýakgap', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'рубашка', 'word_tk': 'köýnek (erkek)', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'футболка', 'word_tk': 'futbolka', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'брюки', 'word_tk': 'balak', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'джинсы', 'word_tk': 'jins', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'шорты', 'word_tk': 'şort', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'перчатки', 'word_tk': 'elde geýilýän', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'шарф', 'word_tk': 'şarf', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'платье', 'word_tk': 'köýnek (aýal)', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'пальто', 'word_tk': 'palto', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'свитер', 'word_tk': 'switer', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'шапка', 'word_tk': 'başgap', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'костюм', 'word_tk': 'kostýum', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'юбка', 'word_tk': 'ýubka', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'галстук', 'word_tk': 'galstuk', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'туфли', 'word_tk': 'köwüş (aýal)', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'ботинки', 'word_tk': 'köwüş (erkek)', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'модный', 'word_tk': 'moda', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'удобный', 'word_tk': 'amatly', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'тёплый', 'word_tk': 'ýyly', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'летом', 'word_tk': 'tomusda', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'зимой', 'word_tk': 'gyşda', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'рубль', 'word_tk': 'rubl', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'Сколько это стоит?', 'word_tk': 'Bu näçä durýar?', 'category': 'a2'},
      {'lesson_id': 26, 'word_ru': 'носить', 'word_tk': 'geýmek', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'Добро пожаловать!', 'word_tk': 'Hoş geldiňiz!', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'комната', 'word_tk': 'otag', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'ванная', 'word_tk': 'hammam', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'кухня', 'word_tk': 'aşhana', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'спальня', 'word_tk': 'ýatylýan otag', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'гостиная', 'word_tk': 'myhman otag', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'мебель', 'word_tk': 'mebel', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'стена', 'word_tk': 'diwar', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'пол', 'word_tk': 'pol', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'балкон', 'word_tk': 'balkon', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'диван', 'word_tk': 'diwаn', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'кресло', 'word_tk': 'kreslo', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'кровать', 'word_tk': 'ýatak', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'стол', 'word_tk': 'stol', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'стул / стулья', 'word_tk': 'oturgyç', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'холодильник', 'word_tk': 'sowadyjy', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'плита', 'word_tk': 'peç', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'шкаф', 'word_tk': 'şkaf', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'картина', 'word_tk': 'surat', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'зеркало', 'word_tk': 'aýna', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'окно / окна', 'word_tk': 'penjire', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'часы', 'word_tk': 'sagat (diwarda)', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'уютный', 'word_tk': 'amatly, rahat', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'стоять', 'word_tk': 'durmak', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'лежать', 'word_tk': 'ýatmak', 'category': 'a2'},
      {'lesson_id': 27, 'word_ru': 'висеть', 'word_tk': 'asylanmak', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'здание', 'word_tk': 'bina', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'метро', 'word_tk': 'metro', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'автобус', 'word_tk': 'awtobus', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'билет', 'word_tk': 'bilet', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'площадь', 'word_tk': 'meýdan', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'торговый центр', 'word_tk': 'söwda merkezi', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'аптека', 'word_tk': 'dermanhana', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'район', 'word_tk': 'etrap', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'карта', 'word_tk': 'karta', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'здесь', 'word_tk': 'там  — bu ýerde — ol ýerde', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'близко', 'word_tk': 'ýakyn', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'далеко', 'word_tk': 'недалеко  — uzak — uzak däl', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'прямо', 'word_tk': 'göni', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'налево', 'word_tk': 'çepe', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'направо', 'word_tk': 'saga', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'проспект', 'word_tk': 'şaýol', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'спешить', 'word_tk': 'howlugmak', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'находиться', 'word_tk': 'ýerleşmek', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'видеть', 'word_tk': 'görmek', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'Кремль', 'word_tk': 'Kreml', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'церковь', 'word_tk': 'ybadathana', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'мечеть', 'word_tk': 'metjit', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'остановка', 'word_tk': 'duralga', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'станция метро', 'word_tk': 'metro stansiýasy', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'супермаркет', 'word_tk': 'supermarket', 'category': 'a2'},
      {'lesson_id': 28, 'word_ru': 'экскурсия', 'word_tk': 'gezelenç', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'год', 'word_tk': 'ýyl', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'Сколько тебе лет?', 'word_tk': 'Saňa näçe ýaş?', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'Мне нравится...', 'word_tk': 'Maňa ýaraýar...', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'день рождения', 'word_tk': 'doglan gün', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'подарок', 'word_tk': 'sowgat', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'С днём рождения!', 'word_tk': 'Doglan günüň gutly bolsun!', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'Он женат', 'word_tk': 'Ol öýli(erkek)', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'Она замужем', 'word_tk': 'Ol öýli(aýal)', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'танцевать', 'word_tk': 'tans etmek', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'дискотека', 'word_tk': 'disko', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'гитара', 'word_tk': 'gitara', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'пианино', 'word_tk': 'pianino', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'скрипка', 'word_tk': 'skripka', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'месяц', 'word_tk': 'aý(senenama)', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'январь', 'word_tk': 'ýanwar', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'февраль', 'word_tk': 'fewral', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'март', 'word_tk': 'mart', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'апрель', 'word_tk': 'aprel', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'май', 'word_tk': 'maý', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'июнь', 'word_tk': 'iýun', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'июль', 'word_tk': 'iýul', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'август', 'word_tk': 'awgust', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'сентябрь', 'word_tk': 'sentýabr', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'октябрь', 'word_tk': 'oktýabr', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'ноябрь', 'word_tk': 'noýabr', 'category': 'a2'},
      {'lesson_id': 29, 'word_ru': 'декабрь', 'word_tk': 'dekabr', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'время года', 'word_tk': 'ýyl pasly', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'весна', 'word_tk': 'ýaz', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'осень', 'word_tk': 'güýz', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'север', 'word_tk': 'demirgazyk', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'запад', 'word_tk': 'günbatar', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'восток', 'word_tk': 'gündogar', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'холодно', 'word_tk': 'sowuk(hal.)', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'жарко', 'word_tk': 'yssy(hal.)', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'тепло', 'word_tk': 'ýyly(hal.)', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'идёт дождь', 'word_tk': 'ýagyş ýagýar', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'идёт снег', 'word_tk': 'gar ýagýar', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'ветер', 'word_tk': 'şemal', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'солнце', 'word_tk': 'gün', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'температура', 'word_tk': 'temperatura', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'градус', 'word_tk': 'dereje', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'прогноз погоды', 'word_tk': 'howa çaklamasy', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'пляж', 'word_tk': 'kenar', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'кататься на лыжах', 'word_tk': 'lyža sürmek', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'кататься на коньках', 'word_tk': 'konki sürmek', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'кататься на велосипеде', 'word_tk': 'welosiped sürmek', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'красота', 'word_tk': 'gözellik', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'наверное', 'word_tk': 'belki', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'предпочитать', 'word_tk': 'has gowy görmek', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'дерево', 'word_tk': 'деревья  — agaç — agaçlar', 'category': 'a2'},
      {'lesson_id': 30, 'word_ru': 'плюс', 'word_tk': 'минус  — artyk — kemlik', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'голова', 'word_tk': 'baş', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'ухо / уши', 'word_tk': 'gulak', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'рука / руки', 'word_tk': 'el', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'нога / ноги', 'word_tk': 'aýak', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'живот', 'word_tk': 'garyn', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'глаз / глаза', 'word_tk': 'göz', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'нос', 'word_tk': 'burun', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'рот', 'word_tk': 'agyz', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'горло', 'word_tk': 'bokurdak', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'сердце', 'word_tk': 'ýürek', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'спина', 'word_tk': 'arka', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'палец / пальцы', 'word_tk': 'barmak', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'лекарство', 'word_tk': 'derman', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'зубной врач', 'word_tk': 'diş lukmany', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'медсестра', 'word_tk': 'şepagat uýasy', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'грипп', 'word_tk': 'gripp', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'простуда', 'word_tk': 'ýiti respirator kesel', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'мне плохо', 'word_tk': 'maňa erbet', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'раз', 'word_tk': 'gezek', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'выздоравливай!', 'word_tk': 'çalt sagal!', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'рецепт', 'word_tk': 'resept', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'скорая помощь', 'word_tk': 'tiz kömek', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'должен', 'word_tk': 'borçly, gerek', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'ждать', 'word_tk': 'garaşmak', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'болеть', 'word_tk': 'keselmek; agyrymak', 'category': 'a2'},
      {'lesson_id': 31, 'word_ru': 'принимать лекарство', 'word_tk': 'derman içmek', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'план', 'word_tk': 'meýilnama', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'отпуск', 'word_tk': 'dynç alyş', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'каникулы', 'word_tk': 'okuw dynç alyş', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'поезд', 'word_tk': 'otly', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'самолёт', 'word_tk': 'uçar', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'аэропорт', 'word_tk': 'howa menzili', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'гостиница', 'word_tk': 'myhmanhana', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'вокзал', 'word_tk': 'demir ýol menzili', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'экскурсия', 'word_tk': 'gezelenç', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'бассейн', 'word_tk': 'ýüzüjilik howuzy', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'вовремя', 'word_tk': 'wagtynda', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'важный', 'word_tk': 'möhüm', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'весёлый/весело', 'word_tk': 'şadyýan', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'злой', 'word_tk': 'gaharly', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'другой', 'word_tk': 'başga', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'дача', 'word_tk': 'daça', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'огород', 'word_tk': 'bakja', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'озеро', 'word_tk': 'köl', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'зачем?', 'word_tk': 'näme üçin?(maksat)', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'Пошли!', 'word_tk': 'Gideliň!', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'фотографировать', 'word_tk': 'surata almak', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'ловить рыбу', 'word_tk': 'balyk tutmak', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'лететь', 'word_tk': 'uçmak', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'плавать', 'word_tk': 'ýüzmek', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'путешествовать', 'word_tk': 'syýahat etmek', 'category': 'a2'},
      {'lesson_id': 32, 'word_ru': 'ехать', 'word_tk': 'gitmek(ulag bilen)', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'столик', 'word_tk': 'stol(restoranda)', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'закуска', 'word_tk': 'mezze', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'напиток/напитки', 'word_tk': 'içgi', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'тарелка', 'word_tk': 'tabak', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'вилка', 'word_tk': 'çäňňe', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'ложка', 'word_tk': 'çemçe', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'стакан', 'word_tk': 'bulgur', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'чашка', 'word_tk': 'käse', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'нож', 'word_tk': 'pyçak', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'салфетка', 'word_tk': 'salfetka', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'блюдо', 'word_tk': 'nahar,tagam', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'сахар', 'word_tk': 'şeker', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'мороженое', 'word_tk': 'doňdurma', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'гриб', 'word_tk': 'kömelek', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'яблоко', 'word_tk': 'alma', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'пирожок/пирожки', 'word_tk': 'börek', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'морепродукты', 'word_tk': 'deňiz önümleri', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'блин/блины', 'word_tk': 'blin', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'икра', 'word_tk': 'ikra', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'ветчина', 'word_tk': 'ham', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'на первое/на второе', 'word_tk': 'ilki/esasy nahar', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'счёт', 'word_tk': 'hasap', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'чаевые', 'word_tk': 'çaý pul', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'давать', 'word_tk': 'bermek', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'рекомендовать', 'word_tk': 'maslahat bermek', 'category': 'a2'},
      {'lesson_id': 33, 'word_ru': 'заказывать', 'word_tk': 'sargyt etmek', 'category': 'a2'},
    ];
    for (final v in vocab) {
      await txn.insert(DbConstants.tVocabulary, v,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ── DIALOGLAR (5 dialog × 10 sapak) ─────────────────
  static Future<void> _seedDialogs(Transaction txn) async {
    // Sapak 11 dialoglar
    final d11_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 24,
      'dialog_number': 300,
      'dialog_name': 'Диалог 1 — Sapak 11',
      'context_tk': 'Sapak 11 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d11_1, [
      ['—', 'Здравствуйте, у вас есть карандаши?', ''],
      ['—', 'Конечно! Какие карандаши вы хотите?', ''],
      ['—', 'Я хочу красный и синий карандаш.', ''],
      ['—', 'У нас есть только жёлтые и зелёные. Извините.', ''],
      ['—', 'Ничего. До свидания.', ''],
    ]);
    final d11_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 24,
      'dialog_number': 301,
      'dialog_name': 'Диалог 2 — Sapak 11',
      'context_tk': 'Sapak 11 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d11_2, [
      ['—', 'Mähri, какой твой любимый цвет?', ''],
      ['—', 'Мой любимый цвет — синий. Я живу у Каспия и очень люблю море. А какой твой, Kemal?', ''],
      ['—', 'Мой любимый цвет — белый. Я живу в Ашхабаде и люблю белые здания.', ''],
    ]);
    final d11_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 24,
      'dialog_number': 302,
      'dialog_name': 'Диалог 3 — Sapak 11',
      'context_tk': 'Sapak 11 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d11_3, [
      ['—', 'Jeren, что ты рисуешь?', ''],
      ['—', 'Я рисую наш дом.', ''],
      ['—', 'Ваш дом оранжевый?', ''],
      ['—', 'Нет, наш дом серый. Но оранжевый — мой любимый цвет. Поэтому я рисую оранжевый дом.', ''],
      ['—', 'А почему твоя кошка зелёная?', ''],
      ['—', 'Потому что у меня есть новый зелёный карандаш. Красивый, правда?', ''],
    ]);
    final d11_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 24,
      'dialog_number': 303,
      'dialog_name': 'Диалог 4 — Sapak 11',
      'context_tk': 'Sapak 11 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d11_4, [
      ['—', 'Didar, у тебя есть чёрная ручка?', ''],
      ['—', 'Нет, у меня есть только синяя и фиолетовая ручка. Но у меня есть чёрный карандаш.', ''],
      ['—', 'Да, спасибо. А что ты рисуешь?', ''],
      ['—', 'Я рисую завод. Там работает мой папа.', ''],
    ]);
    final d11_5 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 24,
      'dialog_number': 304,
      'dialog_name': 'Диалог 5 — Sapak 11',
      'context_tk': 'Sapak 11 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d11_5, [
      ['—', 'Merdan, у вас есть семья?', ''],
      ['—', 'У меня есть родители, братья и сёстры.', ''],
      ['—', 'Ваши родители живут в Ашхабаде?', ''],
      ['—', 'Нет, у них есть дом в деревне. Они говорят, что Ашхабад — слишком большой город.', ''],
    ]);
    // Sapak 12 dialoglar
    final d12_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 25,
      'dialog_number': 305,
      'dialog_name': 'Диалог 1 — Sapak 12',
      'context_tk': 'Sapak 12 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d12_1, [
      ['—', 'Merdan, какая твоя любимая еда?', ''],
      ['—', 'Моя любимая еда — мясо и картошка. Иногда я ем салаты и фрукты. А какую еду ты любишь?', ''],
      ['—', 'Я очень люблю овощи и фрукты. Обычно покупаю их на рынке. Там они дешёвые и вкусные.', ''],
    ]);
    final d12_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 25,
      'dialog_number': 306,
      'dialog_name': 'Диалог 2 — Sapak 12',
      'context_tk': 'Sapak 12 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d12_2, [
      ['—', 'Aýna, что ты обычно ешь на завтрак?', ''],
      ['—', 'На завтрак я пью кофе и ем бутерброд. Я очень люблю сыр и колбасу.', ''],
      ['—', 'Утром я люблю пить зелёный чай и есть печенье. А что ты ешь на обед?', ''],
      ['—', 'На обед я обычно ем рыбу или курицу и пью сок.', ''],
    ]);
    final d12_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 25,
      'dialog_number': 307,
      'dialog_name': 'Диалог 3 — Sapak 12',
      'context_tk': 'Sapak 12 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d12_3, [
      ['—', 'Döwlet, где вы обычно покупаете продукты?', ''],
      ['—', 'Обычно в магазине. Там я покупаю молоко, сыр, кофе, чай, рис и хлеб.', ''],
      ['—', 'А где вы покупаете овощи и фрукты?', ''],
      ['—', 'Овощи — на рынке. А фрукты я никогда не покупаю. Я их не ем.', ''],
    ]);
    final d12_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 25,
      'dialog_number': 308,
      'dialog_name': 'Диалог 4 — Sapak 12',
      'context_tk': 'Sapak 12 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d12_4, [
      ['—', 'Myrat, что ты обычно пьёшь в баре?', ''],
      ['—', 'Обычно я пью пиво. Тёмное пиво — моё любимое.', ''],
      ['—', 'Обычно я пью вино. Белое вино.', ''],
    ]);
    final d12_5 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 25,
      'dialog_number': 309,
      'dialog_name': 'Диалог 5 — Sapak 12',
      'context_tk': 'Sapak 12 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d12_5, [
      ['—', 'Gülnar, что едят туркмены?', ''],
      ['—', 'Мы, туркмены, любим горячую еду. Мы часто едим плов.', ''],
      ['—', 'А что вы обычно едите на завтрак?', ''],
      ['—', 'На завтрак мы обычно едим кашу или бутерброды. И очень много пьём чай.', ''],
    ]);
    // Sapak 13 dialoglar
    final d13_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 26,
      'dialog_number': 310,
      'dialog_name': 'Диалог 1 — Sapak 13',
      'context_tk': 'Sapak 13 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d13_1, [
      ['—', 'Здравствуйте, у вас есть перчатки?', ''],
      ['—', 'Да! У нас есть белые, чёрные, коричневые и жёлтые перчатки.', ''],
      ['—', 'Сколько стоят эти коричневые перчатки?', ''],
      ['—', 'Эти перчатки стоят 195 рублей.', ''],
      ['—', 'Какие дешёвые! Я их покупаю.', ''],
    ]);
    final d13_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 26,
      'dialog_number': 311,
      'dialog_name': 'Диалог 2 — Sapak 13',
      'context_tk': 'Sapak 13 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d13_2, [
      ['—', 'Leýla, какую одежду вы носите зимой?', ''],
      ['—', 'Зимой мы носим тёплое пальто, свитер, перчатки, шарф, шапку и тёплую обувь.', ''],
      ['—', 'Летом тоже холодная погода?', ''],
      ['—', 'Нет, летом очень тёплая погода. Люди носят шорты и футболки.', ''],
    ]);
    final d13_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 26,
      'dialog_number': 312,
      'dialog_name': 'Диалог 3 — Sapak 13',
      'context_tk': 'Sapak 13 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d13_3, [
      ['—', 'Gülnar, какую одежду ты любишь носить?', ''],
      ['—', 'Я люблю носить удобную одежду. Я часто ношу джинсы и футболку. А что ты обычно носишь?', ''],
      ['—', 'Я тоже люблю удобную одежду. Но на работе я всегда ношу брюки, рубашку и галстук.', ''],
    ]);
    final d13_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 26,
      'dialog_number': 313,
      'dialog_name': 'Диалог 4 — Sapak 13',
      'context_tk': 'Sapak 13 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d13_4, [
      ['—', 'Извините, сколько стоит шапка?', ''],
      ['—', 'Какую шапку вы хотите?', ''],
      ['—', 'Эту оранжевую.', ''],
      ['—', 'Эта шапка стоит 180 рублей.', ''],
      ['—', 'А этот зелёный шарф?', ''],
      ['—', 'Он стоит 170 рублей.', ''],
      ['—', 'Хорошо, я покупаю шарф.', ''],
    ]);
    final d13_5 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 26,
      'dialog_number': 314,
      'dialog_name': 'Диалог 5 — Sapak 13',
      'context_tk': 'Sapak 13 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d13_5, [
      ['—', 'Привет, Didar. Куда ты идёшь?', ''],
      ['—', 'Я иду в магазин «Обувь». Я хочу новые ботинки. Мои старые ботинки уже не модные.', ''],
      ['—', 'А я иду в магазин «Тёплая одежда». Я хочу новый свитер и тёплое пальто.', ''],
    ]);
    // Sapak 14 dialoglar
    final d14_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 27,
      'dialog_number': 315,
      'dialog_name': 'Диалог 1 — Sapak 14',
      'context_tk': 'Sapak 14 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d14_1, [
      ['—', 'Myrat, какая твоя любимая комната в доме?', ''],
      ['—', 'Моя любимая комната — гостиная. Там стоит удобный диван и большой телевизор. В гостиной я отдыхаю, читаю и смотрю телевизор.', ''],
      ['—', 'А моя любимая комната — кухня. Она светлая и уютная. Я очень люблю готовить.', ''],
    ]);
    final d14_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 27,
      'dialog_number': 316,
      'dialog_name': 'Диалог 2 — Sapak 14',
      'context_tk': 'Sapak 14 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d14_2, [
      ['—', 'Gözel, у тебя большая квартира?', ''],
      ['—', 'Нет, моя квартира не очень большая, но уютная. Есть кухня, спальня, ванная и гостиная.', ''],
      ['—', 'А какая мебель есть в спальне?', ''],
      ['—', 'Там стоит кровать, шкаф и маленький стол. На столе стоит компьютер. На стене висят красивые старые часы.', ''],
    ]);
    final d14_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 27,
      'dialog_number': 317,
      'dialog_name': 'Диалог 3 — Sapak 14',
      'context_tk': 'Sapak 14 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d14_3, [
      ['—', 'Извините, сколько стоит эта картина?', ''],
      ['—', 'Эта картина стоит две тысячи рублей.', ''],
      ['—', 'Какая дорогая! А это зеркало?', ''],
      ['—', 'Семьсот девяносто рублей.', ''],
      ['—', 'А сколько стоят эти часы?', ''],
      ['—', 'Часы стоят четыреста рублей.', ''],
      ['—', 'Хорошо, я покупаю часы.', ''],
    ]);
    final d14_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 27,
      'dialog_number': 318,
      'dialog_name': 'Диалог 4 — Sapak 14',
      'context_tk': 'Sapak 14 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d14_4, [
      ['—', 'Kemal, а где все?', ''],
      ['—', 'Папа на кухне — готовит ужин. Мама в ванной — принимает душ.', ''],
      ['—', 'А что делает твой маленький брат?', ''],
      ['—', 'Он в спальне. Лежит на кровати и читает книгу.', ''],
      ['—', 'Вот фрукты и вкусное печенье. Давайте пить чай!', ''],
    ]);
    // Sapak 15 dialoglar
    final d15_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 28,
      'dialog_number': 319,
      'dialog_name': 'Диалог 1 — Sapak 15',
      'context_tk': 'Sapak 15 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d15_1, [
      ['—', 'Извините, вы знаете, где находится Красная площадь?', ''],
      ['—', 'Конечно. Красная площадь недалеко. У вас есть карта?', ''],
      ['—', 'Да, вот.', ''],
      ['—', 'Смотрите. Мы находимся здесь. А Красная площадь там. Видите это большое серое здание? Идите прямо, а потом налево.', ''],
      ['—', 'Большое спасибо.', ''],
    ]);
    final d15_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 28,
      'dialog_number': 320,
      'dialog_name': 'Диалог 2 — Sapak 15',
      'context_tk': 'Sapak 15 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d15_2, [
      ['—', 'Altyn, где вы живёте?', ''],
      ['—', 'Я живу в центре. Здесь есть всё: торговый центр, супермаркет, больница, аптека, рестораны и станция метро.', ''],
      ['—', 'А какая ваша станция метро?', ''],
      ['—', '«Проспект мира». А ещё сюда идёт автобус номер 305.', ''],
    ]);
    final d15_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 28,
      'dialog_number': 321,
      'dialog_name': 'Диалог 3 — Sapak 15',
      'context_tk': 'Sapak 15 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d15_3, [
      ['—', 'Извините, где станция метро?', ''],
      ['—', 'Станция метро там.', ''],
      ['—', 'А где торговый центр?', ''],
      ['—', 'Идите прямо, а потом направо.', ''],
      ['—', 'Спасибо. А вы знаете, где здесь хороший ресторан?', ''],
      ['—', 'Нет, не знаю. Извините, я спешу.', ''],
    ]);
    final d15_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 28,
      'dialog_number': 322,
      'dialog_name': 'Диалог 4 — Sapak 15',
      'context_tk': 'Sapak 15 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d15_4, [
      ['—', 'Извините, какой это автобус?', ''],
      ['—', 'Это автобус номер 212.', ''],
      ['—', 'Он идёт в центр?', ''],
      ['—', 'Нет, автобус номер 380 идёт в центр.', ''],
      ['—', 'А сколько стоит билет?', ''],
      ['—', 'Билет стоит 25 рублей.', ''],
    ]);
    final d15_5 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 28,
      'dialog_number': 323,
      'dialog_name': 'Диалог 5 — Sapak 15',
      'context_tk': 'Sapak 15 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d15_5, [
      ['—', 'Извините, вы знаете, какой автобус идёт в центр?', ''],
      ['—', 'А куда вы хотите? На Красную площадь?', ''],
      ['—', 'Да, на Красную площадь и в Кремль.', ''],
      ['—', 'Это далеко. Но здесь недалеко есть станция метро. Красная площадь находится на станции «Площадь революции».', ''],
      ['—', 'Большое спасибо!', ''],
    ]);
    // Sapak 16 dialoglar
    final d16_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 29,
      'dialog_number': 324,
      'dialog_name': 'Диалог 1 — Sapak 16',
      'context_tk': 'Sapak 16 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d16_1, [
      ['—', 'Merdan, когда твой день рождения?', ''],
      ['—', 'Мой день рождения в январе. Сейчас мне 42 года. А когда твой?', ''],
      ['—', 'Мой день рождения был вчера. Мне уже 31 год.', ''],
      ['—', 'С днём рождения!', ''],
      ['—', 'Спасибо. Вчера мы были в ресторане. Мы много ели и танцевали.', ''],
    ]);
    final d16_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 29,
      'dialog_number': 325,
      'dialog_name': 'Диалог 2 — Sapak 16',
      'context_tk': 'Sapak 16 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d16_2, [
      ['—', 'Ogulgerek, тебе нравится зима?', ''],
      ['—', 'Конечно. Мне очень нравится снег. В декабре у меня день рождения.', ''],
      ['—', 'Не очень. Мне нравится лето. В июне, июле и августе здесь очень хорошая погода.', ''],
    ]);
    final d16_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 29,
      'dialog_number': 326,
      'dialog_name': 'Диалог 3 — Sapak 16',
      'context_tk': 'Sapak 16 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d16_3, [
      ['—', 'Didar, тебе нравится музыка?', ''],
      ['—', 'Конечно, я играю на скрипке и на гитаре. Сейчас учусь играть на пианино.', ''],
      ['—', 'Да, но я не играю ни на чём. Мне нравится слушать музыку и танцевать.', ''],
      ['—', 'А я очень плохо танцую.', ''],
    ]);
    final d16_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 29,
      'dialog_number': 327,
      'dialog_name': 'Диалог 4 — Sapak 16',
      'context_tk': 'Sapak 16 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d16_4, [
      ['—', 'Leýla, сколько тебе лет?', ''],
      ['—', 'Мне 32 года. А тебе?', ''],
      ['—', 'А мне 28 лет. Ты замужем?', ''],
      ['—', 'Да. У меня есть маленькая дочь.', ''],
      ['—', 'Сколько ей лет?', ''],
      ['—', 'Ей 4 года. А ты женат?', ''],
      ['—', 'Да. Сегодня у моего сына день рождения. Ему уже 6 лет.', ''],
    ]);
    final d16_5 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 29,
      'dialog_number': 328,
      'dialog_name': 'Диалог 5 — Sapak 16',
      'context_tk': 'Sapak 16 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d16_5, [
      ['—', 'Aşyr, тебе нравится жить в России?', ''],
      ['—', 'Да, я живу здесь уже 5 лет. Мне нравится моя работа и мои русские друзья.', ''],
      ['—', 'А что тебе не нравится в России?', ''],
      ['—', 'Мне не нравится погода. В ноябре здесь уже зима! И в декабре, и в январе, и в феврале тоже зима!', ''],
    ]);
    // Sapak 17 dialoglar
    final d17_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 30,
      'dialog_number': 329,
      'dialog_name': 'Диалог 1 — Sapak 17',
      'context_tk': 'Sapak 17 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d17_1, [
      ['—', 'Gülnar, какое твоё любимое время года?', ''],
      ['—', 'Моё любимое время года — зима. Зимой всё белое. Мне нравится кататься на лыжах и на коньках. А какое время года ты предпочитаешь?', ''],
      ['—', 'А я предпочитаю лето. Летом я отдыхаю на пляже и катаюсь на велосипеде.', ''],
    ]);
    final d17_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 30,
      'dialog_number': 330,
      'dialog_name': 'Диалог 2 — Sapak 17',
      'context_tk': 'Sapak 17 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d17_2, [
      ['—', 'Merdan, ты знаешь, какая сегодня погода?', ''],
      ['—', 'Сегодня очень плохая погода. Дождь и ветер. Днём ноль градусов, а вечером — минус три.', ''],
      ['—', 'А мне нравится дождь. Я люблю осень. Осенью деревья очень красивые: жёлтые, красные, оранжевые.', ''],
    ]);
    final d17_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 30,
      'dialog_number': 331,
      'dialog_name': 'Диалог 3 — Sapak 17',
      'context_tk': 'Sapak 17 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d17_3, [
      ['—', 'Aşyr, ты слушаешь прогноз погоды по радио?', ''],
      ['—', 'Я редко слушаю радио. Обычно смотрю прогноз в интернете. Вот: сегодня солнце и тёплый ветер. А завтра — дождь.', ''],
      ['—', 'Как жаль! Завтра я хотела идти на пляж!', ''],
      ['—', 'Сейчас уже июль, а я ещё не был на пляже!', ''],
    ]);
    final d17_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 30,
      'dialog_number': 332,
      'dialog_name': 'Диалог 4 — Sapak 17',
      'context_tk': 'Sapak 17 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d17_4, [
      ['—', 'Mähri, где вы предпочитаете жить, на юге или на севере?', ''],
      ['—', 'Раньше я жила на севере. Там очень холодные зимы. Обычная температура — минус 35 градусов. Но сейчас я живу на юге.', ''],
      ['—', 'А я живу на востоке. В январе — минус 10 градусов. Мой любимый месяц — август.', ''],
    ]);
    // Sapak 18 dialoglar
    final d18_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 31,
      'dialog_number': 333,
      'dialog_name': 'Диалог 1 — Sapak 18',
      'context_tk': 'Sapak 18 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d18_1, [
      ['—', 'Привет, Leýla. Почему ты сегодня не работаешь?', ''],
      ['—', 'Привет, Myrat. Я болею. У меня болит горло и голова. Мне очень плохо.', ''],
      ['—', 'Ты должна принимать лекарство и отдыхать. У тебя есть температура?', ''],
      ['—', 'Немного. 37.5. Я принимаю аспирин.', ''],
      ['—', 'Хорошо, выздоравливай!', ''],
    ]);
    final d18_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 31,
      'dialog_number': 334,
      'dialog_name': 'Диалог 2 — Sapak 18',
      'context_tk': 'Sapak 18 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d18_2, [
      ['—', 'Здравствуйте. Что у вас болит?', ''],
      ['—', 'Здравствуйте, доктор. У меня болит спина. Вчера она болела очень сильно.', ''],
      ['—', 'Вот рецепт. Вы должны принимать это лекарство два раза в день — утром и вечером.', ''],
    ]);
    final d18_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 31,
      'dialog_number': 335,
      'dialog_name': 'Диалог 3 — Sapak 18',
      'context_tk': 'Sapak 18 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d18_3, [
      ['—', 'Jeren, кто твой друг по профессии?', ''],
      ['—', 'Мой друг — зубной врач. А я медсестра.', ''],
      ['—', 'Тебе нравится твоя работа?', ''],
      ['—', 'Да, но зимой люди часто болеют. Иногда мы работаем 12 часов в день!', ''],
    ]);
    final d18_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 31,
      'dialog_number': 336,
      'dialog_name': 'Диалог 4 — Sapak 18',
      'context_tk': 'Sapak 18 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d18_4, [
      ['—', 'Serdar, тебе плохо?', ''],
      ['—', 'Да. У меня очень болит голова и живот. Наверное, температура.', ''],
      ['—', 'А что ты ел вчера на ужин?', ''],
      ['—', 'Не помню, что ел. Но помню, что пил: пиво, вино и шампанское. Вчера был мой день рождения...', ''],
      ['—', 'С днём рождения! Хочешь аспирин?', ''],
    ]);
    final d18_5 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 31,
      'dialog_number': 337,
      'dialog_name': 'Диалог 5 — Sapak 18',
      'context_tk': 'Sapak 18 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d18_5, [
      ['—', 'Алло, скорая помощь слушает.', ''],
      ['—', 'Здравствуйте. Мой дедушка говорит, что ему очень плохо. У него болит сердце.', ''],
      ['—', 'Какой ваш адрес?', ''],
      ['—', 'Улица Битарап Туркменистан, дом 12, квартира 7.', ''],
      ['—', 'Ваш дедушка должен лежать и принимать аспирин. Ждите скорую помощь.', ''],
      ['—', 'Большое спасибо.', ''],
    ]);
    // Sapak 19 dialoglar
    final d19_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 32,
      'dialog_number': 338,
      'dialog_name': 'Диалог 1 — Sapak 19',
      'context_tk': 'Sapak 19 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d19_1, [
      ['—', 'Привет, Myrat! Это правда, что завтра ты едешь в отпуск?', ''],
      ['—', 'Да. Завтра утром я уже буду в аэропорту. Мы летим в Рим.', ''],
      ['—', 'Как долго вы будете в Италии?', ''],
      ['—', 'Мы будем в Риме 5 дней, а потом едем в Венецию на поезде.', ''],
    ]);
    final d19_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 32,
      'dialog_number': 339,
      'dialog_name': 'Диалог 2 — Sapak 19',
      'context_tk': 'Sapak 19 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d19_2, [
      ['—', 'Gülnar, ты будешь в понедельник на работе?', ''],
      ['—', 'Нет, в понедельник я уже буду в отпуске. Мы едем на юг.', ''],
      ['—', 'Вы едете на машине или на поезде?', ''],
      ['—', 'Мы едем на поезде. Когда я еду на поезде, я смотрю в окно, читаю или сплю.', ''],
    ]);
    final d19_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 32,
      'dialog_number': 340,
      'dialog_name': 'Диалог 3 — Sapak 19',
      'context_tk': 'Sapak 19 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d19_3, [
      ['—', 'Jeren, какие у тебя планы на вечер?', ''],
      ['—', 'Буду смотреть телевизор. А у тебя?', ''],
      ['—', 'Хочешь в кино? Сегодня будет хорошая комедия. Пошли, будет весело.', ''],
      ['—', 'Давай. Во сколько мы должны быть в кинотеатре?', ''],
      ['—', 'Я буду ждать тебя на станции метро в 8 часов.', ''],
      ['—', 'Отлично! Я буду там вовремя.', ''],
      ['—', 'До встречи!', ''],
    ]);
    final d19_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 32,
      'dialog_number': 341,
      'dialog_name': 'Диалог 4 — Sapak 19',
      'context_tk': 'Sapak 19 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d19_4, [
      ['—', 'Aýna, это правда, что в Туркменистане есть длинные каникулы?', ''],
      ['—', 'Да. У нас есть длинные каникулы в январе.', ''],
      ['—', 'А что ты будешь делать в январе?', ''],
      ['—', 'Я буду дома. В феврале у меня будут важные экзамены. Поэтому в январе я буду читать книги и делать упражнения.', ''],
    ]);
    // Sapak 20 dialoglar
    final d20_1 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 33,
      'dialog_number': 342,
      'dialog_name': 'Диалог 1 — Sapak 20',
      'context_tk': 'Sapak 20 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d20_1, [
      ['—', 'Здравствуйте, что будете заказывать?', ''],
      ['—', 'На первое я буду суп с грибами. А на второе — салат с курицей. Где в меню напитки?', ''],
      ['—', 'Вот здесь. Я рекомендую вам это красное вино.', ''],
      ['—', 'Хорошо, красное вино, пожалуйста. А какие пирожки у вас есть?', ''],
      ['—', 'У нас есть пирожки с мясом и с грибами. Очень вкусные.', ''],
    ]);
    final d20_2 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 33,
      'dialog_number': 343,
      'dialog_name': 'Диалог 2 — Sapak 20',
      'context_tk': 'Sapak 20 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d20_2, [
      ['—', 'Aýna, что ты обычно заказываешь на первое в ресторане?', ''],
      ['—', 'На первое я обычно заказываю суп. А на второе — рыбу или мясо. На закуску люди обычно заказывают сыр и колбасу. Я часто заказываю блины с ветчиной и сыром. А ещё я очень люблю пирожки с мясом.', ''],
      ['—', 'А что такое окрошка?', ''],
      ['—', 'Это холодный суп. Там есть овощи, колбаса и квас. Квас — это русский напиток.', ''],
    ]);
    final d20_3 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 33,
      'dialog_number': 344,
      'dialog_name': 'Диалог 3 — Sapak 20',
      'context_tk': 'Sapak 20 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d20_3, [
      ['—', 'Извините, с чем эти блины?', ''],
      ['—', 'Эти блины с ветчиной и сыром. Но у нас есть блины с икрой, с мясом, с грибами и картошкой. Вот меню, смотрите.', ''],
      ['—', 'Хорошо, я буду блины с грибами и картошкой и чай с лимоном.', ''],
      ['—', 'Отлично. Триста рублей, пожалуйста.', ''],
    ]);
    final d20_4 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 33,
      'dialog_number': 345,
      'dialog_name': 'Диалог 4 — Sapak 20',
      'context_tk': 'Sapak 20 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d20_4, [
      ['—', 'Kemal, давай пить чай! У меня есть вкусные пирожки с яблоками.', ''],
      ['—', 'Давай! Но я не хочу чай. Можно чашку кофе с молоком?', ''],
      ['—', 'Конечно, ты пьёшь кофе с сахаром?', ''],
      ['—', 'Да, одну ложку, пожалуйста.', ''],
      ['—', 'Вот, приятного аппетита!', ''],
    ]);
    final d20_5 = await txn.insert(DbConstants.tDialogs, {
      'lesson_id': 33,
      'dialog_number': 346,
      'dialog_name': 'Диалог 5 — Sapak 20',
      'context_tk': 'Sapak 20 söhbeti',
      'category': 'lesson',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _insertLines(txn, d20_5, [
      ['—', 'Mähri, какое туркменское блюдо ты рекомендуешь?', ''],
      ['—', 'Я рекомендую всё! Я очень люблю туркменскую кухню. Плов, шурпа, манты и конечно, чорек!', ''],
      ['—', 'Отлично! Пошли завтра обедать в туркменский ресторан? А я вчера готовил блины. Я не знал, что это так легко! Я ел блины с мясом на ужин и блины с шоколадом на десерт.', ''],
      ['—', 'Какой ты молодец! А я вчера готовила пиццу с морепродуктами. Морепродукты дорогие, но я их очень люблю и часто покупаю.', ''],
    ]);
  }

  // ── GRAMMATIKA TABLISALARY ───────────────────────────
  static Future<void> _seedGrammar(Transaction txn) async {
    // Sapak 11 grammatika
    final g11_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 24,
      'table_number': 1,
      'title_tk': 'Таблица 1: У меня есть — Eýelik bildirme (у + Родительный + ',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'Eýelik bildirme', 'cell_3': 'Mysal',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'У меня есть...', 'cell_3': 'У меня есть карандаш.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'У тебя есть...', 'cell_3': 'У тебя есть ручка?',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он', 'cell_2': 'У него есть...', 'cell_3': 'У него есть брат.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'она', 'cell_2': 'У неё есть...', 'cell_3': 'У неё есть кошка.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'У нас есть...', 'cell_3': 'У нас есть дом.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'У вас есть...', 'cell_3': 'У вас есть друзья?',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'У них есть...', 'cell_3': 'У них есть хобби.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_1, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'место', 'cell_2': 'В Ашхабаде есть...', 'cell_3': 'В Ашхабаде есть театры.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g11_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 24,
      'table_number': 2,
      'title_tk': 'Таблица 2: Глагол «рисовать»',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'рисовать (häzirki)', 'cell_3': 'рисовать (geçen)',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'рисую', 'cell_3': 'рисовал / рисовала',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'рисуешь', 'cell_3': 'рисовал / рисовала',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'рисует', 'cell_3': 'рисовал / рисовала',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'рисуем', 'cell_3': 'рисовали',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'рисуете', 'cell_3': 'рисовали',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'рисуют', 'cell_3': 'рисовали',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g11_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 24,
      'table_number': 3,
      'title_tk': 'Таблица 3: Исключения множественного числа — Düzgünsiz köplü',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Ýeke san', 'cell_2': 'Köplük san', 'cell_3': 'Ýeke san',
      'cell_4': 'Köplük san', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'друг', 'cell_2': 'друзья', 'cell_3': 'город',
      'cell_4': 'города', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'брат', 'cell_2': 'братья', 'cell_3': 'дом',
      'cell_4': 'дома', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'сын', 'cell_2': 'сыновья', 'cell_3': 'цвет',
      'cell_4': 'цвета', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мать', 'cell_2': 'матери', 'cell_3': 'ребёнок',
      'cell_4': 'дети', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_3, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'дочь', 'cell_2': 'дочери', 'cell_3': 'человек',
      'cell_4': 'люди', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g11_3, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'кафе', 'cell_2': 'кафе', 'cell_3': 'хобби',
      'cell_4': 'хобби', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 12 grammatika
    final g12_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 25,
      'table_number': 1,
      'title_tk': 'Таблица 1: Винительный падёж — Hereket obýekti (Что ты ешь/п',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Nominatiw (Что?)', 'cell_2': 'Винительный (Что ты ешь?)', 'cell_3': 'Düzgün',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'горячий чай (erkek)', 'cell_2': 'горячий чай', 'cell_3': 'Им.п = Вин.п',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'вкусная еда (aýal)', 'cell_2': 'вкусную еду', 'cell_3': 'а → у, ая → ую',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'красное вино (orta)', 'cell_2': 'красное вино', 'cell_3': 'Им.п = Вин.п',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'вкусные супы (köplük)', 'cell_2': 'вкусные супы', 'cell_3': 'Им.п = Вин.п',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g12_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 25,
      'table_number': 2,
      'title_tk': 'Таблица 2: Новые глаголы: есть / пить / покупать',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'есть (iýmek)', 'cell_3': 'пить (içmek)',
      'cell_4': 'покупать (satyn almak)', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'ем', 'cell_3': 'пью',
      'cell_4': 'покупаю', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'ешь', 'cell_3': 'пьёшь',
      'cell_4': 'покупаешь', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'ест', 'cell_3': 'пьёт',
      'cell_4': 'покупает', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'едим', 'cell_3': 'пьём',
      'cell_4': 'покупаем', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'едите', 'cell_3': 'пьёте',
      'cell_4': 'покупаете', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'едят', 'cell_3': 'пьют',
      'cell_4': 'покупают', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'он (geçm.)', 'cell_2': 'ел', 'cell_3': 'пил',
      'cell_4': 'покупал', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'она (geçm.)', 'cell_2': 'ела', 'cell_3': 'пила',
      'cell_4': 'покупала', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_2, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'они (geçm.)', 'cell_2': 'ели', 'cell_3': 'пили',
      'cell_4': 'покупали', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g12_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 25,
      'table_number': 3,
      'title_tk': 'Таблица 3: Предлоги в / на — Iş ýerleriniň öňdelikleri',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'в + Предложный', 'cell_2': 'на + Предложный', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'в фирме', 'cell_2': 'на заводе', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'в школе', 'cell_2': 'на фабрике', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'в стране', 'cell_2': 'на почте', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'в городе', 'cell_2': 'на работе', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'в деревне', 'cell_2': 'на уроке', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'в парке', 'cell_2': 'на улице', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'в магазине', 'cell_2': 'на рынке', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g12_3, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'в мире', 'cell_2': 'на войне', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 13 grammatika
    final g13_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 26,
      'table_number': 1,
      'title_tk': 'Таблица 1: Числительные 10–1000 — Sanlar',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'San', 'cell_2': 'Rusça', 'cell_3': 'San',
      'cell_4': 'Rusça', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': '10', 'cell_2': 'десять', 'cell_3': '60',
      'cell_4': 'шестьдесят', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': '11', 'cell_2': 'одиннадцать', 'cell_3': '70',
      'cell_4': 'семьдесят', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': '12', 'cell_2': 'двенадцать', 'cell_3': '80',
      'cell_4': 'восемьдесят', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': '13', 'cell_2': 'тринадцать', 'cell_3': '90',
      'cell_4': 'девяносто', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': '14', 'cell_2': 'четырнадцать', 'cell_3': '100',
      'cell_4': 'сто', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': '15', 'cell_2': 'пятнадцать', 'cell_3': '200',
      'cell_4': 'двести', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 7,
      'is_header': 0,
      'cell_1': '16', 'cell_2': 'шестнадцать', 'cell_3': '300',
      'cell_4': 'триста', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 8,
      'is_header': 0,
      'cell_1': '17', 'cell_2': 'семнадцать', 'cell_3': '400',
      'cell_4': 'четыреста', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 9,
      'is_header': 0,
      'cell_1': '18', 'cell_2': 'восемнадцать', 'cell_3': '500',
      'cell_4': 'пятьсот', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 10,
      'is_header': 0,
      'cell_1': '19', 'cell_2': 'девятнадцать', 'cell_3': '1000',
      'cell_4': 'тысяча', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_1, 'row_order': 11,
      'is_header': 0,
      'cell_1': '30', 'cell_2': 'тридцать', 'cell_3': '2000',
      'cell_4': 'две тысячи', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g13_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 26,
      'table_number': 2,
      'title_tk': 'Таблица 2: Глаголы: носить / стоить',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'носить (geýmek)', 'cell_3': 'стоить (durmagy)',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'ношу', 'cell_3': 'стою',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'носишь', 'cell_3': 'стоишь',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'носит', 'cell_3': 'стоит',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'носим', 'cell_3': 'стоим',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'носите', 'cell_3': 'стоите',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'носят', 'cell_3': 'стоят',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'он (geçm.)', 'cell_2': 'носил', 'cell_3': 'стоил',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'она (geçm.)', 'cell_2': 'носила', 'cell_3': 'стоила',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_2, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'они (geçm.)', 'cell_2': 'носили', 'cell_3': 'стоили',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g13_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 26,
      'table_number': 3,
      'title_tk': 'Таблица 3: Склонение «рубль»',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Aýdylyşy', 'cell_2': 'Görnüş', 'cell_3': 'Mysal',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': '1', 'cell_2': 'рубль', 'cell_3': '1 рубль',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': '2, 3, 4', 'cell_2': 'рубля', 'cell_3': '3 рубля',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': '5+', 'cell_2': 'рублей', 'cell_3': '50 рублей',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': '190', 'cell_2': 'рублей', 'cell_3': '190 рублей',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g13_4 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 26,
      'table_number': 4,
      'title_tk': 'Таблица 4: Указательные местоимения — этот / эта / это / эти',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 4,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_4, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Jyns', 'cell_2': 'Görnüş', 'cell_3': 'Mysal (Им.п.)',
      'cell_4': 'Mysal (Вин.п.)', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_4, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'Erkek (он)', 'cell_2': 'этот', 'cell_3': 'Этот шарф тёплый.',
      'cell_4': 'Я ношу этот шарф.', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_4, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'Aýal (она)', 'cell_2': 'эта', 'cell_3': 'Эта юбка модная.',
      'cell_4': 'Я ношу эту юбку.', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_4, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'Orta (оно)', 'cell_2': 'это', 'cell_3': 'Это пальто старое.',
      'cell_4': 'Я ношу это пальто.', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g13_4, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'Köplük (они)', 'cell_2': 'эти', 'cell_3': 'Эти туфли новые.',
      'cell_4': 'Я ношу эти туфли.', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 14 grammatika
    final g14_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 27,
      'table_number': 1,
      'title_tk': 'Таблица 1: Предложный падёж мест в квартире',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'в + Предложный', 'cell_2': 'на + Предложный', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'в квартире', 'cell_2': 'на балконе', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'в комнате', 'cell_2': 'на столе', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'в ванной', 'cell_2': 'на кухне', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'в спальне', 'cell_2': 'на стене', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'в гостиной', 'cell_2': 'на стуле', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'в кресле', 'cell_2': 'на кровати', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'в холодильнике', 'cell_2': 'на диване', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_1, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'в шкафу', 'cell_2': 'на полу', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g14_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 27,
      'table_number': 2,
      'title_tk': 'Таблица 2: Числительные 100 — 1 000 000 — Uly sanlar',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'San', 'cell_2': 'Rusça', 'cell_3': 'San',
      'cell_4': 'Rusça', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': '100', 'cell_2': 'сто', 'cell_3': '800',
      'cell_4': 'восемьсот', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': '200', 'cell_2': 'двести', 'cell_3': '900',
      'cell_4': 'девятьсот', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': '300', 'cell_2': 'триста', 'cell_3': '1000',
      'cell_4': 'тысяча', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': '400', 'cell_2': 'четыреста', 'cell_3': '2000',
      'cell_4': 'две тысячи', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': '500', 'cell_2': 'пятьсот', 'cell_3': '5000',
      'cell_4': 'пять тысяч', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': '600', 'cell_2': 'шестьсот', 'cell_3': '10 000',
      'cell_4': 'десять тысяч', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_2, 'row_order': 7,
      'is_header': 0,
      'cell_1': '700', 'cell_2': 'семьсот', 'cell_3': '1 000 000',
      'cell_4': 'миллион', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g14_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 27,
      'table_number': 3,
      'title_tk': 'Таблица 3: Глаголы: стоять / лежать / висеть',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'стоять (durmak)', 'cell_3': 'лежать (ýatmak)',
      'cell_4': 'висеть (asylmak)', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'стою', 'cell_3': 'лежу',
      'cell_4': 'вишу', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'стоишь', 'cell_3': 'лежишь',
      'cell_4': 'висишь', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'стоит', 'cell_3': 'лежит',
      'cell_4': 'висит', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'стоим', 'cell_3': 'лежим',
      'cell_4': 'висим', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'стоите', 'cell_3': 'лежите',
      'cell_4': 'висите', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'стоят', 'cell_3': 'лежат',
      'cell_4': 'висят', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'он (geçm.)', 'cell_2': 'стоял', 'cell_3': 'лежал',
      'cell_4': 'висел', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'она (geçm.)', 'cell_2': 'стояла', 'cell_3': 'лежала',
      'cell_4': 'висела', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'они (geçm.)', 'cell_2': 'стояли', 'cell_3': 'лежали',
      'cell_4': 'висели', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g14_3, 'row_order': 10,
      'is_header': 0,
      'cell_1': 'оно (geçm.)', 'cell_2': 'стояло', 'cell_3': 'лежало',
      'cell_4': 'висело', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 15 grammatika
    final g15_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 28,
      'table_number': 1,
      'title_tk': 'Таблица 1: Новые глаголы: видеть / спешить / находиться',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'видеть', 'cell_3': 'спешить',
      'cell_4': 'находиться', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'вижу', 'cell_3': 'спешу',
      'cell_4': 'нахожусь', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'видишь', 'cell_3': 'спешишь',
      'cell_4': 'находишься', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'видит', 'cell_3': 'спешит',
      'cell_4': 'находится', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'видим', 'cell_3': 'спешим',
      'cell_4': 'находимся', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'видите', 'cell_3': 'спешите',
      'cell_4': 'находитесь', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'видят', 'cell_3': 'спешат',
      'cell_4': 'находятся', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'он (geçm.)', 'cell_2': 'видел', 'cell_3': 'спешил',
      'cell_4': 'находился', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'она (geçm.)', 'cell_2': 'видела', 'cell_3': 'спешила',
      'cell_4': 'находилась', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_1, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'они (geçm.)', 'cell_2': 'видели', 'cell_3': 'спешили',
      'cell_4': 'находились', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g15_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 28,
      'table_number': 2,
      'title_tk': 'Таблица 2: Повелительное наклонение — Buýruk işlik',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Işlik', 'cell_2': 'Olar (3ş.köp.)', 'cell_3': 'Ты buýruk',
      'cell_4': 'Вы buýruk', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'смотреть', 'cell_2': 'смотрят', 'cell_3': 'смотри!',
      'cell_4': 'смотрите!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'идти', 'cell_2': 'идут', 'cell_3': 'иди!',
      'cell_4': 'идите!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'писать', 'cell_2': 'пишут', 'cell_3': 'пиши!',
      'cell_4': 'пишите!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'говорить', 'cell_2': 'говорят', 'cell_3': 'говори!',
      'cell_4': 'говорите!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'делать', 'cell_2': 'делают', 'cell_3': 'делай!',
      'cell_4': 'делайте!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'читать', 'cell_2': 'читают', 'cell_3': 'читай!',
      'cell_4': 'читайте!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'слушать', 'cell_2': 'слушают', 'cell_3': 'слушай!',
      'cell_4': 'слушайте!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'есть', 'cell_2': 'едят', 'cell_3': 'ешь!',
      'cell_4': 'ешьте!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'пить', 'cell_2': 'пьют', 'cell_3': 'пей!',
      'cell_4': 'пейте!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_2, 'row_order': 10,
      'is_header': 0,
      'cell_1': 'готовить', 'cell_2': 'готовят', 'cell_3': 'готовь!',
      'cell_4': 'готовьте!', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g15_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 28,
      'table_number': 3,
      'title_tk': 'Таблица 3: Особые окончания Предложного падежа',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Düzgün', 'cell_2': 'Mysal', 'cell_3': 'Предложный',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'çekimsiz+е', 'cell_2': 'город', 'cell_3': 'в городе',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'й→е', 'cell_2': 'музей', 'cell_3': 'в музее',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'ь→е(erkek)', 'cell_2': 'Кремль', 'cell_3': 'в Кремле',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'ь→и(aýal)', 'cell_2': 'площадь', 'cell_3': 'на площади',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 5,
      'is_header': 0,
      'cell_1': '-ия→-ии', 'cell_2': 'Россия', 'cell_3': 'в России',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 6,
      'is_header': 0,
      'cell_1': '-ая/-яя→-ой', 'cell_2': 'гостиная', 'cell_3': 'в гостиной',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 7,
      'is_header': 0,
      'cell_1': '-о→-е', 'cell_2': 'письмо', 'cell_3': 'в письме',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 8,
      'is_header': 0,
      'cell_1': '-ие→-ии', 'cell_2': 'здание', 'cell_3': 'в здании',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g15_3, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'у(aýratyn)', 'cell_2': 'шкаф', 'cell_3': 'в шкафу / на полу',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 16 grammatika
    final g16_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 29,
      'table_number': 1,
      'title_tk': 'Таблица 1: Дательный падёж местоимений — Kime? düşümi',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Именительный', 'cell_2': 'Дательный', 'cell_3': 'нравиться mysaly',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'мне', 'cell_3': 'Мне нравится музыка.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'тебе', 'cell_3': 'Тебе нравятся гитары?',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/оно', 'cell_2': 'ему', 'cell_3': 'Ему нравится зима.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'она', 'cell_2': 'ей', 'cell_3': 'Ей нравится танцевать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'нам', 'cell_3': 'Нам нравится этот город.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'вам', 'cell_3': 'Вам нравится наша страна?',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_1, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'им', 'cell_3': 'Им нравятся туркменские песни.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g16_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 29,
      'table_number': 2,
      'title_tk': 'Таблица 2: Месяцы в предложном падеже — Aýlar',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Aý', 'cell_2': 'Предложный(Когда?)', 'cell_3': 'Aý',
      'cell_4': 'Предложный(Когда?)', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'январь', 'cell_2': 'в январе', 'cell_3': 'июль',
      'cell_4': 'в июле', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'февраль', 'cell_2': 'в феврале', 'cell_3': 'август',
      'cell_4': 'в августе', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'март', 'cell_2': 'в марте', 'cell_3': 'сентябрь',
      'cell_4': 'в сентябре', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'апрель', 'cell_2': 'в апреле', 'cell_3': 'октябрь',
      'cell_4': 'в октябре', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'май', 'cell_2': 'в мае', 'cell_3': 'ноябрь',
      'cell_4': 'в ноябре', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'июнь', 'cell_2': 'в июне', 'cell_3': 'декабрь',
      'cell_4': 'в декабре', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g16_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 29,
      'table_number': 3,
      'title_tk': 'Таблица 3: Числительные со словом «год»',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'San', 'cell_2': 'год görnüşi', 'cell_3': 'Mysal',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': '1', 'cell_2': 'год', 'cell_3': 'Мне 1 год.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': '2,3,4', 'cell_2': 'года', 'cell_3': 'Мне 2/3/4 года.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': '5–20', 'cell_2': 'лет', 'cell_3': 'Мне 5/20 лет.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': '21', 'cell_2': 'год', 'cell_3': 'Мне 21 год.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_3, 'row_order': 5,
      'is_header': 0,
      'cell_1': '22,23,24', 'cell_2': 'года', 'cell_3': 'Мне 22 года.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_3, 'row_order': 6,
      'is_header': 0,
      'cell_1': '25+', 'cell_2': 'лет', 'cell_3': 'Мне 25/42 лет.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g16_4 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 29,
      'table_number': 4,
      'title_tk': 'Таблица 4: Глагол «танцевать»',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 4,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_4, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'танцевать(häzirki)', 'cell_3': 'танцевать(geçen)',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_4, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'танцую', 'cell_3': 'танцевал/танцевала',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_4, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'танцуешь', 'cell_3': 'танцевал/танцевала',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_4, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'танцует', 'cell_3': 'танцевал/танцевала',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_4, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'танцуем', 'cell_3': 'танцевали',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_4, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'танцуете', 'cell_3': 'танцевали',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_4, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'танцуют', 'cell_3': 'танцевали',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g16_5 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 29,
      'table_number': 5,
      'title_tk': 'Таблица 5: Предлоги с глаголом «играть»',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 5,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_5, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'играть в футбол', 'cell_2': '→  futbol oýnamak', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_5, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'играть в баскетбол', 'cell_2': '→  basketbol oýnamak', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_5, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'играть на гитаре', 'cell_2': '→  gitara çalmak', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_5, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'играть на скрипке', 'cell_2': '→  skripka çalmak', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g16_5, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'играть на пианино', 'cell_2': '→  pianino çalmak', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 17 grammatika
    final g17_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 30,
      'table_number': 1,
      'title_tk': 'Таблица 1: Новые глаголы: предпочитать / кататься',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'предпочитать', 'cell_3': 'кататься',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'предпочитаю', 'cell_3': 'катаюсь',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'предпочитаешь', 'cell_3': 'катаешься',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'предпочитает', 'cell_3': 'катается',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'предпочитаем', 'cell_3': 'катаемся',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'предпочитаете', 'cell_3': 'катаетесь',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'предпочитают', 'cell_3': 'катаются',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'он(geçm.)', 'cell_2': 'предпочитал', 'cell_3': 'катался',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'она(geçm.)', 'cell_2': 'предпочитала', 'cell_3': 'каталась',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_1, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'они(geçm.)', 'cell_2': 'предпочитали', 'cell_3': 'катались',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g17_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 30,
      'table_number': 2,
      'title_tk': 'Таблица 2: Творительный падёж с временами года',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Ýyl pasly', 'cell_2': 'Haçan?(Творительный падёж)', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'зима(gyş)', 'cell_2': 'зимой', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'весна(ýaz)', 'cell_2': 'весной', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'лето(tomus)', 'cell_2': 'летом', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'осень(güýz)', 'cell_2': 'осенью', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g17_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 30,
      'table_number': 3,
      'title_tk': 'Таблица 3: Склонение «градус»',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'San', 'cell_2': 'градус görnüşi', 'cell_3': 'Mysal',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': '1', 'cell_2': 'градус', 'cell_3': 'Сейчас 1 градус.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': '2,3,4', 'cell_2': 'градуса', 'cell_3': 'Сейчас 2 градуса.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': '0,5+', 'cell_2': 'градусов', 'cell_3': 'Сейчас 5/30 градусов.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'минус', 'cell_2': 'минус+...', 'cell_3': 'Сегодня минус 5 градусов.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g17_4 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 30,
      'table_number': 4,
      'title_tk': 'Таблица 4: «идти» со словами дождь и снег',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 4,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_4, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Сейчас идёт дождь.', 'cell_2': '→  Вчера шёл дождь.', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_4, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'Сейчас идёт снег.', 'cell_2': '→  Вчера шёл снег.', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g17_5 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 30,
      'table_number': 5,
      'title_tk': 'Таблица 5: Предлог «на» с новыми словами',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 5,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Söz(Им.п.)', 'cell_2': '«На» bilen', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'север', 'cell_2': 'на севере', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'юг', 'cell_2': 'на юге', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'запад', 'cell_2': 'на западе', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'восток', 'cell_2': 'на востоке', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'лыжи', 'cell_2': 'на лыжах', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'коньки', 'cell_2': 'на коньках', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'велосипед', 'cell_2': 'на велосипеде', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_5, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'пляж', 'cell_2': 'на пляже', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g17_6 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 30,
      'table_number': 6,
      'title_tk': 'Таблица 6: Прилагательные и наречия — Sypat we naýap tapawud',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 6,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_6, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sypat (прилагательное)', 'cell_2': 'Naýap (наречие)', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_6, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'Летом жаркая погода.', 'cell_2': 'Летом жарко.', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_6, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'Зимой холодная погода.', 'cell_2': 'Зимой холодно.', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_6, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'Осенью красивые деревья.', 'cell_2': 'Осенью красиво.', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g17_6, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'Весной хорошая погода.', 'cell_2': 'Весной хорошо.', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 18 grammatika
    final g18_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 31,
      'table_number': 1,
      'title_tk': 'Таблица 1: Новые глаголы: ловить / лететь / плавать / ехать ',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'ловить', 'cell_3': 'лететь',
      'cell_4': 'плавать', 'cell_5': 'ехать', 'cell_6': 'путешествовать',
      'cell_7': 'фотографировать', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'ловлю', 'cell_3': 'лечу',
      'cell_4': 'плаваю', 'cell_5': 'еду', 'cell_6': 'путешествую',
      'cell_7': 'фотографирую', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'ловишь', 'cell_3': 'летишь',
      'cell_4': 'плаваешь', 'cell_5': 'едешь', 'cell_6': 'путешествуешь',
      'cell_7': 'фотографируешь', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'ловит', 'cell_3': 'летит',
      'cell_4': 'плавает', 'cell_5': 'едет', 'cell_6': 'путешествует',
      'cell_7': 'фотографирует', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'ловим', 'cell_3': 'летим',
      'cell_4': 'плаваем', 'cell_5': 'едем', 'cell_6': 'путешествуем',
      'cell_7': 'фотографируем', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'ловите', 'cell_3': 'летите',
      'cell_4': 'плаваете', 'cell_5': 'едете', 'cell_6': 'путешествуете',
      'cell_7': 'фотографируете', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'ловят', 'cell_3': 'летят',
      'cell_4': 'плавают', 'cell_5': 'едут', 'cell_6': 'путешествуют',
      'cell_7': 'фотографируют', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'он(geçm.)', 'cell_2': 'ловил', 'cell_3': 'летел',
      'cell_4': 'плавал', 'cell_5': 'ехал', 'cell_6': 'путешествовал',
      'cell_7': 'фотографировал', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'она(geçm.)', 'cell_2': 'ловила', 'cell_3': 'летела',
      'cell_4': 'плавала', 'cell_5': 'ехала', 'cell_6': 'путешествовала',
      'cell_7': 'фотографировала', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_1, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'они(geçm.)', 'cell_2': 'ловили', 'cell_3': 'летели',
      'cell_4': 'плавали', 'cell_5': 'ехали', 'cell_6': 'путешествовали',
      'cell_7': 'фотографировали', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g18_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 31,
      'table_number': 2,
      'title_tk': 'Таблица 2: Будущее время — Geljek zaman (буду + infinitiv)',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'Geljek zaman', 'cell_3': 'Mysal',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'буду+inf', 'cell_3': 'Завтра я буду работать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'будешь+inf', 'cell_3': 'Ты будешь спать?',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'будет+inf', 'cell_3': 'Он будет ехать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'будем+inf', 'cell_3': 'Мы будем путешествовать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'будете+inf', 'cell_3': 'Вы будете работать?',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'будут+inf', 'cell_3': 'Они будут плавать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_2, 'row_order': 7,
      'is_header': 0,
      'cell_1': '(zat)', 'cell_2': 'будет/будут', 'cell_3': 'Завтра будет дождь./Будут экзамены.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g18_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 31,
      'table_number': 3,
      'title_tk': 'Таблица 3: Предложный падёж транспорта',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Transport', 'cell_2': 'На чём?', 'cell_3': 'Transport',
      'cell_4': 'На чём?', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'машина', 'cell_2': 'на машине', 'cell_3': 'троллейбус',
      'cell_4': 'на троллейбусе', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'поезд', 'cell_2': 'на поезде', 'cell_3': 'трамвай',
      'cell_4': 'на трамвае', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'метро', 'cell_2': 'на метро', 'cell_3': 'самолёт',
      'cell_4': 'на самолёте', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'автобус', 'cell_2': 'на автобусе', 'cell_3': 'велосипед',
      'cell_4': 'на велосипеде', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g18_3, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'такси', 'cell_2': 'на такси', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 19 grammatika
    final g19_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 32,
      'table_number': 1,
      'title_tk': 'Таблица 1: Будущее время — Geljek zaman',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'Geljek zaman', 'cell_3': 'Mysal',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'буду+inf', 'cell_3': 'Завтра я буду работать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'будешь+inf', 'cell_3': 'Ты будешь спать?',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'будет+inf', 'cell_3': 'Он будет ехать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'будем+inf', 'cell_3': 'Мы будем путешествовать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'будете+inf', 'cell_3': 'Вы будете отдыхать?',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'будут+inf', 'cell_3': 'Они будут плавать.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g19_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 32,
      'table_number': 2,
      'title_tk': 'Таблица 2: Предложный падёж транспорта',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Transport(Им.п.)', 'cell_2': 'Предложный(На чём?)', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'машина', 'cell_2': 'на машине', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'поезд', 'cell_2': 'на поезде', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'метро', 'cell_2': 'на метро', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'автобус', 'cell_2': 'на автобусе', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'такси', 'cell_2': 'на такси', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'велосипед', 'cell_2': 'на велосипеде', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'троллейбус', 'cell_2': 'на троллейбусе', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'трамвай', 'cell_2': 'на трамвае', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_2, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'самолёт', 'cell_2': 'на самолёте', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g19_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 32,
      'table_number': 3,
      'title_tk': 'Таблица 3: Падежи — Ähli düşümler',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Düşüm', 'cell_2': 'Sorag', 'cell_3': 'Mysal',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'Именительный', 'cell_2': 'Кто? Что?', 'cell_3': 'Это студент. Это книга.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'Родительный', 'cell_2': 'Кого? Чего? / У кого?', 'cell_3': 'У меня есть. 8 часов утра.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'Дательный', 'cell_2': 'Кому? / Сколько лет?', 'cell_3': 'Мне нравится. Мне 20 лет.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'Винительный', 'cell_2': 'Кого? Что? / Куда?', 'cell_3': 'Я еду в школу. Я люблю её.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_3, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'Творительный', 'cell_2': 'Кем? Чем? / Когда?', 'cell_3': 'утром, летом, с другом.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g19_3, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'Предложный', 'cell_2': 'О чём? / Где?', 'cell_3': 'в школе, на работе, о книге.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 20 grammatika
    final g20_1 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 33,
      'table_number': 1,
      'title_tk': 'Таблица 1: Творительный падёж с предлогом «с» — Bilen / С + ',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Nominatiw (Что это?)', 'cell_2': 'Творительный с «с» (С чем?)', 'cell_3': 'Düzgün',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'шоколад (erkek, çekimsiz)', 'cell_2': 'с шоколадом', 'cell_3': '-ом',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'чай (erkek, й bilen)', 'cell_2': 'с чаем', 'cell_3': '-ей (й→ей)',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'учитель (erkek, ь bilen)', 'cell_2': 'с учителем', 'cell_3': '-ем',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'картошка (aýal, -а)', 'cell_2': 'с картошкой', 'cell_3': '-ой (а→ой)',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'каша (aýal, -а)', 'cell_2': 'с кашей', 'cell_3': '-ей (ша→шей)',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'тётя (aýal, -я)', 'cell_2': 'с тётей', 'cell_3': '-ей',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'курица (aýal, -а)', 'cell_2': 'с курицей', 'cell_3': '-ей (ца→цей)',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'соль (aýal, ь bilen)', 'cell_2': 'с солью', 'cell_3': '-ью',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'молоко (orta, -о)', 'cell_2': 'с молоком', 'cell_3': '-ом',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 10,
      'is_header': 0,
      'cell_1': 'мороженое (orta, -ое)', 'cell_2': 'с мороженым', 'cell_3': 'ое→ым',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_1, 'row_order': 11,
      'is_header': 0,
      'cell_1': 'печенье (orta, -е)', 'cell_2': 'с печеньем', 'cell_3': '-ем',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g20_2 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 33,
      'table_number': 2,
      'title_tk': 'Таблица 2: Новые глаголы: давать / рекомендовать / заказыват',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 0,
      'is_header': 1,
      'cell_1': 'Sahyp', 'cell_2': 'давать (bermek)', 'cell_3': 'рекомендовать (maslahat bermek)',
      'cell_4': 'заказывать (sargyt etmek)', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'даю', 'cell_3': 'рекомендую',
      'cell_4': 'заказываю', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'даёшь', 'cell_3': 'рекомендуешь',
      'cell_4': 'заказываешь', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'он/она', 'cell_2': 'даёт', 'cell_3': 'рекомендует',
      'cell_4': 'заказывает', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'даём', 'cell_3': 'рекомендуем',
      'cell_4': 'заказываем', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'даёте', 'cell_3': 'рекомендуете',
      'cell_4': 'заказываете', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'дают', 'cell_3': 'рекомендуют',
      'cell_4': 'заказывают', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'он (geçm.)', 'cell_2': 'давал', 'cell_3': 'рекомендовал',
      'cell_4': 'заказывал', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'она (geçm.)', 'cell_2': 'давала', 'cell_3': 'рекомендовала',
      'cell_4': 'заказывала', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_2, 'row_order': 9,
      'is_header': 0,
      'cell_1': 'они (geçm.)', 'cell_2': 'давали', 'cell_3': 'рекомендовали',
      'cell_4': 'заказывали', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g20_3 = await txn.insert(DbConstants.tGrammarRules, {
      'lesson_id': 33,
      'table_number': 3,
      'title_tk': 'Таблица 3: Дательный падёж с глаголами — Kime berýän? Дативн',
      'title_ru': '',
      'explanation_tk': '',
      'note_tk': '',
      'rule_type': 'table',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 0,
      'is_header': 1,
      'cell_1': '📌 давать / рекомендовать / писать / говорить / читать işlikl', 'cell_2': 'Кому? → Дат.п.', 'cell_3': '',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 1,
      'is_header': 0,
      'cell_1': 'Sahyp', 'cell_2': 'Дательный (Кому?)', 'cell_3': 'Mysallar',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 2,
      'is_header': 0,
      'cell_1': 'я', 'cell_2': 'мне', 'cell_3': 'Дай мне счёт.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 3,
      'is_header': 0,
      'cell_1': 'ты', 'cell_2': 'тебе', 'cell_3': 'Я рекомендую тебе суп.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 4,
      'is_header': 0,
      'cell_1': 'он / оно', 'cell_2': 'ему', 'cell_3': 'Официант даёт ему меню.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 5,
      'is_header': 0,
      'cell_1': 'она', 'cell_2': 'ей', 'cell_3': 'Я рекомендую ей это вино.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 6,
      'is_header': 0,
      'cell_1': 'мы', 'cell_2': 'нам', 'cell_3': 'Официант рекомендует нам мороженое.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 7,
      'is_header': 0,
      'cell_1': 'вы', 'cell_2': 'вам', 'cell_3': 'Я дам вам рецепт.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {
      'grammar_id': g20_3, 'row_order': 8,
      'is_header': 0,
      'cell_1': 'они', 'cell_2': 'им', 'cell_3': 'Мы рекомендуем им туркменский ресторан.',
      'cell_4': '', 'cell_5': '', 'cell_6': '',
      'cell_7': '', 'red_cells': '',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // ── GÖNÜKMELER (her sapak üçin 2 gönükme) ───────────
  static Future<void> _seedExercises(Transaction txn) async {
    // Sapak 11 — Flash kart (sözler)
    final e11_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 24, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 0,
      'question_text': 'белый', 'correct_answer': 'ak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 1,
      'question_text': 'чёрный', 'correct_answer': 'gara',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 2,
      'question_text': 'серый', 'correct_answer': 'çal',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 3,
      'question_text': 'красный', 'correct_answer': 'gyzyl',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 4,
      'question_text': 'зелёный', 'correct_answer': 'ýaşyl',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 5,
      'question_text': 'синий', 'correct_answer': 'goýy gök',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 6,
      'question_text': 'голубой', 'correct_answer': 'açyk gök',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 7,
      'question_text': 'жёлтый', 'correct_answer': 'sary',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 8,
      'question_text': 'коричневый', 'correct_answer': 'goňur',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 9,
      'question_text': 'оранжевый', 'correct_answer': 'mämişi',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 10,
      'question_text': 'розовый', 'correct_answer': 'gülgün',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 11,
      'question_text': 'фиолетовый', 'correct_answer': 'benewşe reňk',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 12,
      'question_text': 'умный', 'correct_answer': 'глупый  — akylly — akmak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 13,
      'question_text': 'цвет', 'correct_answer': 'цвета  — reňk — reňkler',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_1, 'question_order': 14,
      'question_text': 'карандаш', 'correct_answer': 'galam',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 11 — Köp saýlaw
    final e11_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 24, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q11_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_2, 'question_order': 0,
      'question_text': 'белый', 'correct_answer': 'ak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_0, 'option_text': 'ak', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_0, 'option_text': 'gara', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_0, 'option_text': 'çal', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_0, 'option_text': 'gyzyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q11_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_2, 'question_order': 1,
      'question_text': 'чёрный', 'correct_answer': 'gara',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_1, 'option_text': 'gara', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_1, 'option_text': 'ak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_1, 'option_text': 'çal', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_1, 'option_text': 'gyzyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q11_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_2, 'question_order': 2,
      'question_text': 'серый', 'correct_answer': 'çal',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_2, 'option_text': 'çal', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_2, 'option_text': 'ak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_2, 'option_text': 'gara', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_2, 'option_text': 'gyzyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q11_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_2, 'question_order': 3,
      'question_text': 'красный', 'correct_answer': 'gyzyl',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_3, 'option_text': 'gyzyl', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_3, 'option_text': 'ak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_3, 'option_text': 'gara', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_3, 'option_text': 'çal', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q11_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_2, 'question_order': 4,
      'question_text': 'зелёный', 'correct_answer': 'ýaşyl',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_4, 'option_text': 'ýaşyl', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_4, 'option_text': 'ak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_4, 'option_text': 'gara', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_4, 'option_text': 'çal', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q11_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_2, 'question_order': 5,
      'question_text': 'синий', 'correct_answer': 'goýy gök',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_5, 'option_text': 'goýy gök', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_5, 'option_text': 'ak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_5, 'option_text': 'gara', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_5, 'option_text': 'çal', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q11_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_2, 'question_order': 6,
      'question_text': 'голубой', 'correct_answer': 'açyk gök',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_6, 'option_text': 'açyk gök', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_6, 'option_text': 'ak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_6, 'option_text': 'gara', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_6, 'option_text': 'çal', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q11_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e11_2, 'question_order': 7,
      'question_text': 'жёлтый', 'correct_answer': 'sary',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_7, 'option_text': 'sary', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_7, 'option_text': 'ak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_7, 'option_text': 'gara', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q11_7, 'option_text': 'çal', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 12 — Flash kart (sözler)
    final e12_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 25, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 0,
      'question_text': 'еда', 'correct_answer': 'iýmit',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 1,
      'question_text': 'продукт', 'correct_answer': 'önüm',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 2,
      'question_text': 'мясо', 'correct_answer': 'et',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 3,
      'question_text': 'рыба', 'correct_answer': 'balyk',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 4,
      'question_text': 'курица', 'correct_answer': 'towuk',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 5,
      'question_text': 'сыр', 'correct_answer': 'peýnir',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 6,
      'question_text': 'картошка', 'correct_answer': 'kartoşka',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 7,
      'question_text': 'хлеб', 'correct_answer': 'çörek',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 8,
      'question_text': 'рис', 'correct_answer': 'tüwi',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 9,
      'question_text': 'колбаса', 'correct_answer': 'kolbasa',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 10,
      'question_text': 'салат', 'correct_answer': 'salat',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 11,
      'question_text': 'суп', 'correct_answer': 'çorba',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 12,
      'question_text': 'бутерброд', 'correct_answer': 'buterbrod',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 13,
      'question_text': 'овощ', 'correct_answer': 'gök önüm',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_1, 'question_order': 14,
      'question_text': 'фрукт', 'correct_answer': 'miwe',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 12 — Köp saýlaw
    final e12_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 25, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q12_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_2, 'question_order': 0,
      'question_text': 'еда', 'correct_answer': 'iýmit',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_0, 'option_text': 'iýmit', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_0, 'option_text': 'önüm', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_0, 'option_text': 'et', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_0, 'option_text': 'balyk', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q12_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_2, 'question_order': 1,
      'question_text': 'продукт', 'correct_answer': 'önüm',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_1, 'option_text': 'önüm', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_1, 'option_text': 'iýmit', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_1, 'option_text': 'et', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_1, 'option_text': 'balyk', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q12_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_2, 'question_order': 2,
      'question_text': 'мясо', 'correct_answer': 'et',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_2, 'option_text': 'et', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_2, 'option_text': 'iýmit', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_2, 'option_text': 'önüm', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_2, 'option_text': 'balyk', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q12_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_2, 'question_order': 3,
      'question_text': 'рыба', 'correct_answer': 'balyk',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_3, 'option_text': 'balyk', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_3, 'option_text': 'iýmit', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_3, 'option_text': 'önüm', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_3, 'option_text': 'et', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q12_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_2, 'question_order': 4,
      'question_text': 'курица', 'correct_answer': 'towuk',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_4, 'option_text': 'towuk', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_4, 'option_text': 'iýmit', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_4, 'option_text': 'önüm', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_4, 'option_text': 'et', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q12_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_2, 'question_order': 5,
      'question_text': 'сыр', 'correct_answer': 'peýnir',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_5, 'option_text': 'peýnir', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_5, 'option_text': 'iýmit', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_5, 'option_text': 'önüm', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_5, 'option_text': 'et', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q12_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_2, 'question_order': 6,
      'question_text': 'картошка', 'correct_answer': 'kartoşka',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_6, 'option_text': 'kartoşka', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_6, 'option_text': 'iýmit', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_6, 'option_text': 'önüm', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_6, 'option_text': 'et', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q12_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e12_2, 'question_order': 7,
      'question_text': 'хлеб', 'correct_answer': 'çörek',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_7, 'option_text': 'çörek', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_7, 'option_text': 'iýmit', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_7, 'option_text': 'önüm', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q12_7, 'option_text': 'et', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 13 — Flash kart (sözler)
    final e13_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 26, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 0,
      'question_text': 'одежда', 'correct_answer': 'egin-eşik',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 1,
      'question_text': 'обувь', 'correct_answer': 'aýakgap',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 2,
      'question_text': 'рубашка', 'correct_answer': 'köýnek (erkek)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 3,
      'question_text': 'футболка', 'correct_answer': 'futbolka',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 4,
      'question_text': 'брюки', 'correct_answer': 'balak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 5,
      'question_text': 'джинсы', 'correct_answer': 'jins',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 6,
      'question_text': 'шорты', 'correct_answer': 'şort',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 7,
      'question_text': 'перчатки', 'correct_answer': 'elde geýilýän',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 8,
      'question_text': 'шарф', 'correct_answer': 'şarf',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 9,
      'question_text': 'платье', 'correct_answer': 'köýnek (aýal)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 10,
      'question_text': 'пальто', 'correct_answer': 'palto',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 11,
      'question_text': 'свитер', 'correct_answer': 'switer',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 12,
      'question_text': 'шапка', 'correct_answer': 'başgap',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 13,
      'question_text': 'костюм', 'correct_answer': 'kostýum',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_1, 'question_order': 14,
      'question_text': 'юбка', 'correct_answer': 'ýubka',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 13 — Köp saýlaw
    final e13_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 26, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q13_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_2, 'question_order': 0,
      'question_text': 'одежда', 'correct_answer': 'egin-eşik',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_0, 'option_text': 'egin-eşik', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_0, 'option_text': 'aýakgap', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_0, 'option_text': 'köýnek (erkek)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_0, 'option_text': 'futbolka', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q13_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_2, 'question_order': 1,
      'question_text': 'обувь', 'correct_answer': 'aýakgap',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_1, 'option_text': 'aýakgap', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_1, 'option_text': 'egin-eşik', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_1, 'option_text': 'köýnek (erkek)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_1, 'option_text': 'futbolka', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q13_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_2, 'question_order': 2,
      'question_text': 'рубашка', 'correct_answer': 'köýnek (erkek)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_2, 'option_text': 'köýnek (erkek)', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_2, 'option_text': 'egin-eşik', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_2, 'option_text': 'aýakgap', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_2, 'option_text': 'futbolka', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q13_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_2, 'question_order': 3,
      'question_text': 'футболка', 'correct_answer': 'futbolka',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_3, 'option_text': 'futbolka', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_3, 'option_text': 'egin-eşik', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_3, 'option_text': 'aýakgap', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_3, 'option_text': 'köýnek (erkek)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q13_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_2, 'question_order': 4,
      'question_text': 'брюки', 'correct_answer': 'balak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_4, 'option_text': 'balak', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_4, 'option_text': 'egin-eşik', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_4, 'option_text': 'aýakgap', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_4, 'option_text': 'köýnek (erkek)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q13_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_2, 'question_order': 5,
      'question_text': 'джинсы', 'correct_answer': 'jins',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_5, 'option_text': 'jins', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_5, 'option_text': 'egin-eşik', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_5, 'option_text': 'aýakgap', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_5, 'option_text': 'köýnek (erkek)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q13_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_2, 'question_order': 6,
      'question_text': 'шорты', 'correct_answer': 'şort',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_6, 'option_text': 'şort', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_6, 'option_text': 'egin-eşik', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_6, 'option_text': 'aýakgap', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_6, 'option_text': 'köýnek (erkek)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q13_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e13_2, 'question_order': 7,
      'question_text': 'перчатки', 'correct_answer': 'elde geýilýän',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_7, 'option_text': 'elde geýilýän', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_7, 'option_text': 'egin-eşik', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_7, 'option_text': 'aýakgap', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q13_7, 'option_text': 'köýnek (erkek)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 14 — Flash kart (sözler)
    final e14_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 27, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 0,
      'question_text': 'Добро пожаловать!', 'correct_answer': 'Hoş geldiňiz!',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 1,
      'question_text': 'комната', 'correct_answer': 'otag',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 2,
      'question_text': 'ванная', 'correct_answer': 'hammam',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 3,
      'question_text': 'кухня', 'correct_answer': 'aşhana',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 4,
      'question_text': 'спальня', 'correct_answer': 'ýatylýan otag',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 5,
      'question_text': 'гостиная', 'correct_answer': 'myhman otag',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 6,
      'question_text': 'мебель', 'correct_answer': 'mebel',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 7,
      'question_text': 'стена', 'correct_answer': 'diwar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 8,
      'question_text': 'пол', 'correct_answer': 'pol',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 9,
      'question_text': 'балкон', 'correct_answer': 'balkon',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 10,
      'question_text': 'диван', 'correct_answer': 'diwаn',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 11,
      'question_text': 'кресло', 'correct_answer': 'kreslo',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 12,
      'question_text': 'кровать', 'correct_answer': 'ýatak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 13,
      'question_text': 'стол', 'correct_answer': 'stol',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_1, 'question_order': 14,
      'question_text': 'стул / стулья', 'correct_answer': 'oturgyç',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 14 — Köp saýlaw
    final e14_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 27, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q14_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_2, 'question_order': 0,
      'question_text': 'Добро пожаловать!', 'correct_answer': 'Hoş geldiňiz!',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_0, 'option_text': 'Hoş geldiňiz!', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_0, 'option_text': 'otag', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_0, 'option_text': 'hammam', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_0, 'option_text': 'aşhana', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q14_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_2, 'question_order': 1,
      'question_text': 'комната', 'correct_answer': 'otag',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_1, 'option_text': 'otag', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_1, 'option_text': 'Hoş geldiňiz!', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_1, 'option_text': 'hammam', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_1, 'option_text': 'aşhana', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q14_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_2, 'question_order': 2,
      'question_text': 'ванная', 'correct_answer': 'hammam',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_2, 'option_text': 'hammam', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_2, 'option_text': 'Hoş geldiňiz!', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_2, 'option_text': 'otag', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_2, 'option_text': 'aşhana', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q14_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_2, 'question_order': 3,
      'question_text': 'кухня', 'correct_answer': 'aşhana',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_3, 'option_text': 'aşhana', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_3, 'option_text': 'Hoş geldiňiz!', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_3, 'option_text': 'otag', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_3, 'option_text': 'hammam', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q14_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_2, 'question_order': 4,
      'question_text': 'спальня', 'correct_answer': 'ýatylýan otag',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_4, 'option_text': 'ýatylýan otag', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_4, 'option_text': 'Hoş geldiňiz!', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_4, 'option_text': 'otag', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_4, 'option_text': 'hammam', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q14_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_2, 'question_order': 5,
      'question_text': 'гостиная', 'correct_answer': 'myhman otag',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_5, 'option_text': 'myhman otag', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_5, 'option_text': 'Hoş geldiňiz!', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_5, 'option_text': 'otag', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_5, 'option_text': 'hammam', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q14_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_2, 'question_order': 6,
      'question_text': 'мебель', 'correct_answer': 'mebel',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_6, 'option_text': 'mebel', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_6, 'option_text': 'Hoş geldiňiz!', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_6, 'option_text': 'otag', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_6, 'option_text': 'hammam', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q14_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e14_2, 'question_order': 7,
      'question_text': 'стена', 'correct_answer': 'diwar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_7, 'option_text': 'diwar', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_7, 'option_text': 'Hoş geldiňiz!', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_7, 'option_text': 'otag', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q14_7, 'option_text': 'hammam', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 15 — Flash kart (sözler)
    final e15_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 28, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 0,
      'question_text': 'здание', 'correct_answer': 'bina',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 1,
      'question_text': 'метро', 'correct_answer': 'metro',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 2,
      'question_text': 'автобус', 'correct_answer': 'awtobus',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 3,
      'question_text': 'билет', 'correct_answer': 'bilet',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 4,
      'question_text': 'площадь', 'correct_answer': 'meýdan',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 5,
      'question_text': 'торговый центр', 'correct_answer': 'söwda merkezi',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 6,
      'question_text': 'аптека', 'correct_answer': 'dermanhana',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 7,
      'question_text': 'район', 'correct_answer': 'etrap',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 8,
      'question_text': 'карта', 'correct_answer': 'karta',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 9,
      'question_text': 'здесь', 'correct_answer': 'там  — bu ýerde — ol ýerde',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 10,
      'question_text': 'близко', 'correct_answer': 'ýakyn',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 11,
      'question_text': 'далеко', 'correct_answer': 'недалеко  — uzak — uzak däl',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 12,
      'question_text': 'прямо', 'correct_answer': 'göni',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 13,
      'question_text': 'налево', 'correct_answer': 'çepe',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_1, 'question_order': 14,
      'question_text': 'направо', 'correct_answer': 'saga',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 15 — Köp saýlaw
    final e15_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 28, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q15_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_2, 'question_order': 0,
      'question_text': 'здание', 'correct_answer': 'bina',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_0, 'option_text': 'bina', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_0, 'option_text': 'metro', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_0, 'option_text': 'awtobus', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_0, 'option_text': 'bilet', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q15_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_2, 'question_order': 1,
      'question_text': 'метро', 'correct_answer': 'metro',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_1, 'option_text': 'metro', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_1, 'option_text': 'bina', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_1, 'option_text': 'awtobus', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_1, 'option_text': 'bilet', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q15_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_2, 'question_order': 2,
      'question_text': 'автобус', 'correct_answer': 'awtobus',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_2, 'option_text': 'awtobus', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_2, 'option_text': 'bina', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_2, 'option_text': 'metro', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_2, 'option_text': 'bilet', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q15_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_2, 'question_order': 3,
      'question_text': 'билет', 'correct_answer': 'bilet',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_3, 'option_text': 'bilet', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_3, 'option_text': 'bina', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_3, 'option_text': 'metro', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_3, 'option_text': 'awtobus', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q15_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_2, 'question_order': 4,
      'question_text': 'площадь', 'correct_answer': 'meýdan',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_4, 'option_text': 'meýdan', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_4, 'option_text': 'bina', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_4, 'option_text': 'metro', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_4, 'option_text': 'awtobus', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q15_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_2, 'question_order': 5,
      'question_text': 'торговый центр', 'correct_answer': 'söwda merkezi',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_5, 'option_text': 'söwda merkezi', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_5, 'option_text': 'bina', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_5, 'option_text': 'metro', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_5, 'option_text': 'awtobus', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q15_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_2, 'question_order': 6,
      'question_text': 'аптека', 'correct_answer': 'dermanhana',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_6, 'option_text': 'dermanhana', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_6, 'option_text': 'bina', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_6, 'option_text': 'metro', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_6, 'option_text': 'awtobus', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q15_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e15_2, 'question_order': 7,
      'question_text': 'район', 'correct_answer': 'etrap',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_7, 'option_text': 'etrap', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_7, 'option_text': 'bina', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_7, 'option_text': 'metro', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q15_7, 'option_text': 'awtobus', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 16 — Flash kart (sözler)
    final e16_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 29, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 0,
      'question_text': 'год', 'correct_answer': 'ýyl',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 1,
      'question_text': 'Сколько тебе лет?', 'correct_answer': 'Saňa näçe ýaş?',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 2,
      'question_text': 'Мне нравится...', 'correct_answer': 'Maňa ýaraýar...',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 3,
      'question_text': 'день рождения', 'correct_answer': 'doglan gün',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 4,
      'question_text': 'подарок', 'correct_answer': 'sowgat',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 5,
      'question_text': 'С днём рождения!', 'correct_answer': 'Doglan günüň gutly bolsun!',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 6,
      'question_text': 'Он женат', 'correct_answer': 'Ol öýli(erkek)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 7,
      'question_text': 'Она замужем', 'correct_answer': 'Ol öýli(aýal)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 8,
      'question_text': 'танцевать', 'correct_answer': 'tans etmek',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 9,
      'question_text': 'дискотека', 'correct_answer': 'disko',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 10,
      'question_text': 'гитара', 'correct_answer': 'gitara',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 11,
      'question_text': 'пианино', 'correct_answer': 'pianino',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 12,
      'question_text': 'скрипка', 'correct_answer': 'skripka',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 13,
      'question_text': 'месяц', 'correct_answer': 'aý(senenama)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_1, 'question_order': 14,
      'question_text': 'январь', 'correct_answer': 'ýanwar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 16 — Köp saýlaw
    final e16_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 29, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q16_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_2, 'question_order': 0,
      'question_text': 'год', 'correct_answer': 'ýyl',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_0, 'option_text': 'ýyl', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_0, 'option_text': 'Saňa näçe ýaş?', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_0, 'option_text': 'Maňa ýaraýar...', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_0, 'option_text': 'doglan gün', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q16_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_2, 'question_order': 1,
      'question_text': 'Сколько тебе лет?', 'correct_answer': 'Saňa näçe ýaş?',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_1, 'option_text': 'Saňa näçe ýaş?', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_1, 'option_text': 'ýyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_1, 'option_text': 'Maňa ýaraýar...', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_1, 'option_text': 'doglan gün', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q16_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_2, 'question_order': 2,
      'question_text': 'Мне нравится...', 'correct_answer': 'Maňa ýaraýar...',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_2, 'option_text': 'Maňa ýaraýar...', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_2, 'option_text': 'ýyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_2, 'option_text': 'Saňa näçe ýaş?', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_2, 'option_text': 'doglan gün', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q16_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_2, 'question_order': 3,
      'question_text': 'день рождения', 'correct_answer': 'doglan gün',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_3, 'option_text': 'doglan gün', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_3, 'option_text': 'ýyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_3, 'option_text': 'Saňa näçe ýaş?', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_3, 'option_text': 'Maňa ýaraýar...', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q16_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_2, 'question_order': 4,
      'question_text': 'подарок', 'correct_answer': 'sowgat',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_4, 'option_text': 'sowgat', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_4, 'option_text': 'ýyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_4, 'option_text': 'Saňa näçe ýaş?', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_4, 'option_text': 'Maňa ýaraýar...', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q16_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_2, 'question_order': 5,
      'question_text': 'С днём рождения!', 'correct_answer': 'Doglan günüň gutly bolsun!',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_5, 'option_text': 'Doglan günüň gutly bolsun!', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_5, 'option_text': 'ýyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_5, 'option_text': 'Saňa näçe ýaş?', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_5, 'option_text': 'Maňa ýaraýar...', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q16_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_2, 'question_order': 6,
      'question_text': 'Он женат', 'correct_answer': 'Ol öýli(erkek)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_6, 'option_text': 'Ol öýli(erkek)', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_6, 'option_text': 'ýyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_6, 'option_text': 'Saňa näçe ýaş?', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_6, 'option_text': 'Maňa ýaraýar...', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q16_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e16_2, 'question_order': 7,
      'question_text': 'Она замужем', 'correct_answer': 'Ol öýli(aýal)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_7, 'option_text': 'Ol öýli(aýal)', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_7, 'option_text': 'ýyl', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_7, 'option_text': 'Saňa näçe ýaş?', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q16_7, 'option_text': 'Maňa ýaraýar...', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 17 — Flash kart (sözler)
    final e17_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 30, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 0,
      'question_text': 'время года', 'correct_answer': 'ýyl pasly',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 1,
      'question_text': 'весна', 'correct_answer': 'ýaz',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 2,
      'question_text': 'осень', 'correct_answer': 'güýz',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 3,
      'question_text': 'север', 'correct_answer': 'demirgazyk',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 4,
      'question_text': 'запад', 'correct_answer': 'günbatar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 5,
      'question_text': 'восток', 'correct_answer': 'gündogar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 6,
      'question_text': 'холодно', 'correct_answer': 'sowuk(hal.)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 7,
      'question_text': 'жарко', 'correct_answer': 'yssy(hal.)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 8,
      'question_text': 'тепло', 'correct_answer': 'ýyly(hal.)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 9,
      'question_text': 'идёт дождь', 'correct_answer': 'ýagyş ýagýar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 10,
      'question_text': 'идёт снег', 'correct_answer': 'gar ýagýar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 11,
      'question_text': 'ветер', 'correct_answer': 'şemal',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 12,
      'question_text': 'солнце', 'correct_answer': 'gün',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 13,
      'question_text': 'температура', 'correct_answer': 'temperatura',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_1, 'question_order': 14,
      'question_text': 'градус', 'correct_answer': 'dereje',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 17 — Köp saýlaw
    final e17_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 30, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q17_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_2, 'question_order': 0,
      'question_text': 'время года', 'correct_answer': 'ýyl pasly',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_0, 'option_text': 'ýyl pasly', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_0, 'option_text': 'ýaz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_0, 'option_text': 'güýz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_0, 'option_text': 'demirgazyk', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q17_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_2, 'question_order': 1,
      'question_text': 'весна', 'correct_answer': 'ýaz',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_1, 'option_text': 'ýaz', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_1, 'option_text': 'ýyl pasly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_1, 'option_text': 'güýz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_1, 'option_text': 'demirgazyk', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q17_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_2, 'question_order': 2,
      'question_text': 'осень', 'correct_answer': 'güýz',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_2, 'option_text': 'güýz', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_2, 'option_text': 'ýyl pasly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_2, 'option_text': 'ýaz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_2, 'option_text': 'demirgazyk', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q17_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_2, 'question_order': 3,
      'question_text': 'север', 'correct_answer': 'demirgazyk',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_3, 'option_text': 'demirgazyk', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_3, 'option_text': 'ýyl pasly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_3, 'option_text': 'ýaz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_3, 'option_text': 'güýz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q17_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_2, 'question_order': 4,
      'question_text': 'запад', 'correct_answer': 'günbatar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_4, 'option_text': 'günbatar', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_4, 'option_text': 'ýyl pasly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_4, 'option_text': 'ýaz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_4, 'option_text': 'güýz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q17_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_2, 'question_order': 5,
      'question_text': 'восток', 'correct_answer': 'gündogar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_5, 'option_text': 'gündogar', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_5, 'option_text': 'ýyl pasly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_5, 'option_text': 'ýaz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_5, 'option_text': 'güýz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q17_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_2, 'question_order': 6,
      'question_text': 'холодно', 'correct_answer': 'sowuk(hal.)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_6, 'option_text': 'sowuk(hal.)', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_6, 'option_text': 'ýyl pasly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_6, 'option_text': 'ýaz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_6, 'option_text': 'güýz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q17_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e17_2, 'question_order': 7,
      'question_text': 'жарко', 'correct_answer': 'yssy(hal.)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_7, 'option_text': 'yssy(hal.)', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_7, 'option_text': 'ýyl pasly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_7, 'option_text': 'ýaz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q17_7, 'option_text': 'güýz', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 18 — Flash kart (sözler)
    final e18_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 31, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 0,
      'question_text': 'голова', 'correct_answer': 'baş',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 1,
      'question_text': 'ухо / уши', 'correct_answer': 'gulak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 2,
      'question_text': 'рука / руки', 'correct_answer': 'el',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 3,
      'question_text': 'нога / ноги', 'correct_answer': 'aýak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 4,
      'question_text': 'живот', 'correct_answer': 'garyn',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 5,
      'question_text': 'глаз / глаза', 'correct_answer': 'göz',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 6,
      'question_text': 'нос', 'correct_answer': 'burun',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 7,
      'question_text': 'рот', 'correct_answer': 'agyz',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 8,
      'question_text': 'горло', 'correct_answer': 'bokurdak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 9,
      'question_text': 'сердце', 'correct_answer': 'ýürek',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 10,
      'question_text': 'спина', 'correct_answer': 'arka',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 11,
      'question_text': 'палец / пальцы', 'correct_answer': 'barmak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 12,
      'question_text': 'лекарство', 'correct_answer': 'derman',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 13,
      'question_text': 'зубной врач', 'correct_answer': 'diş lukmany',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_1, 'question_order': 14,
      'question_text': 'медсестра', 'correct_answer': 'şepagat uýasy',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 18 — Köp saýlaw
    final e18_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 31, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q18_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_2, 'question_order': 0,
      'question_text': 'голова', 'correct_answer': 'baş',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_0, 'option_text': 'baş', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_0, 'option_text': 'gulak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_0, 'option_text': 'el', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_0, 'option_text': 'aýak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q18_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_2, 'question_order': 1,
      'question_text': 'ухо / уши', 'correct_answer': 'gulak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_1, 'option_text': 'gulak', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_1, 'option_text': 'baş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_1, 'option_text': 'el', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_1, 'option_text': 'aýak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q18_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_2, 'question_order': 2,
      'question_text': 'рука / руки', 'correct_answer': 'el',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_2, 'option_text': 'el', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_2, 'option_text': 'baş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_2, 'option_text': 'gulak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_2, 'option_text': 'aýak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q18_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_2, 'question_order': 3,
      'question_text': 'нога / ноги', 'correct_answer': 'aýak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_3, 'option_text': 'aýak', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_3, 'option_text': 'baş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_3, 'option_text': 'gulak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_3, 'option_text': 'el', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q18_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_2, 'question_order': 4,
      'question_text': 'живот', 'correct_answer': 'garyn',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_4, 'option_text': 'garyn', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_4, 'option_text': 'baş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_4, 'option_text': 'gulak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_4, 'option_text': 'el', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q18_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_2, 'question_order': 5,
      'question_text': 'глаз / глаза', 'correct_answer': 'göz',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_5, 'option_text': 'göz', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_5, 'option_text': 'baş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_5, 'option_text': 'gulak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_5, 'option_text': 'el', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q18_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_2, 'question_order': 6,
      'question_text': 'нос', 'correct_answer': 'burun',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_6, 'option_text': 'burun', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_6, 'option_text': 'baş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_6, 'option_text': 'gulak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_6, 'option_text': 'el', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q18_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e18_2, 'question_order': 7,
      'question_text': 'рот', 'correct_answer': 'agyz',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_7, 'option_text': 'agyz', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_7, 'option_text': 'baş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_7, 'option_text': 'gulak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q18_7, 'option_text': 'el', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 19 — Flash kart (sözler)
    final e19_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 32, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 0,
      'question_text': 'план', 'correct_answer': 'meýilnama',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 1,
      'question_text': 'отпуск', 'correct_answer': 'dynç alyş',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 2,
      'question_text': 'каникулы', 'correct_answer': 'okuw dynç alyş',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 3,
      'question_text': 'поезд', 'correct_answer': 'otly',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 4,
      'question_text': 'самолёт', 'correct_answer': 'uçar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 5,
      'question_text': 'аэропорт', 'correct_answer': 'howa menzili',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 6,
      'question_text': 'гостиница', 'correct_answer': 'myhmanhana',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 7,
      'question_text': 'вокзал', 'correct_answer': 'demir ýol menzili',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 8,
      'question_text': 'экскурсия', 'correct_answer': 'gezelenç',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 9,
      'question_text': 'бассейн', 'correct_answer': 'ýüzüjilik howuzy',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 10,
      'question_text': 'вовремя', 'correct_answer': 'wagtynda',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 11,
      'question_text': 'важный', 'correct_answer': 'möhüm',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 12,
      'question_text': 'весёлый/весело', 'correct_answer': 'şadyýan',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 13,
      'question_text': 'злой', 'correct_answer': 'gaharly',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_1, 'question_order': 14,
      'question_text': 'другой', 'correct_answer': 'başga',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 19 — Köp saýlaw
    final e19_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 32, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q19_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_2, 'question_order': 0,
      'question_text': 'план', 'correct_answer': 'meýilnama',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_0, 'option_text': 'meýilnama', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_0, 'option_text': 'dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_0, 'option_text': 'okuw dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_0, 'option_text': 'otly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q19_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_2, 'question_order': 1,
      'question_text': 'отпуск', 'correct_answer': 'dynç alyş',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_1, 'option_text': 'dynç alyş', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_1, 'option_text': 'meýilnama', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_1, 'option_text': 'okuw dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_1, 'option_text': 'otly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q19_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_2, 'question_order': 2,
      'question_text': 'каникулы', 'correct_answer': 'okuw dynç alyş',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_2, 'option_text': 'okuw dynç alyş', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_2, 'option_text': 'meýilnama', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_2, 'option_text': 'dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_2, 'option_text': 'otly', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q19_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_2, 'question_order': 3,
      'question_text': 'поезд', 'correct_answer': 'otly',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_3, 'option_text': 'otly', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_3, 'option_text': 'meýilnama', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_3, 'option_text': 'dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_3, 'option_text': 'okuw dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q19_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_2, 'question_order': 4,
      'question_text': 'самолёт', 'correct_answer': 'uçar',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_4, 'option_text': 'uçar', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_4, 'option_text': 'meýilnama', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_4, 'option_text': 'dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_4, 'option_text': 'okuw dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q19_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_2, 'question_order': 5,
      'question_text': 'аэропорт', 'correct_answer': 'howa menzili',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_5, 'option_text': 'howa menzili', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_5, 'option_text': 'meýilnama', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_5, 'option_text': 'dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_5, 'option_text': 'okuw dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q19_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_2, 'question_order': 6,
      'question_text': 'гостиница', 'correct_answer': 'myhmanhana',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_6, 'option_text': 'myhmanhana', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_6, 'option_text': 'meýilnama', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_6, 'option_text': 'dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_6, 'option_text': 'okuw dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q19_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e19_2, 'question_order': 7,
      'question_text': 'вокзал', 'correct_answer': 'demir ýol menzili',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_7, 'option_text': 'demir ýol menzili', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_7, 'option_text': 'meýilnama', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_7, 'option_text': 'dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q19_7, 'option_text': 'okuw dynç alyş', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 20 — Flash kart (sözler)
    final e20_1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 33, 'exercise_number': 1,
      'title_tk': 'Sözler — Flash kart',
      'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 0,
      'question_text': 'столик', 'correct_answer': 'stol(restoranda)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 1,
      'question_text': 'закуска', 'correct_answer': 'mezze',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 2,
      'question_text': 'напиток/напитки', 'correct_answer': 'içgi',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 3,
      'question_text': 'тарелка', 'correct_answer': 'tabak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 4,
      'question_text': 'вилка', 'correct_answer': 'çäňňe',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 5,
      'question_text': 'ложка', 'correct_answer': 'çemçe',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 6,
      'question_text': 'стакан', 'correct_answer': 'bulgur',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 7,
      'question_text': 'чашка', 'correct_answer': 'käse',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 8,
      'question_text': 'нож', 'correct_answer': 'pyçak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 9,
      'question_text': 'салфетка', 'correct_answer': 'salfetka',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 10,
      'question_text': 'блюдо', 'correct_answer': 'nahar,tagam',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 11,
      'question_text': 'сахар', 'correct_answer': 'şeker',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 12,
      'question_text': 'мороженое', 'correct_answer': 'doňdurma',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 13,
      'question_text': 'гриб', 'correct_answer': 'kömelek',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_1, 'question_order': 14,
      'question_text': 'яблоко', 'correct_answer': 'alma',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    // Sapak 20 — Köp saýlaw
    final e20_2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': 33, 'exercise_number': 2,
      'title_tk': 'Sözler — Dogry terjimäni saýla',
      'instruction_tk': 'Rusça sözüň dogry türkmen manysyny saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q20_0 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_2, 'question_order': 0,
      'question_text': 'столик', 'correct_answer': 'stol(restoranda)',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_0, 'option_text': 'stol(restoranda)', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_0, 'option_text': 'mezze', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_0, 'option_text': 'içgi', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_0, 'option_text': 'tabak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q20_1 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_2, 'question_order': 1,
      'question_text': 'закуска', 'correct_answer': 'mezze',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_1, 'option_text': 'mezze', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_1, 'option_text': 'stol(restoranda)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_1, 'option_text': 'içgi', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_1, 'option_text': 'tabak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q20_2 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_2, 'question_order': 2,
      'question_text': 'напиток/напитки', 'correct_answer': 'içgi',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_2, 'option_text': 'içgi', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_2, 'option_text': 'stol(restoranda)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_2, 'option_text': 'mezze', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_2, 'option_text': 'tabak', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q20_3 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_2, 'question_order': 3,
      'question_text': 'тарелка', 'correct_answer': 'tabak',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_3, 'option_text': 'tabak', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_3, 'option_text': 'stol(restoranda)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_3, 'option_text': 'mezze', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_3, 'option_text': 'içgi', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q20_4 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_2, 'question_order': 4,
      'question_text': 'вилка', 'correct_answer': 'çäňňe',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_4, 'option_text': 'çäňňe', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_4, 'option_text': 'stol(restoranda)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_4, 'option_text': 'mezze', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_4, 'option_text': 'içgi', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q20_5 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_2, 'question_order': 5,
      'question_text': 'ложка', 'correct_answer': 'çemçe',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_5, 'option_text': 'çemçe', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_5, 'option_text': 'stol(restoranda)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_5, 'option_text': 'mezze', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_5, 'option_text': 'içgi', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q20_6 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_2, 'question_order': 6,
      'question_text': 'стакан', 'correct_answer': 'bulgur',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_6, 'option_text': 'bulgur', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_6, 'option_text': 'stol(restoranda)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_6, 'option_text': 'mezze', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_6, 'option_text': 'içgi', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final q20_7 = await txn.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': e20_2, 'question_order': 7,
      'question_text': 'чашка', 'correct_answer': 'käse',
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_7, 'option_text': 'käse', 'is_correct': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_7, 'option_text': 'stol(restoranda)', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_7, 'option_text': 'mezze', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseOptions, {
      'question_id': q20_7, 'option_text': 'içgi', 'is_correct': 0,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // ── BAŞLANGYÇ ÖSÜŞ ───────────────────────────────────
  static Future<void> _seedLessonProgress(Transaction txn) async {
    for (int i = 24; i <= 33; i++) {
      await txn.insert(DbConstants.tLessonProgress, {
        'lesson_id': i, 'vocab_studied': 0, 'dialogs_read': 0,
        'exercises_done': 0, 'exercises_total': 2,
        'score_percent': 0.0, 'is_completed': 0,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }


  // ── OKUW TEKSTLERI ───────────────────────────────────
  static Future<void> _seedReadingTexts(Transaction txn) async {
    final texts = [
      {
        'lesson_id': 24,
        'title_ru': 'Оптимист и пессимист',
        'content_ru': 'У меня есть друг. Его зовут Merdan. Он живёт в Ашхабаде. Merdan — оптимист. У него есть большой и хороший дом. У него есть жена и дети. Его дети очень умные. Его жена Ogulgerek — преподаватель. У неё есть хорошие студенты. Merdan работает на заводе. У него отличная работа. У них есть хобби — театр и кино. У них интересная жизнь. А это мой друг Serdar. Он тоже живёт в Ашхабаде. Он пессимист. У него есть маленький и некрасивый дом. Его жена — юрист. Она говорит, что это очень скучная работа. Serdar работает в банке. Он говорит, что у него очень трудная работа, потому что все его коллеги глупые. Их хобби — смотреть телевизор. Они говорят, что в мире всё плохо. У них скучная жизнь.',
      },
      {
        'lesson_id': 25,
        'title_ru': 'Моя жена — повар',
        'content_ru': 'Здравствуйте. Меня зовут Serdar. А это моя жена Aýna. Мы живём в Ашхабаде. По профессии Aýna — повар. Она отлично готовит. Aýna работает в ресторане «Ашхабад». Наши любимые продукты — это овощи, фрукты и рыба. Мы не очень любим мясо, поэтому покупаем его редко. В субботу мы покупаем все продукты на рынке, потому что там продукты очень хорошие и недорогие. На завтрак мы обычно едим кашу. Aýna всегда пьёт чёрный кофе, а я пью зелёный чай. Иногда мы делаем бутерброды. Мой любимый бутерброд — хлеб, колбаса и сыр. На обед Aýna всегда готовит вкусный салат, рыбу или курицу. На ужин мы часто едим суп. Мой любимый суп — шурпа.',
      },
      {
        'lesson_id': 26,
        'title_ru': 'Модная одежда',
        'content_ru': 'Какую одежду вы любите? Модную или удобную? Меня зовут Sona и я ношу только модную одежду! По национальности я туркменка, но сейчас я живу в Москве. Сегодня я иду в магазин. Я хочу новое красивое пальто. Сейчас в Москве уже зима, а моё старое пальто уже не модное. Магазин очень большой. Ах, какие красивые туфли! Сколько они стоят? Какие дорогие! Но очень красивые. «Сначала туфли, а потом пальто», — думаю я и покупаю туфли. А что это? Это платье или юбка? «Это очень модная длинная юбка», — говорит продавец. — «Сейчас все носят длинные юбки». Как я хочу эту юбку! Поэтому я покупаю юбку тоже. А потом ещё шарф, шапку, шорты и джинсы. Который час? Уже слишком поздно! Я была в магазине 3 часа! Пора идти домой. Ой, а пальто!?',
      },
      {
        'lesson_id': 27,
        'title_ru': 'Моя квартира',
        'content_ru': 'Привет! Меня зовут Döwlet. А это моя квартира. Добро пожаловать! Моя квартира небольшая, но очень уютная. В квартире есть кухня, гостиная, спальня и ванная. Вот кухня. Здесь стоит плита, стол, стулья и холодильник. В холодильнике лежат продукты: молоко, овощи, мясо, и конечно, колбаса. Я не люблю готовить. Поэтому я всегда покупаю колбасу и делаю бутерброды. Моя любимая комната — это гостиная. Здесь стоит большой телевизор и очень удобный диван. А ещё на стене в гостиной висят красивые и дорогие картины. А это моя спальня. Здесь стоит кровать и шкаф. В шкафу лежит моя одежда. На стене висят старые красивые часы. А кто это спит на кровати? Это моя собака Alajar. Он тоже любит лежать на диване и есть колбасу.',
      },
      {
        'lesson_id': 28,
        'title_ru': 'Мой родной город',
        'content_ru': 'Здравствуйте. Меня зовут Röwşen. Я живу в Ашхабаде. Ашхабад — мой родной и любимый город. Здесь есть красивые проспекты, театры и парки. В центре есть красивые площади. Я очень люблю гулять в центре в выходные. А вот мой район. Здесь есть супермаркет, аптека, небольшой парк и мечеть. Это большое белое здание — мой дом. Недалеко есть остановка автобуса. Автобус номер 10 идёт в центр. — Извините, — говорит один турист, — Вы знаете, где находится главная мечеть? — Конечно! Это близко. Идите прямо, а потом направо. Видите эти белые стены? Это мечеть. — Большое спасибо! Ах, какой красивый город, Ашхабад! — думаю я.',
      },
      {
        'lesson_id': 29,
        'title_ru': 'Мой день рождения',
        'content_ru': 'Здравствуйте. Меня зовут Kemal. По национальности я туркмен. Но я живу в Москве уже 3 года. Мне очень нравится моя жизнь в Москве. А сегодня мой день рождения! Мне уже 29 лет. Сегодня мы готовим вкусный ужин у меня дома. Мои друзья Röwşen и Myrat приходят и говорят: «С днём рождения!» А что это? Это новая гитара! Какой хороший подарок! Мои друзья знают, что мне очень нравится музыка. Я играю на гитаре и на скрипке. «У меня тоже есть подарок!» — говорит Mähri. — «Это книга «Война и мир». Я знаю, что тебе нравится русская классика». «Большое спасибо, дорогие друзья!» — говорю я — «Давайте ужинать!» Мы едим и пьём. А вечером мы идём на дискотеку. Нам нравится танцевать и слушать музыку. Как хорошо, когда день рождения!',
      },
      {
        'lesson_id': 30,
        'title_ru': 'Погода в Ашхабаде',
        'content_ru': 'Наверное, вы думаете, что в Туркменистане всегда жарко. Меня зовут Жан. Я француз. Я живу в Ашхабаде уже 4 года. Раньше я думал, что в Туркменистане всегда жарко. Конечно, это не правда. Лето в Ашхабаде очень жаркое и длинное. В мае здесь уже жарко — 30 градусов. Мои любимые месяцы — декабрь, январь и февраль — плюс 5–10 градусов. В выходные я часто катаюсь на велосипеде. Обычно я катаюсь один, потому что все мои друзья предпочитают отдыхать дома. — Почему ты хочешь идти на улицу? — спрашивают они. — Потому что дома скучно! — отвечаю я. Осенью в Ашхабаде очень красиво. Деревья жёлтые, красные, оранжевые. Я часто гуляю в парке и фотографирую.',
      },
      {
        'lesson_id': 31,
        'title_ru': 'Маленький Kemal болеет',
        'content_ru': 'Сегодня Kemal не идёт в школу. Он болеет. У него болит ухо, горло и голова. — Наверное, это простуда, — говорит мама. — Мы должны идти в больницу. Мама и Kemal идут в больницу. Врач смотрит горло и уши. — У него есть температура? — Да, 37.7. Утром он принимал аспирин. — Я думаю, что это грипп. Kemal должен принимать это лекарство три раза в день: утром, днём и вечером. Выздоравливай, Kemal! Мама и Kemal идут в аптеку и покупают лекарство. Дома Kemal лежит на диване и смотрит телевизор. «Как хорошо болеть!» — думает Kemal. — «Сейчас все мои друзья в школе делают скучные упражнения. А я могу лежать на диване и есть фрукты!»',
      },
      {
        'lesson_id': 32,
        'title_ru': 'Что будем делать летом?',
        'content_ru': 'Это Ogulgerek и Merdan. Они муж и жена. Ogulgerek очень любит путешествовать, а Merdan не очень. — Что мы будем делать летом? — спрашивает Ogulgerek. — В июле у нас будет отпуск. Мы должны покупать билеты сейчас! — Какие билеты? Куда мы едем? — Ты не помнишь? Летом мы хотели ехать на юг! Мы будем отдыхать на пляже. Смотри, вот очень хорошая гостиница. Здесь у нас будет завтрак, обед, ужин и экскурсии. А ещё в гостинице есть бассейн! — И сколько стоит эта гостиница? Какая дорогая! Зачём ехать на юг, когда мы можем отдыхать на даче? Там есть озеро. Там я буду ловить рыбу и пить пиво. Но Ogulgerek не хочет ехать на дачу... — Ты будешь ловить рыбу, а я что буду делать? На юге я буду носить красивые платья, плавать в море и всё фотографировать. — А что если будет холодная погода? — А что если ты один будешь на даче, а я на юге? Merdan видит, что Ogulgerek уже злая. — Ладно, едем на юг вместе, — говорит он.',
      },
      {
        'lesson_id': 33,
        'title_ru': 'В ресторане',
        'content_ru': 'Здравствуйте! Меня зовут Röwşen. Я туркмен. Конечно, я очень люблю туркменскую кухню. Моё любимое туркменское блюдо — это плов. Но сейчас я живу в России. Здесь я обычно ем русскую еду. Мне нравятся русские супы и пирожки. Моё любимое русское блюдо — это борщ. Сегодня я и мои друзья идём в ресторан. Ресторан дорогой и очень красивый. — Здравствуйте! Вы заказывали столик? — спрашивает официант. — Да, мы заказывали столик на 8 часов, — отвечает мой друг Merdan. — Фамилия — Çaryýew. На столе уже стоят тарелки и стаканы, лежат вилки, ложки и ножи. Сначала мы заказываем вино и закуску. На первое мы всегда заказываем суп. А на второе я заказываю блины с икрой. Это очень популярное русское блюдо. На десерт официант рекомендует нам мороженое. Я заказываю мороженое с шоколадом и кофе с молоком. Как всё вкусно! А сейчас пора идти домой. Официант даёт нам счёт, а мы даём ему деньги и чаевые. Как мне нравится ужинать в ресторане с друзьями!',
      },
    ];
    for (final t in texts) {
      await txn.insert(DbConstants.tReadingTexts, t,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  static Future<void> _insertLines(
      Transaction txn, int dialogId, List<List<String>> lines) async {
    for (int i = 0; i < lines.length; i++) {
      await txn.insert(DbConstants.tDialogLines, {
        'dialog_id': dialogId, 'line_order': i,
        'speaker': lines[i][0],
        'text_ru': lines[i][1],
        'text_tk': lines[i][2],
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }
}