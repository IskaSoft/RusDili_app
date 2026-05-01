import 'package:sqflite/sqflite.dart';
import '../../core/constants/db_constants.dart';

/// Seeds the database with all lesson data from the A1 Russian textbook
class DatabaseSeeder {
  static Future<void> seed(Database db) async {
    await _seedLessons(db);
    await _seedVocabulary(db);
    await _seedDialogs(db);
    await _seedGrammarRules(db);
    await _seedExercises(db);
    await _seedReadingTexts(db);
    await _seedLessonProgress(db);
  }

  // ─────────────────────────────────────────────────────────
  // LESSONS
  // ─────────────────────────────────────────────────────────
  static Future<void> _seedLessons(Database db) async {
    final lessons = [
      {
        'id': 1, 'sapak_number': 1,
        'title_ru': 'Привет, Студент!',
        'title_tk': 'Salam, Talyplar!',
        'subtitle_tk': 'Salam Berme we Tanyşma',
        'description_tk': 'Bu sapakda salam bermegiň, hoşlaşmagyň we özüňi tanatmagyň ýollaryny öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s01_greetings.png',
        'order_index': 1,
      },
      {
        'id': 2, 'sapak_number': 2,
        'title_ru': 'Это мой друг',
        'title_tk': 'Bu meniň dostumdur',
        'subtitle_tk': 'Resmi tanyşma · Sözleriň jynsy · Eýelik çalyşmalary',
        'description_tk': 'Resmi tanyşma, sözleriň jynsy we eýelik çalyşmalaryny öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s02_friends.png',
        'order_index': 2,
      },
      {
        'id': 3, 'sapak_number': 3,
        'title_ru': 'Семья',
        'title_tk': 'Maşgala',
        'subtitle_tk': 'Maşgala agzalary · его/её/их · Okuw teksti',
        'description_tk': 'Maşgala agzalarynyň atlaryny we его/её/их çalyşmalaryny öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s03_family.png',
        'order_index': 3,
      },
      {
        'id': 4, 'sapak_number': 4,
        'title_ru': 'Профессия',
        'title_tk': 'Hünär',
        'subtitle_tk': 'Hünärler · Iş ýerleri · Köplük sany · Предложный падёж',
        'description_tk': 'Hünärleri, iş ýerlerini we предложный падёж öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s04_profession.png',
        'order_index': 4,
      },
      {
        'id': 5, 'sapak_number': 5,
        'title_ru': 'Я Русский, а Вы?',
        'title_tk': 'Milliýet we Ýer',
        'subtitle_tk': 'Milliýetler · Sypat goşulmalary · жить · Geçen zaman',
        'description_tk': 'Milliýetler, sypatlaryň goşulmalary we жить işligini öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s05_nationality.png',
        'order_index': 5,
      },
      {
        'id': 6, 'sapak_number': 6,
        'title_ru': 'Язык',
        'title_tk': 'Dil',
        'subtitle_tk': 'Diller · Dil ukyplary · мочь · учиться vs изучать',
        'description_tk': 'Diller barada gürrüň bermegi we täze işlikleri öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s06_language.png',
        'order_index': 6,
      },
      {
        'id': 7, 'sapak_number': 7,
        'title_ru': 'Что ты делаешь?',
        'title_tk': 'Sen Näme Edýärsiň?',
        'subtitle_tk': 'Gündelik işler · -ать/-ять/-ить/-еть işlikleri',
        'description_tk': 'Gündelik işleri we işlikleriň spryaženiýasyny öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s07_daily.png',
        'order_index': 7,
      },
      {
        'id': 8, 'sapak_number': 8,
        'title_ru': 'Трудный Урок',
        'title_tk': 'Kynçylykly Sapak',
        'subtitle_tk': 'Garşylykly sypatlary · Köplük sany · Gykylyma sözlemler',
        'description_tk': 'Garşylykly sypatlary we gykylyma sözlemleri öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s08_adjectives.png',
        'order_index': 8,
      },
      {
        'id': 9, 'sapak_number': 9,
        'title_ru': 'Дни Недели и Время',
        'title_tk': 'Hepde Günleri we Wagt',
        'subtitle_tk': 'Hepde günleri · Sagat aýtmak · Nahar işlikleri',
        'description_tk': 'Hepde günlerini, sagat aýtmagy we nahar işliklerini öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s09_time.png',
        'order_index': 9,
      },
      {
        'id': 10, 'sapak_number': 10,
        'title_ru': 'Мой День',
        'title_tk': 'Meniň Günüm',
        'subtitle_tk': 'Gündelik tertip · Куда? vs Где? · Творительный падёж',
        'description_tk': 'Gündelik tertip we Куда? vs Где? tapawudyny öwrenersiňiz.',
        'image_path': 'assets/images/lessons/s10_myday.png',
        'order_index': 10,
      },
    ];

    for (final lesson in lessons) {
      await db.insert(DbConstants.tLessons, lesson,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ─────────────────────────────────────────────────────────
  // VOCABULARY
  // ─────────────────────────────────────────────────────────
  static Future<void> _seedVocabulary(Database db) async {
    final vocab = [
      // SAPAK 1
      {'lesson_id': 1, 'word_ru': 'Привет!', 'word_tk': 'Salam! (resmi däl)', 'example_ru': 'Привет, Merdan!', 'example_tk': 'Salam, Merdan!', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'Добрый день!', 'word_tk': 'Günüň haýyrly!', 'example_ru': 'Добрый день, Aýna!', 'example_tk': 'Günüň haýyrly, Aýna!', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'Доброе утро!', 'word_tk': 'Ertiriň haýyrly!', 'example_ru': 'Доброе утро!', 'example_tk': 'Ertiriň haýyrly!', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'Добрый вечер!', 'word_tk': 'Agşamyň haýyrly!', 'example_ru': 'Добрый вечер!', 'example_tk': 'Agşamyň haýyrly!', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'Как дела?', 'word_tk': 'Işleriň nähili?', 'example_ru': 'Как дела? — Хорошо!', 'example_tk': 'Işleriň nähili? — Gowy!', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'хорошо', 'word_tk': 'gowy', 'example_ru': 'Спасибо, хорошо.', 'example_tk': 'Sag bol, gowy.', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'отлично', 'word_tk': 'ajaýyp, gaty gowy', 'example_ru': 'Спасибо, отлично!', 'example_tk': 'Sag bol, ajaýyp!', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'нормально', 'word_tk': 'kadaly, bolýar', 'example_ru': 'Нормально, спасибо.', 'example_tk': 'Bolýar, sag bol.', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'плохо', 'word_tk': 'erbet', 'example_ru': 'Сегодня плохо.', 'example_tk': 'Bu gün erbet.', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'тоже', 'word_tk': 'hem, hem-de', 'example_ru': 'Тоже хорошо.', 'example_tk': 'Hem gowy.', 'category': 'basic'},
      {'lesson_id': 1, 'word_ru': 'спасибо', 'word_tk': 'sag boluň / sag bol', 'example_ru': 'Спасибо!', 'example_tk': 'Sag boluň!', 'category': 'basic'},
      {'lesson_id': 1, 'word_ru': 'пока', 'word_tk': 'hoş gal (resmi däl)', 'example_ru': 'Пока! — Пока!', 'example_tk': 'Hoş gal! — Hoş gal!', 'category': 'greeting'},
      {'lesson_id': 1, 'word_ru': 'Меня зовут…', 'word_tk': 'Meniň adym…', 'example_ru': 'Меня зовут Merdan.', 'example_tk': 'Meniň adym Merdan.', 'category': 'identity'},
      {'lesson_id': 1, 'word_ru': 'Как вас зовут?', 'word_tk': 'Adyňyz näme?', 'example_ru': 'Как вас зовут?', 'example_tk': 'Adyňyz näme?', 'category': 'identity'},
      {'lesson_id': 1, 'word_ru': 'студент', 'word_tk': 'talyp (erkek)', 'example_ru': 'Я студент.', 'example_tk': 'Men talybam.', 'category': 'identity'},
      {'lesson_id': 1, 'word_ru': 'студентка', 'word_tk': 'talyp (aýal)', 'example_ru': 'Я студентка.', 'example_tk': 'Men talybam.', 'category': 'identity'},
      {'lesson_id': 1, 'word_ru': 'очень', 'word_tk': 'örän, gaty', 'example_ru': 'Очень приятно!', 'example_tk': 'Örän begenýärin!', 'category': 'basic'},

      // SAPAK 2
      {'lesson_id': 2, 'word_ru': 'Здравствуйте!', 'word_tk': 'Salam! (resmi)', 'example_ru': 'Здравствуйте! Я Aýna.', 'example_tk': 'Salam! Men Aýna.', 'category': 'greeting'},
      {'lesson_id': 2, 'word_ru': 'фамилия', 'word_tk': 'familiýa', 'example_ru': 'Моя фамилия Amanow.', 'example_tk': 'Meniň familiýam Amanow.', 'category': 'identity'},
      {'lesson_id': 2, 'word_ru': 'отчество', 'word_tk': 'atasynyň ady', 'example_ru': 'Моё отчество Serdarowiç.', 'example_tk': 'Meniň otçeswom Serdarowiç.', 'category': 'identity'},
      {'lesson_id': 2, 'word_ru': 'очень приятно', 'word_tk': 'tanyşanymyza begenýärin', 'example_ru': 'Очень приятно!', 'example_tk': 'Tanyşanymyza begenýärin!', 'category': 'greeting'},
      {'lesson_id': 2, 'word_ru': 'друг', 'word_tk': 'dost (erkek)', 'example_ru': 'Это мой друг.', 'example_tk': 'Bu meniň dostum.', 'category': 'people', 'image_path': 'assets/images/vocabulary/vocab_friend.png'},
      {'lesson_id': 2, 'word_ru': 'подруга', 'word_tk': 'dost (aýal)', 'example_ru': 'Это моя подруга.', 'example_tk': 'Bu meniň dostum.', 'category': 'people'},
      {'lesson_id': 2, 'word_ru': 'книга', 'word_tk': 'kitap', 'example_ru': 'Это моя книга.', 'example_tk': 'Bu meniň kitabym.', 'category': 'objects', 'image_path': 'assets/images/vocabulary/vocab_book.png'},
      {'lesson_id': 2, 'word_ru': 'преподаватель', 'word_tk': 'mugallym', 'example_ru': 'Он преподаватель.', 'example_tk': 'Ol mugallym.', 'category': 'people'},
      {'lesson_id': 2, 'word_ru': 'до свидания', 'word_tk': 'hoş gal (resmi)', 'example_ru': 'До свидания!', 'example_tk': 'Hoş gal!', 'category': 'greeting'},
      {'lesson_id': 2, 'word_ru': 'пожалуйста', 'word_tk': 'haýyş; gerek bolsa', 'example_ru': 'Пожалуйста!', 'example_tk': 'Haýyş!', 'category': 'basic'},
      {'lesson_id': 2, 'word_ru': 'извините', 'word_tk': 'bagyşlaweriň', 'example_ru': 'Извините!', 'example_tk': 'Bagyşlaweriň!', 'category': 'basic'},
      {'lesson_id': 2, 'word_ru': 'можно?', 'word_tk': 'rugsat barmy?', 'example_ru': 'Можно вопрос?', 'example_tk': 'Bir sorag soraýsammydym?', 'category': 'basic'},

      // SAPAK 3
      {'lesson_id': 3, 'word_ru': 'семья', 'word_tk': 'maşgala', 'example_ru': 'Это моя семья.', 'example_tk': 'Bu meniň maşgalam.', 'category': 'family', 'image_path': 'assets/images/vocabulary/vocab_family.png'},
      {'lesson_id': 3, 'word_ru': 'отец / папа', 'word_tk': 'kaka', 'example_ru': 'Это мой отец.', 'example_tk': 'Bu meniň kakam.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'мать / мама', 'word_tk': 'ene', 'example_ru': 'Это моя мать.', 'example_tk': 'Bu meniň enem.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'брат', 'word_tk': 'dogany (erkek)', 'example_ru': 'Мой брат Merdan.', 'example_tk': 'Meniň dogany Merdan.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'сестра', 'word_tk': 'dogany (aýal)', 'example_ru': 'Моя сестра Gülnar.', 'example_tk': 'Meniň aýal dogany Gülnar.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'муж', 'word_tk': 'är', 'example_ru': 'Это мой муж.', 'example_tk': 'Bu meniň ärim.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'жена', 'word_tk': 'aýal', 'example_ru': 'Это моя жена.', 'example_tk': 'Bu meniň aýalym.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'сын', 'word_tk': 'ogul', 'example_ru': 'Мой сын Döwlet.', 'example_tk': 'Meniň oglum Döwlet.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'дочь', 'word_tk': 'gyz', 'example_ru': 'Моя дочь Jeren.', 'example_tk': 'Meniň gyzym Jeren.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'дедушка', 'word_tk': 'ata-ata', 'example_ru': 'Мой дедушка.', 'example_tk': 'Meniň atam.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'бабушка', 'word_tk': 'ene-ene', 'example_ru': 'Моя бабушка.', 'example_tk': 'Meniň enem.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'тётя', 'word_tk': 'daýza', 'example_ru': 'Моя тётя.', 'example_tk': 'Meniň daýzam.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'дядя', 'word_tk': 'daýy', 'example_ru': 'Мой дядя.', 'example_tk': 'Meniň daýym.', 'category': 'family'},
      {'lesson_id': 3, 'word_ru': 'собака', 'word_tk': 'köpek', 'example_ru': 'Наша собака.', 'example_tk': 'Biziň köpegimiz.', 'category': 'animals', 'image_path': 'assets/images/vocabulary/vocab_dog.png'},
      {'lesson_id': 3, 'word_ru': 'кошка', 'word_tk': 'pişik', 'example_ru': 'Наша кошка.', 'example_tk': 'Biziň pişigimiz.', 'category': 'animals', 'image_path': 'assets/images/vocabulary/vocab_cat.png'},

      // SAPAK 4
      {'lesson_id': 4, 'word_ru': 'врач', 'word_tk': 'lukman', 'example_ru': 'Она врач.', 'example_tk': 'Ol lukman.', 'category': 'profession', 'image_path': 'assets/images/vocabulary/vocab_doctor.png'},
      {'lesson_id': 4, 'word_ru': 'учитель', 'word_tk': 'mugallym', 'example_ru': 'Он учитель.', 'example_tk': 'Ol mugallym.', 'category': 'profession'},
      {'lesson_id': 4, 'word_ru': 'инженер', 'word_tk': 'inžener', 'example_ru': 'Мой отец инженер.', 'example_tk': 'Meniň kakam inžener.', 'category': 'profession'},
      {'lesson_id': 4, 'word_ru': 'переводчик', 'word_tk': 'terjimeçi', 'example_ru': 'Aýna переводчик.', 'example_tk': 'Aýna terjimeçi.', 'category': 'profession'},
      {'lesson_id': 4, 'word_ru': 'журналист', 'word_tk': 'žurnalist', 'example_ru': 'Он журналист.', 'example_tk': 'Ol žurnalist.', 'category': 'profession'},
      {'lesson_id': 4, 'word_ru': 'повар', 'word_tk': 'aşpez', 'example_ru': 'Я повар.', 'example_tk': 'Men aşpez.', 'category': 'profession', 'image_path': 'assets/images/vocabulary/vocab_cook.png'},
      {'lesson_id': 4, 'word_ru': 'продавец', 'word_tk': 'satyjy', 'example_ru': 'Он продавец.', 'example_tk': 'Ol satyjy.', 'category': 'profession'},
      {'lesson_id': 4, 'word_ru': 'работать', 'word_tk': 'işlemek', 'example_ru': 'Я работаю в банке.', 'example_tk': 'Men bankda işleýärin.', 'category': 'verbs'},
      {'lesson_id': 4, 'word_ru': 'учиться', 'word_tk': 'okamak', 'example_ru': 'Я учусь в университете.', 'example_tk': 'Men uniwersitetde okaýaryn.', 'category': 'verbs'},
      {'lesson_id': 4, 'word_ru': 'университет', 'word_tk': 'uniwersitet', 'example_ru': 'в университете', 'example_tk': 'uniwersitetde', 'category': 'places'},
      {'lesson_id': 4, 'word_ru': 'школа', 'word_tk': 'mekdep', 'example_ru': 'в школе', 'example_tk': 'mekdepde', 'category': 'places'},
      {'lesson_id': 4, 'word_ru': 'больница', 'word_tk': 'hassahana', 'example_ru': 'в больнице', 'example_tk': 'hassahanada', 'category': 'places', 'image_path': 'assets/images/vocabulary/vocab_hospital.png'},
      {'lesson_id': 4, 'word_ru': 'банк', 'word_tk': 'bank', 'example_ru': 'в банке', 'example_tk': 'bankda', 'category': 'places'},
      {'lesson_id': 4, 'word_ru': 'магазин', 'word_tk': 'dükan', 'example_ru': 'в магазине', 'example_tk': 'dükanda', 'category': 'places'},
      {'lesson_id': 4, 'word_ru': 'завод', 'word_tk': 'zawod', 'example_ru': 'на заводе', 'example_tk': 'zawodda', 'category': 'places'},
      {'lesson_id': 4, 'word_ru': 'почта', 'word_tk': 'poçta', 'example_ru': 'на почте', 'example_tk': 'poçtada', 'category': 'places'},
      {'lesson_id': 4, 'word_ru': 'посольство', 'word_tk': 'ilçihana', 'example_ru': 'в посольстве', 'example_tk': 'ilçihanada', 'category': 'places'},
      {'lesson_id': 4, 'word_ru': 'ресторан', 'word_tk': 'restoran', 'example_ru': 'в ресторане', 'example_tk': 'restoraňda', 'category': 'places'},
      {'lesson_id': 4, 'word_ru': 'музей', 'word_tk': 'muzeý', 'example_ru': 'в музее', 'example_tk': 'muzeýde', 'category': 'places'},

      // SAPAK 5
      {'lesson_id': 5, 'word_ru': 'национальность', 'word_tk': 'milliýet', 'example_ru': 'Какая ваша национальность?', 'example_tk': 'Siziň milliýetiňiz näme?', 'category': 'identity'},
      {'lesson_id': 5, 'word_ru': 'русский/русская', 'word_tk': 'rus', 'example_ru': 'Он русский.', 'example_tk': 'Ol rus.', 'category': 'nationality'},
      {'lesson_id': 5, 'word_ru': 'туркмен/туркменка', 'word_tk': 'türkmen', 'example_ru': 'Я туркменка.', 'example_tk': 'Men türkmen aýaly.', 'category': 'nationality'},
      {'lesson_id': 5, 'word_ru': 'американец/американка', 'word_tk': 'amerikan', 'example_ru': 'Он американец.', 'example_tk': 'Ol amerikan.', 'category': 'nationality'},
      {'lesson_id': 5, 'word_ru': 'англичанин/англичанка', 'word_tk': 'iňlis', 'example_ru': 'Она англичанка.', 'example_tk': 'Ol iňlis aýaly.', 'category': 'nationality'},
      {'lesson_id': 5, 'word_ru': 'немец/немка', 'word_tk': 'nemes', 'example_ru': 'Он немец.', 'example_tk': 'Ol nemes.', 'category': 'nationality'},
      {'lesson_id': 5, 'word_ru': 'жить', 'word_tk': 'ýaşamak', 'example_ru': 'Я живу в Ашхабаде.', 'example_tk': 'Men Aşgabatda ýaşaýaryn.', 'category': 'verbs'},
      {'lesson_id': 5, 'word_ru': 'сейчас', 'word_tk': 'häzir', 'example_ru': 'Сейчас я живу...', 'example_tk': 'Häzir men...', 'category': 'time'},
      {'lesson_id': 5, 'word_ru': 'раньше', 'word_tk': 'öň, ozal', 'example_ru': 'Раньше я жил...', 'example_tk': 'Öň men ýaşardym...', 'category': 'time'},
      {'lesson_id': 5, 'word_ru': 'большой', 'word_tk': 'uly', 'example_ru': 'Это большой город.', 'example_tk': 'Bu uly şäher.', 'category': 'adjectives'},
      {'lesson_id': 5, 'word_ru': 'красивый', 'word_tk': 'owadan', 'example_ru': 'Красивый город!', 'example_tk': 'Owadan şäher!', 'category': 'adjectives'},
      {'lesson_id': 5, 'word_ru': 'новый', 'word_tk': 'täze', 'example_ru': 'Новый дом.', 'example_tk': 'Täze öý.', 'category': 'adjectives'},
      {'lesson_id': 5, 'word_ru': 'старый', 'word_tk': 'gadymy, garry', 'example_ru': 'Старый город.', 'example_tk': 'Gadymy şäher.', 'category': 'adjectives'},
      {'lesson_id': 5, 'word_ru': 'маленький', 'word_tk': 'kiçi', 'example_ru': 'Маленький дом.', 'example_tk': 'Kiçi öý.', 'category': 'adjectives'},

      // SAPAK 6
      {'lesson_id': 6, 'word_ru': 'язык', 'word_tk': 'dil', 'example_ru': 'Я изучаю русский язык.', 'example_tk': 'Men rusça öwrenýärin.', 'category': 'language'},
      {'lesson_id': 6, 'word_ru': 'говорить', 'word_tk': 'gürlemek', 'example_ru': 'Я говорю по-русски.', 'example_tk': 'Men rusça gepleşýärin.', 'category': 'verbs'},
      {'lesson_id': 6, 'word_ru': 'читать', 'word_tk': 'okamak', 'example_ru': 'Я читаю книгу.', 'example_tk': 'Men kitap okaýaryn.', 'category': 'verbs'},
      {'lesson_id': 6, 'word_ru': 'писать', 'word_tk': 'ýazmak', 'example_ru': 'Я пишу письмо.', 'example_tk': 'Men hat ýazýaryn.', 'category': 'verbs'},
      {'lesson_id': 6, 'word_ru': 'понимать', 'word_tk': 'düşünmek', 'example_ru': 'Я понимаю.', 'example_tk': 'Men düşünýärin.', 'category': 'verbs'},
      {'lesson_id': 6, 'word_ru': 'изучать', 'word_tk': 'öwrenmek (dili)', 'example_ru': 'Я изучаю русский язык.', 'example_tk': 'Men rusça öwrenýärin.', 'category': 'verbs'},
      {'lesson_id': 6, 'word_ru': 'думать', 'word_tk': 'pikir etmek', 'example_ru': 'Я думаю.', 'example_tk': 'Men pikir edýärin.', 'category': 'verbs'},
      {'lesson_id': 6, 'word_ru': 'мочь', 'word_tk': 'bilmek', 'example_ru': 'Я могу говорить.', 'example_tk': 'Men gürläp bilýärin.', 'category': 'verbs'},
      {'lesson_id': 6, 'word_ru': 'по-русски', 'word_tk': 'rusça', 'example_ru': 'Говорите по-русски?', 'example_tk': 'Rusça gepleşýärsiňizmi?', 'category': 'language'},
      {'lesson_id': 6, 'word_ru': 'по-английски', 'word_tk': 'iňlisçe', 'example_ru': 'Говорите по-английски?', 'example_tk': 'Iňlisçe gepleşýärsiňizmi?', 'category': 'language'},
      {'lesson_id': 6, 'word_ru': 'конечно', 'word_tk': 'elbetde', 'example_ru': 'Конечно!', 'example_tk': 'Elbetde!', 'category': 'basic'},

      // SAPAK 7
      {'lesson_id': 7, 'word_ru': 'делать', 'word_tk': 'etmek, ýerine ýetirmek', 'example_ru': 'Что ты делаешь?', 'example_tk': 'Sen näme edýärsiň?', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'отдыхать', 'word_tk': 'dynç almak', 'example_ru': 'Я отдыхаю дома.', 'example_tk': 'Men öýde dynç alýaryn.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'гулять', 'word_tk': 'gezmek', 'example_ru': 'Я гуляю в парке.', 'example_tk': 'Men seýilgähde gezelenç edýärin.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'смотреть', 'word_tk': 'görmek, tomaşa etmek', 'example_ru': 'Я смотрю телевизор.', 'example_tk': 'Men telewizor tomaşa edýärin.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'любить', 'word_tk': 'söýmek, halaýmak', 'example_ru': 'Я люблю музыку.', 'example_tk': 'Men sazy halaýaryn.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'играть', 'word_tk': 'oýnamak', 'example_ru': 'Он играет в парке.', 'example_tk': 'Ol seýilgähde oýnaýar.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'слушать', 'word_tk': 'diňlemek', 'example_ru': 'Я слушаю музыку.', 'example_tk': 'Men saz diňleýärin.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'знать', 'word_tk': 'bilmek', 'example_ru': 'Я знаю это слово.', 'example_tk': 'Men bu sözi bilýärin.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'хотеть', 'word_tk': 'islemek', 'example_ru': 'Я хочу есть.', 'example_tk': 'Men iýmek isleýärin.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'помнить', 'word_tk': 'ýatlamak', 'example_ru': 'Я помню этот день.', 'example_tk': 'Men ol güni ýatlaýaryn.', 'category': 'verbs'},
      {'lesson_id': 7, 'word_ru': 'парк', 'word_tk': 'seýilgäh', 'example_ru': 'в парке', 'example_tk': 'seýilgähde', 'category': 'places', 'image_path': 'assets/images/vocabulary/vocab_park.png'},
      {'lesson_id': 7, 'word_ru': 'библиотека', 'word_tk': 'kitaphana', 'example_ru': 'в библиотеке', 'example_tk': 'kitaphanada', 'category': 'places'},
      {'lesson_id': 7, 'word_ru': 'телевизор', 'word_tk': 'telewizor', 'example_ru': 'смотреть телевизор', 'example_tk': 'telewizor tomaşa etmek', 'category': 'objects'},
      {'lesson_id': 7, 'word_ru': 'дом / дома', 'word_tk': 'öý / öýde', 'example_ru': 'Я дома.', 'example_tk': 'Men öýde.', 'category': 'places'},

      // SAPAK 8
      {'lesson_id': 8, 'word_ru': 'хороший', 'word_tk': 'gowy', 'example_ru': 'Хороший фильм!', 'example_tk': 'Gowy film!', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'плохой', 'word_tk': 'erbet', 'example_ru': 'Плохой день.', 'example_tk': 'Erbet gün.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'молодой', 'word_tk': 'ýaş', 'example_ru': 'Молодой человек.', 'example_tk': 'Ýaş adam.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'старый', 'word_tk': 'garry, gadymy', 'example_ru': 'Старый дом.', 'example_tk': 'Gadymy öý.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'дорогой', 'word_tk': 'gymmat', 'example_ru': 'Дорогой ресторан.', 'example_tk': 'Gymmat restoran.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'дешёвый', 'word_tk': 'arzan', 'example_ru': 'Дешёвый магазин.', 'example_tk': 'Arzan dükan.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'горячий', 'word_tk': 'yssy', 'example_ru': 'Горячий чай.', 'example_tk': 'Yssy çaý.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'холодный', 'word_tk': 'sowuk', 'example_ru': 'Холодная вода.', 'example_tk': 'Sowuk suw.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'трудный', 'word_tk': 'kyn', 'example_ru': 'Трудный урок.', 'example_tk': 'Kyn sapak.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'лёгкий', 'word_tk': 'aňsat', 'example_ru': 'Лёгкое упражнение.', 'example_tk': 'Aňsat ýumuş.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'длинный', 'word_tk': 'uzyn', 'example_ru': 'Длинная улица.', 'example_tk': 'Uzyn köçe.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'короткий', 'word_tk': 'gysga', 'example_ru': 'Короткий ответ.', 'example_tk': 'Gysga jogap.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'богатый', 'word_tk': 'baý', 'example_ru': 'Богатый город.', 'example_tk': 'Baý şäher.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'бедный', 'word_tk': 'garyp', 'example_ru': 'Бедный студент.', 'example_tk': 'Garyp talyp.', 'category': 'adjectives'},
      {'lesson_id': 8, 'word_ru': 'Какой...!', 'word_tk': 'Nähili...!', 'example_ru': 'Какой красивый дом!', 'example_tk': 'Nähili owadan öý!', 'category': 'exclamation'},

      // SAPAK 9
      {'lesson_id': 9, 'word_ru': 'понедельник', 'word_tk': 'duşenbe', 'example_ru': 'В понедельник.', 'example_tk': 'Duşenbe güni.', 'category': 'days'},
      {'lesson_id': 9, 'word_ru': 'вторник', 'word_tk': 'sişenbe', 'example_ru': 'Во вторник.', 'example_tk': 'Sişenbe güni.', 'category': 'days'},
      {'lesson_id': 9, 'word_ru': 'среда', 'word_tk': 'çarşenbe', 'example_ru': 'В среду.', 'example_tk': 'Çarşenbe güni.', 'category': 'days'},
      {'lesson_id': 9, 'word_ru': 'четверг', 'word_tk': 'penşenbe', 'example_ru': 'В четверг.', 'example_tk': 'Penşenbe güni.', 'category': 'days'},
      {'lesson_id': 9, 'word_ru': 'пятница', 'word_tk': 'anna', 'example_ru': 'В пятницу.', 'example_tk': 'Anna güni.', 'category': 'days'},
      {'lesson_id': 9, 'word_ru': 'суббота', 'word_tk': 'şenbe', 'example_ru': 'В субботу.', 'example_tk': 'Şenbe güni.', 'category': 'days'},
      {'lesson_id': 9, 'word_ru': 'воскресенье', 'word_tk': 'ýekşenbe', 'example_ru': 'В воскресенье.', 'example_tk': 'Ýekşenbe güni.', 'category': 'days'},
      {'lesson_id': 9, 'word_ru': 'завтракать', 'word_tk': 'ertirlik etmek', 'example_ru': 'Я завтракаю в 8.', 'example_tk': 'Men sagat 8-de ertirlik edýärin.', 'category': 'verbs'},
      {'lesson_id': 9, 'word_ru': 'обедать', 'word_tk': 'öýle naharyny iýmek', 'example_ru': 'Я обедаю в 1.', 'example_tk': 'Men sagat 1-de öýle naharyny iýýärin.', 'category': 'verbs'},
      {'lesson_id': 9, 'word_ru': 'ужинать', 'word_tk': 'agşamlyk etmek', 'example_ru': 'Я ужинаю в 7.', 'example_tk': 'Men sagat 7-de agşamlyk edýärin.', 'category': 'verbs'},
      {'lesson_id': 9, 'word_ru': 'спать', 'word_tk': 'ýatmak, uklamak', 'example_ru': 'Я сплю в 11.', 'example_tk': 'Men sagat 11-de ýatýaryn.', 'category': 'verbs'},
      {'lesson_id': 9, 'word_ru': 'Сколько времени?', 'word_tk': 'Sagat näçe?', 'example_ru': 'Сколько времени? — Два часа.', 'example_tk': 'Sagat näçe? — Iki.', 'category': 'time'},
      {'lesson_id': 9, 'word_ru': 'час', 'word_tk': 'sagat (wagt)', 'example_ru': 'один час, два часа', 'example_tk': 'bir sagat, iki sagat', 'category': 'time'},
      {'lesson_id': 9, 'word_ru': 'утра / дня / вечера / ночи', 'word_tk': 'ertiriň / günüň / agşamyň / gijäniň', 'example_ru': '8 часов утра', 'example_tk': 'ertiriň 8-i', 'category': 'time'},

      // SAPAK 10
      {'lesson_id': 10, 'word_ru': 'вставать', 'word_tk': 'turmak, oýanmak', 'example_ru': 'Я встаю в 7.', 'example_tk': 'Men sagat 7-de turýaryn.', 'category': 'verbs'},
      {'lesson_id': 10, 'word_ru': 'готовить', 'word_tk': 'nahar taýýarlamak', 'example_ru': 'Мама готовит.', 'example_tk': 'Ene nahar taýýarlaýar.', 'category': 'verbs'},
      {'lesson_id': 10, 'word_ru': 'принимать душ', 'word_tk': 'duş almak', 'example_ru': 'Я принимаю душ.', 'example_tk': 'Men duş alýaryn.', 'category': 'verbs'},
      {'lesson_id': 10, 'word_ru': 'чистить зубы', 'word_tk': 'dişleri arassalamak', 'example_ru': 'Я чищу зубы.', 'example_tk': 'Men dişlerimi arassalaýaryn.', 'category': 'verbs'},
      {'lesson_id': 10, 'word_ru': 'заниматься спортом', 'word_tk': 'sport bilen meşgullanmak', 'example_ru': 'Я занимаюсь спортом.', 'example_tk': 'Men sport bilen meşgullanýaryn.', 'category': 'verbs'},
      {'lesson_id': 10, 'word_ru': 'бегать', 'word_tk': 'ylgamak', 'example_ru': 'Я бегаю в парке.', 'example_tk': 'Men seýilgähde ylgaýaryn.', 'category': 'verbs'},
      {'lesson_id': 10, 'word_ru': 'идти', 'word_tk': 'gitmek', 'example_ru': 'Я иду в школу.', 'example_tk': 'Men mekdebe barýaryn.', 'category': 'verbs'},
      {'lesson_id': 10, 'word_ru': 'всегда', 'word_tk': 'hemişe', 'example_ru': 'Я всегда встаю рано.', 'example_tk': 'Men hemişe ir turýaryn.', 'category': 'adverbs'},
      {'lesson_id': 10, 'word_ru': 'часто', 'word_tk': 'köp, ýygy-ýygydan', 'example_ru': 'Я часто гуляю.', 'example_tk': 'Men köp gezýärin.', 'category': 'adverbs'},
      {'lesson_id': 10, 'word_ru': 'иногда', 'word_tk': 'käwagt', 'example_ru': 'Иногда я читаю.', 'example_tk': 'Käwagt men okaýaryn.', 'category': 'adverbs'},
      {'lesson_id': 10, 'word_ru': 'никогда', 'word_tk': 'hiç haçan', 'example_ru': 'Я никогда не сплю днём.', 'example_tk': 'Men hiç haçan gündiz ýatmaýaryn.', 'category': 'adverbs'},
      {'lesson_id': 10, 'word_ru': 'сначала / потом', 'word_tk': 'ilki / soňra', 'example_ru': 'Сначала завтрак, потом работа.', 'example_tk': 'Ilki ertirlik, soňra iş.', 'category': 'adverbs'},
      {'lesson_id': 10, 'word_ru': 'рано / поздно', 'word_tk': 'ir / giç', 'example_ru': 'Я встаю рано.', 'example_tk': 'Men ir turýaryn.', 'category': 'adverbs'},
      {'lesson_id': 10, 'word_ru': 'утром / днём / вечером / ночью', 'word_tk': 'ertirden / günortan / agşamyna / gijeki', 'example_ru': 'Утром я завтракаю.', 'example_tk': 'Ertirden ertirlik edýärin.', 'category': 'time'},
      {'lesson_id': 10, 'word_ru': 'Куда? / Где?', 'word_tk': 'Nirä? / Nirede?', 'example_ru': 'Куда ты идёшь? — В школу.', 'example_tk': 'Nirä barýarsyň? — Mekdebe.', 'category': 'questions'},
    ];

    for (final word in vocab) {
      await db.insert(DbConstants.tVocabulary, word,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ─────────────────────────────────────────────────────────
  // DIALOGS
  // ─────────────────────────────────────────────────────────
  static Future<void> _seedDialogs(Database db) async {
    // Dialog for Sapak 1
    final d1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 1, 'dialog_number': 1,
      'dialog_name': 'Merdan bilen Gülnar',
      'context_tk': 'Iki dost köçede duşuşýar.',
    });
    await _insertLines(db, d1, [
      ['Merdan', 'Привет, Gülnar!', 'Salam, Gülnar!'],
      ['Gülnar', 'Привет, Merdan!', 'Salam, Merdan!'],
      ['Merdan', 'Как дела?', 'Işleriň nähili?'],
      ['Gülnar', 'Спасибо, хорошо. А у тебя?', 'Sag bol, gowy. Sende-de nähili?'],
      ['Merdan', 'Тоже хорошо. Пока!', 'Hem gowy. Hoş gal!'],
      ['Gülnar', 'Пока!', 'Hoş gal!'],
    ]);

    final d2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 1, 'dialog_number': 2,
      'dialog_name': 'Döwlet bilen Aýna',
      'context_tk': 'Säher wagtlary.', 'image_path': 'assets/images/vocabulary/vocab_morning.png',
    });
    await _insertLines(db, d2, [
      ['Döwlet', 'Доброе утро, Aýna!', 'Ertiriň haýyrly, Aýna!'],
      ['Aýna', 'Доброе утро, Döwlet!', 'Ertiriň haýyrly, Döwlet!'],
      ['Döwlet', 'Как у тебя дела?', 'Işleriň nähili?'],
      ['Aýna', 'Нормально. А у тебя?', 'Bolýar. Sende-de nähili?'],
      ['Döwlet', 'Тоже нормально. Пока!', 'Hem bolýar. Hoş gal!'],
    ]);

    final d3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 1, 'dialog_number': 3,
      'dialog_name': 'Resmi tanyşma',
      'context_tk': 'Resmi duşuşyk.',
    });
    await _insertLines(db, d3, [
      ['A', 'Добрый день. Я Döwlet. А вы?', 'Günüň haýyrly. Men Döwlet. Siz?'],
      ['B', 'Добрый день. Я Aýna. Как дела?', 'Günüň haýyrly. Men Aýna. Işleriňiz nähili?'],
      ['A', 'Хорошо. А у вас?', 'Gowy. Sizde-de nähili?'],
      ['B', 'Тоже хорошо.', 'Hem gowy.'],
    ]);

    final d4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 1, 'dialog_number': 4,
      'dialog_name': 'Bегзат bilen Leýla',
      'context_tk': 'Agşam duşuşyk.',
    });
    await _insertLines(db, d4, [
      ['Bегзат', 'Добрый вечер. Меня зовут Bегзат. А как вас зовут?', 'Agşamyň haýyrly. Meniň adym Bегзат. Siziň adyňyz näme?'],
      ['Leýla', 'А меня зовут Leýla.', 'Meniň adym Leýla.'],
      ['Bегзат', 'Как у вас дела?', 'Işleriňiz nähili?'],
      ['Leýla', 'Отлично. Вы студент?', 'Ajaýyp. Siz talypmy?'],
      ['Bегзат', 'Да, я студент.', 'Hawa, men talyp.'],
    ]);

    final d5 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 1, 'dialog_number': 5,
      'dialog_name': 'Jeren bilen Serdar',
      'context_tk': 'Gündiz duşuşyk.',
    });
    await _insertLines(db, d5, [
      ['Serdar', 'Добрый день, Jeren!', 'Günüň haýyrly, Jeren!'],
      ['Jeren', 'Добрый день, Serdar!', 'Günüň haýyrly, Serdar!'],
      ['Serdar', 'Как дела?', 'Işleriň nähili?'],
      ['Jeren', 'Спасибо, отлично. А у тебя?', 'Sag bol, ajaýyp. Sende-de?'],
      ['Serdar', 'Тоже хорошо. Пока!', 'Hem gowy. Hoş gal!'],
    ]);

    final d6 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 1, 'dialog_number': 6,
      'dialog_name': 'Merdan bilen Leýla',
      'context_tk': 'Talyplar tanyşýar.',
    });
    await _insertLines(db, d6, [
      ['Leýla', 'Меня зовут Leýla. Я студентка. А как вас зовут?', 'Meniň adym Leýla. Men talyp. Siziň adyňyz näme?'],
      ['Merdan', 'Меня зовут Merdan. Я тоже студент.', 'Meniň adym Merdan. Men hem talyp.'],
      ['Leýla', 'Как у вас дела?', 'Işleriňiz nähili?'],
      ['Merdan', 'Спасибо, отлично. А у вас?', 'Sag boluň, ajaýyp. Sizde-de nähili?'],
      ['Leýla', 'Тоже хорошо. Пока.', 'Hem gowy. Hoş gal.'],
    ]);

    final d7 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 1, 'dialog_number': 7,
      'dialog_name': 'Irden salam berme',
      'context_tk': 'Irden duşuşyk.',
    });
    await _insertLines(db, d7, [
      ['Aýna', 'Доброе утро, Döwlet!', 'Ertiriň haýyrly, Döwlet!'],
      ['Döwlet', 'Доброе утро, Aýna!', 'Ertiriň haýyrly, Aýna!'],
      ['Aýna', 'Как дела? — Хорошо.', 'Işleriň nähili? — Gowy.'],
    ]);

    final d8 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 1, 'dialog_number': 8,
      'dialog_name': 'Gülnar bilen Merdan',
      'context_tk': 'Günortanky duşuşyk.',
    });
    await _insertLines(db, d8, [
      ['Gülnar', 'Добрый день, Merdan.', 'Günüň haýyrly, Merdan.'],
      ['Merdan', 'Добрый день, Gülnar.', 'Günüň haýyrly, Gülnar.'],
      ['Gülnar', 'Как у вас дела?', 'Işleriňiz nähili?'],
      ['Merdan', 'Спасибо, нормально. А у вас?', 'Sag boluň, bolýar. Sizde-de?'],
      ['Gülnar', 'Тоже нормально. До свидания!', 'Hem bolýar. Hoş gal!'],
    ]);

    // Sapak 2 dialogs
    final d2_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 2, 'dialog_number': 1,
      'dialog_name': 'Aýna bilen Döwlet',
      'context_tk': 'Resmi tanyşma.',
    });
    await _insertLines(db, d2_1, [
      ['Aýna', 'Здравствуйте! Меня зовут Aýna. А вас?', 'Salam! Meniň adym Aýna. Siziňki?'],
      ['Döwlet', 'А меня зовут Döwlet.', 'Meniň adym Döwlet.'],
      ['Aýna', 'Очень приятно.', 'Tanyşanymyza begenýärin.'],
      ['Döwlet', 'Мне тоже. До свидания.', 'Men hem. Hoş gal.'],
    ]);

    final d2_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 2, 'dialog_number': 2,
      'dialog_name': 'Döwlet bilen Gülnar',
      'context_tk': 'Tanyşdyrma.',
    });
    await _insertLines(db, d2_2, [
      ['Döwlet', 'Здравствуйте! Это моя подруга Gülnar.', 'Salam! Bu meniň dostum Gülnar.'],
      ['Gülnar', 'Здравствуйте! Очень приятно.', 'Salam! Tanyşanymyza begenýärin.'],
      ['A', 'Мне тоже. Как ваша фамилия?', 'Men hem. Familiýaňyz näme?'],
      ['Gülnar', 'Моя фамилия Baýramowa.', 'Meniň familiýam Baýramowa.'],
    ]);

    final d2_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 2, 'dialog_number': 3,
      'dialog_name': 'Mugallym bilen talyp',
      'context_tk': 'Synpda tanyşma.',
    });
    await _insertLines(db, d2_3, [
      ['Mugallym', 'Здравствуйте. Я ваш преподаватель. Меня зовут Serdar Nikolaýewiç.', 'Salam. Men siziň mugallymyňyz. Meniň adym Serdar Nikolaýewiç.'],
      ['Talyp', 'Очень приятно. А как ваша фамилия?', 'Tanyşanymyza begenýärin. Familiýaňyz näme?'],
      ['Mugallym', 'Моя фамилия Ataýew. А как вас зовут?', 'Meniň familiýam Ataýew. Siziň adyňyz?'],
      ['Talyp', 'А меня зовут Gülnar. Моя фамилия Baýramowa.', 'Meniň adym Gülnar. Familiýam Baýramowa.'],
    ]);

    final d2_4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 2, 'dialog_number': 4,
      'dialog_name': 'Söhbet',
      'context_tk': 'Dostlar gürrüňdeşligi.',
    });
    await _insertLines(db, d2_4, [
      ['A', 'Здравствуйте. Меня зовут Döwlet. А вас?', 'Salam. Meniň adym Döwlet. Siziňki?'],
      ['B', 'Меня зовут Jeren.', 'Meniň adym Jeren.'],
      ['A', 'Очень приятно, Jeren! Это ваш друг?', 'Tanyşanymyza begenýärin, Jeren! Bu siziň dostuňyzmy?'],
      ['B', 'Да, это мой друг Serdar.', 'Hawa, bu meniň dostum Serdar.'],
    ]);

    final d2_5 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 2, 'dialog_number': 5,
      'dialog_name': 'Döwlet bilen Merdan',
      'context_tk': 'Sorag.',
    });
    await _insertLines(db, d2_5, [
      ['Merdan', 'Döwlet, можно вопрос?', 'Döwlet, bir sorag soraýsammydym?'],
      ['Döwlet', 'Пожалуйста.', 'Haýyş.'],
      ['Merdan', 'Это твой друг?', 'Bu seniň dostuňmy?'],
      ['Döwlet', 'Да, это мой друг. Его зовут Serdar.', 'Hawa, bu meniň dostum. Ady Serdar.'],
      ['Merdan', 'А это твоя подруга? Как её зовут?', 'Bu-da seniň dostuňmy? Ady näme?'],
      ['Döwlet', 'Да, это моя подруга. Её зовут Gülnar.', 'Hawa, bu meniň dostum. Ady Gülnar.'],
    ]);

    final d2_6 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 2, 'dialog_number': 6,
      'dialog_name': 'Gülnar barada',
      'context_tk': 'Bir adam barada gürrüň.',
    });
    await _insertLines(db, d2_6, [
      ['A', 'Кто это?', 'Bu kim?'],
      ['B', 'Это моя подруга Gülnar.', 'Bu meniň dostum Gülnar.'],
      ['A', 'Как её фамилия?', 'Familiýasy näme?'],
      ['B', 'Её фамилия Amanowa.', 'Familiýasy Amanowa.'],
    ]);

    final d2_7 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 2, 'dialog_number': 7,
      'dialog_name': 'Ötünç soramak',
      'context_tk': 'Ötünç.',
    });
    await _insertLines(db, d2_7, [
      ['A', 'Извините!', 'Bagyşlaweriň!'],
      ['B', 'Ничего.', 'Zat däl.'],
    ]);

    final d2_8 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 2, 'dialog_number': 8,
      'dialog_name': 'Hoşlaşma',
      'context_tk': 'Hoşlaşma.',
    });
    await _insertLines(db, d2_8, [
      ['A', 'До свидания, Döwlet!', 'Hoş gal, Döwlet!'],
      ['B', 'До завтра, Aýna!', 'Ertire çenli, Aýna!'],
    ]);

    // Sapak 3 dialogs
    final d3_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 3, 'dialog_number': 1,
      'dialog_name': 'Aýnanyň maşgalasy',
      'context_tk': 'Maşgala suraty.',
    });
    await _insertLines(db, d3_1, [
      ['A', 'Aýna, кто это?', 'Aýna, bu kim?'],
      ['Aýna', 'Это моя мама. Её зовут Ogulgerek.', 'Bu meniň enem. Ady Ogulgerek.'],
      ['A', 'А это твой отец?', 'Bu-da seniň kakammy?'],
      ['Aýna', 'Нет, это мой дедушка. Его зовут Nurmuhammet. А вот мой отец Merdan.', 'Ýok, bu meniň atam. Ady Nurmuhammet. Ine kakam Merdan.'],
    ]);

    final d3_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 3, 'dialog_number': 2,
      'dialog_name': 'Leýlanyň maşgalasy',
      'context_tk': 'Tanyşdyrma.',
    });
    await _insertLines(db, d3_2, [
      ['Döwlet', 'Добрый вечер. Давайте познакомимся!', 'Agşamyň haýyrly. Tanyşalyň!'],
      ['Leýla', 'Давайте. Меня зовут Leýla. Я студентка.', 'Geliň. Meniň adym Leýla. Men talyp.'],
      ['Döwlet', 'Это ваша семья?', 'Bu siziň maşgalaňyzmy?'],
      ['Leýla', 'Да, это мои родители. Их зовут Serdar и Ogulnur.', 'Hawa, bular meniň ene-atam. Atlary Serdar we Ogulnur.'],
      ['Döwlet', 'А кто это?', 'Bu-da kim?'],
      ['Leýla', 'Это моя сестра Gülnar. Она преподаватель.', 'Bu meniň aýal doganym Gülnar. Ol mugallym.'],
    ]);

    final d3_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 3, 'dialog_number': 3,
      'dialog_name': 'Maşgala agzalary',
      'context_tk': 'Maşgala barada gürrüň.',
    });
    await _insertLines(db, d3_3, [
      ['A', 'Это твой брат?', 'Bu seniň doganmyň?'],
      ['B', 'Да, это мой брат Merdan. А это его жена Gülnar.', 'Hawa, bu meniň doganym Merdan. Bu-da onuň aýaly Gülnar.'],
      ['A', 'Это их дети?', 'Bular olaryň çagalarymy?'],
      ['B', 'Да. Их сын Döwlet и дочь Jeren. Döwlet — мой племянник, Jeren — моя племянница.', 'Hawa. Oglanlary Döwlet, gyzlary Jeren. Döwlet meniň ýegenim, Jeren hem meniň ýegenim.'],
    ]);

    // Sapak 4 - 6 dialogs
    final d4_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 4, 'dialog_number': 1,
      'dialog_name': 'Kim hünäri?',
      'context_tk': 'Hünärler barada gürrüň.',
    });
    await _insertLines(db, d4_1, [
      ['A', 'Döwlet, кто вы по профессии?', 'Döwlet, hünäriňiz näme?'],
      ['Döwlet', 'Я юрист. Я работаю в банке. А где вы работаете?', 'Men hukukçy. Men bankda işleýärin. Siz nirede işleýärsiňiz?'],
      ['A', 'Я повар. Я работаю в ресторане.', 'Men aşpez. Men restoraňda işleýärin.'],
    ]);

    final d4_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 4, 'dialog_number': 2,
      'dialog_name': 'Lukman',
      'context_tk': 'Lukman barada gürrüň.',
    });
    await _insertLines(db, d4_2, [
      ['A', 'Это ваша подруга врач?', 'Siziň dostuňyz lukmanmy?'],
      ['B', 'Да, она врач. Работает в больнице.', 'Hawa, ol lukman. Hassahanada işleýär.'],
      ['A', 'А ваш муж где работает?', 'Äriňiz nirede işleýär?'],
      ['B', 'Он инженер, работает на заводе.', 'Ol inžener, zawodda işleýär.'],
    ]);

    final d4_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 4, 'dialog_number': 3,
      'dialog_name': 'Talyp okýar',
      'context_tk': 'Okamak we işlemek.',
    });
    await _insertLines(db, d4_3, [
      ['A', 'Ты работаешь?', 'Sen işleýärsiňmi?'],
      ['B', 'Нет, я не работаю. Я учусь в университете.', 'Ýok, men işlämok. Men uniwersitetde okaýaryn.'],
      ['A', 'А твоя сестра?', 'Doganyn näme?'],
      ['B', 'Она работает и учится. Она студентка и официантка.', 'Ol işleýär we okaýar. Ol talyp we ofisiant.'],
    ]);

    final d4_4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 4, 'dialog_number': 4,
      'dialog_name': 'Iş ýerleri',
      'context_tk': 'Iş ýerleri barada.',
    });
    await _insertLines(db, d4_4, [
      ['A', 'Это моя подруга Aýna — переводчик, работает в посольстве. А это мой друг Döwlet — почтальон, работает на почте.', 'Bu meniň dostum Aýna — terjimeçi, ilçihanada işleýär. Bu-da dostum Döwlet — poçtaçy, poçtada işleýär.'],
      ['B', 'А где ты работаешь?', 'Sen nirede işleýärsiň?'],
      ['A', 'Я не работаю. Я учусь в университете.', 'Men işlämok. Men uniwersitetde okaýaryn.'],
    ]);

    final d4_5 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 4, 'dialog_number': 5,
      'dialog_name': 'Žurnalist',
      'context_tk': 'Žurnalist barada.',
    });
    await _insertLines(db, d4_5, [
      ['A', 'Bегзат работает в музее?', 'Bегзат muzeýde işleýärmi?'],
      ['B', 'Да, он гид.', 'Hawa, ol ýolbeletçi.'],
      ['A', 'А Leýla?', 'Leýla näme?'],
      ['B', 'Leýla журналист, работает в газете.', 'Leýla žurnalist, gazetde işleýär.'],
    ]);

    final d4_6 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 4, 'dialog_number': 6,
      'dialog_name': 'Biziň hünärler',
      'context_tk': 'Dürli hünärler.',
    });
    await _insertLines(db, d4_6, [
      ['A', 'Меня зовут Serdar. Я по профессии продавец, работаю в магазине.', 'Meniň adym Serdar. Hünärim satyjy, dükanda işleýärin.'],
      ['B', 'Я Aýna. Я официантка. Работаю в ресторане и учусь в институте.', 'Men Aýna. Men ofisiant. Restoraňda işleýärin we institutda okaýaryn.'],
    ]);

    // Sapak 5 - 4 dialogs
    final d5_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 5, 'dialog_number': 1,
      'dialog_name': 'Milliýet soragy',
      'context_tk': 'Milliýet barada.',
    });
    await _insertLines(db, d5_1, [
      ['Ральф', 'Меня зовут Ральф. Я немец.', 'Meniň adym Ральф. Men nemes.'],
      ['Gülnar', 'Очень приятно. А меня зовут Gülnar. Я туркменка.', 'Tanyşanymyza begenýärin. Meniň adym Gülnar. Men türkmen.'],
      ['Ральф', 'Какой ваш родной город?', 'Siziň öz şäheriňiz haýsy?'],
      ['Gülnar', 'Ашхабад. А ваш?', 'Aşgabat. Siziňki?'],
      ['Ральф', 'Берлин.', 'Berlin.'],
    ]);

    final d5_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 5, 'dialog_number': 2,
      'dialog_name': 'Ýaşaýyş ýeri',
      'context_tk': 'Nireden we nirede ýaşaýar.',
    });
    await _insertLines(db, d5_2, [
      ['A', 'Вы живёте в Ашхабаде?', 'Siz Aşgabatda ýaşaýarsyňyzmy?'],
      ['B', 'Да, сейчас я живу в Ашхабаде. Раньше я жил в Мары.', 'Hawa, häzir Aşgabatda ýaşaýaryn. Öň Marыda ýaşardym.'],
      ['A', 'Мары — красивый город?', 'Mary owadan şähermi?'],
      ['B', 'Да, красивый и большой!', 'Hawa, owadan we uly!'],
    ]);

    final d5_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 5, 'dialog_number': 3,
      'dialog_name': 'Aýna barada',
      'context_tk': 'Söhbetdeşlik.',
    });
    await _insertLines(db, d5_3, [
      ['A', 'Aýna, кто вы по национальности?', 'Aýna, milliýetiňiz näme?'],
      ['Aýna', 'Я туркменка. Раньше я жила в Мары, сейчас живу в Ашхабаде.', 'Men türkmen. Öň Marыda ýaşardym, häzir Aşgabatda ýaşaýaryn.'],
      ['A', 'Вы работаете или учитесь?', 'Işleýärsiňizmi ýa okaýarsyňyzmy?'],
      ['Aýna', 'Учусь в университете и работаю в фирме.', 'Uniwersitetde okaýaryn we firmada işleýärin.'],
    ]);

    final d5_4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 5, 'dialog_number': 4,
      'dialog_name': 'Geçmişde ýaşaýyş',
      'context_tk': 'Öňki ýaşaýyş.',
    });
    await _insertLines(db, d5_4, [
      ['A', 'Где вы жили раньше?', 'Öň nirede ýaşardyňyz?'],
      ['B', 'Раньше я жил в Испании, в Мадриде. Сейчас живу в Туркменистане.', 'Öň Ispaniýada, Madridde ýaşardym. Häzir Türkmenistanda ýaşaýaryn.'],
      ['A', 'Испания — красивая страна?', 'Ispaniýa owadan ýurtmy?'],
      ['B', 'Да, очень красивая!', 'Hawa, gaty owadan!'],
    ]);

    // Sapak 6 - 4 dialogs
    final d6_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 6, 'dialog_number': 1,
      'dialog_name': 'Rusça gepleşmek',
      'context_tk': 'Dil barada gürrüň.',
    });
    await _insertLines(db, d6_1, [
      ['A', 'Döwlet, вы говорите по-русски?', 'Döwlet, siz rusça gepleşýärsiňizmi?'],
      ['Döwlet', 'Конечно, говорю. Это мой родной язык.', 'Elbetde, gepleşýärin. Bu meniň ene dilim.'],
      ['A', 'Мой родной язык — немецкий. Вы говорите по-немецки?', 'Meniň ene dilim nemes dili. Siz nemesçe gepleşýärsiňizmi?'],
      ['Döwlet', 'Да, но очень плохо. Хорошо говорю по-испански.', 'Hawa, ýöne gaty erbet. Ispançe gowy gepleşýärin.'],
    ]);

    final d6_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 6, 'dialog_number': 2,
      'dialog_name': 'Dil öwrenmek',
      'context_tk': 'Dil öwrenmek barada.',
    });
    await _insertLines(db, d6_2, [
      ['A', 'Какой ваш родной язык?', 'Ene diliňiz haýsy?'],
      ['B', 'Туркменский. А вы говорите по-туркменски?', 'Türkmen dili. Siz türkmençe gepleşýärsiňizmi?'],
      ['A', 'Нет, я не понимаю по-туркменски.', 'Ýok, men türkmençe düşünmeýärin.'],
      ['B', 'Я могу говорить по-русски или по-английски.', 'Men rusça ýa iňlisçe gepleşip bilýärin.'],
    ]);

    final d6_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 6, 'dialog_number': 3,
      'dialog_name': 'Täze dil',
      'context_tk': 'Öwrenilýän diller.',
    });
    await _insertLines(db, d6_3, [
      ['A', 'Это наш друг. Раньше он изучал русский язык.', 'Bu biziň dostumyz. Öň ol rusça öwrenýärdi.'],
      ['B', 'Сейчас отлично говорит по-русски?', 'Häzir rusça gowy gepleşýärmi?'],
      ['A', 'Да! А ты говоришь по-английски?', 'Hawa! Sen iňlisçe gepleşýärsiňmi?'],
      ['B', 'Да, хорошо. Сейчас изучаю испанский.', 'Hawa, gowy. Häzir ispançe öwrenýärin.'],
    ]);

    final d6_4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 6, 'dialog_number': 4,
      'dialog_name': 'учиться vs изучать',
      'context_tk': 'Mekdep we dil.',
    });
    await _insertLines(db, d6_4, [
      ['A', 'Ты учишься или работаешь?', 'Sen okaýarsyňmy ýa işleýärsiňmi?'],
      ['B', 'Учусь в университете. И изучаю китайский язык.', 'Uniwersitetde okaýaryn. Hem hytaýça öwrenýärin.'],
      ['A', 'Хорошо понимаешь по-китайски?', 'Hytaýça gowy düşünýärsiňmi?'],
      ['B', 'Немного. Раньше я плохо понимал, сейчас лучше.', 'Biraz. Öň erbet düşünýärdim, häzir gowy.'],
    ]);

    // Sapak 7 - 4 dialogs
    final d7_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 7, 'dialog_number': 1,
      'dialog_name': 'Näme edýärsiň?',
      'context_tk': 'Häzir näme edýär.',
    });
    await _insertLines(db, d7_1, [
      ['A', 'Döwlet, что ты делаешь?', 'Döwlet, sen näme edýärsiň?'],
      ['Döwlet', 'Я читаю интересный журнал. А что ты делаешь?', 'Men gyzykly žurnal okaýaryn. Sen näme edýärsiň?'],
      ['A', 'А я смотрю фильм.', 'Men film tomaşa edýärin.'],
      ['Döwlet', 'Это интересный фильм?', 'Gyzykly filmmи?'],
      ['A', 'Нет, это скучный фильм.', 'Ýok, gyzykly däl.'],
    ]);

    final d7_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 7, 'dialog_number': 2,
      'dialog_name': 'Dynç almak',
      'context_tk': 'Öýde dynç alma.',
    });
    await _insertLines(db, d7_2, [
      ['A', 'Где все?', 'Hemmeler nirede?'],
      ['B', 'Бабушка гуляет. А дедушка дома — смотрит телевизор.', 'Ene seýilgähde gezelenç edýär. Ata öýde — telewizor tomaşa edýär.'],
      ['A', 'Почему он не гуляет?', 'Näme üçin ol gezelenç etmeýär?'],
      ['B', 'Он хочет отдыхать.', 'Ol dynç almak isleýär.'],
      ['A', 'А что ты делаешь?', 'Sen näme edýärsiň?'],
      ['B', 'Я ничего не делаю. Я отдыхаю.', 'Men hiç zat etmäýärin. Men dynç alýaryn.'],
    ]);

    final d7_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 7, 'dialog_number': 3,
      'dialog_name': 'Maşgala näme edýär?',
      'context_tk': 'Maşgala işleri.',
    });
    await _insertLines(db, d7_3, [
      ['A', 'Что делает твой брат?', 'Doganyň näme edýär?'],
      ['B', 'Он слушает музыку.', 'Ol saz diňleýär.'],
      ['A', 'А сестра?', 'Doganyn näme?'],
      ['B', 'Она играет с детьми и смотрит телевизор.', 'Ol çagalar bilen oýnaýar we telewizor tomaşa edýär.'],
    ]);

    final d7_4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 7, 'dialog_number': 4,
      'dialog_name': 'Öň näme edýärdiň?',
      'context_tk': 'Geçmişdäki işler.',
    });
    await _insertLines(db, d7_4, [
      ['A', 'Вчера ты работал?', 'Düýn sen işlediňmi?'],
      ['B', 'Нет, вчера я отдыхал и гулял в парке.', 'Ýok, düýn dynç aldym we seýilgähde gezedim.'],
      ['A', 'Что ты делал вечером?', 'Agşam näme etdiň?'],
      ['B', 'Вечером смотрел телевизор и читал книгу.', 'Agşam telewizor tomaşa etdim we kitap okadym.'],
    ]);

    // Sapak 8 - 4 dialogs
    final d8_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 8, 'dialog_number': 1,
      'dialog_name': 'Ýumuş barada',
      'context_tk': 'Synp gürrüňi.',
    });
    await _insertLines(db, d8_1, [
      ['A', 'Какое упражнение ты делаешь?', 'Sen haýsy ýumuşy edýärsiň?'],
      ['B', 'Трудное. А ты?', 'Kyny. Sen?'],
      ['A', 'Я делаю лёгкое упражнение.', 'Men aňsat ýumuş edýärin.'],
      ['B', 'Хорошо!', 'Gowy!'],
    ]);

    final d8_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 8, 'dialog_number': 2,
      'dialog_name': 'Nahar we içgi',
      'context_tk': 'Nahar barada.',
    });
    await _insertLines(db, d8_2, [
      ['A', 'Какое пиво любит твой брат, светлое или тёмное?', 'Doganyň nähili piwo halaýar, ýagty ýa-da garaňky?'],
      ['B', 'Он любит холодное светлое пиво.', 'Ol sowuk ýagty piwo halaýar.'],
      ['A', 'А ты?', 'Sen?'],
      ['B', 'Я не люблю пиво. Я люблю горячий чай!', 'Men piwo halamaýaryn. Men yssy çaý halaýaryn!'],
    ]);

    final d8_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 8, 'dialog_number': 3,
      'dialog_name': 'Owadan surat',
      'context_tk': 'Gykylyk.',
    });
    await _insertLines(db, d8_3, [
      ['A', 'Какая интересная фотография!', 'Nähili gyzykly surat!'],
      ['B', 'Это старый город. Красивый, правда?', 'Bu gadymy şäher. Owadan, şeýlemi?'],
      ['A', 'Да, очень красивый! Какой большой замок!', 'Hawa, gaty owadan! Nähili uly gala!'],
      ['B', 'И очень старый.', 'Hem gaty gadymy.'],
    ]);

    final d8_4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 8, 'dialog_number': 4,
      'dialog_name': 'Döwlet bilen gürrüň',
      'context_tk': 'Türkmenistan barada.',
    });
    await _insertLines(db, d8_4, [
      ['A', 'Привет, Döwlet! Как дела? Как Туркменистан?', 'Salam, Döwlet! Işleriň nähili? Türkmenistan nähili?'],
      ['Döwlet', 'Всё хорошо! Туркменистан большой и красивый.', 'Ähli zat gowy! Türkmenistan uly we owadan.'],
      ['A', 'Ашхабад — красивый город?', 'Aşgabat owadan şähermi?'],
      ['Döwlet', 'Да, очень красивый и новый! Белый и большой.', 'Hawa, gaty owadan we täze! Ak we uly.'],
    ]);

    // Sapak 9 - 7 dialogs
    final d9_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 9, 'dialog_number': 1,
      'dialog_name': 'Haýsy gün?',
      'context_tk': 'Hepde günleri.',
    });
    await _insertLines(db, d9_1, [
      ['A', 'Какой сегодня день?', 'Şu gün haýsy gün?'],
      ['B', 'Сегодня среда.', 'Şu gün çarşenbe.'],
      ['A', 'А завтра?', 'Ertir?'],
      ['B', 'Завтра четверг.', 'Ertir penşenbe.'],
    ]);

    final d9_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 9, 'dialog_number': 2,
      'dialog_name': 'Sagat näçe?',
      'context_tk': 'Sagat soragy.',
    });
    await _insertLines(db, d9_2, [
      ['A', 'Сколько времени?', 'Sagat näçe?'],
      ['B', 'Сейчас три часа.', 'Häzir sagat üç.'],
      ['A', 'Уже три? Мне нужно идти!', 'Eýýäm üçmi? Men gitmeli!'],
      ['B', 'Пока! — Пока!', 'Hoş gal! — Hoş gal!'],
    ]);

    final d9_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 9, 'dialog_number': 3,
      'dialog_name': 'Nahar wagty',
      'context_tk': 'Nahar wagty.',
    });
    await _insertLines(db, d9_3, [
      ['A', 'Döwlet, пора обедать!', 'Döwlet, öýle nahary wagty!'],
      ['Döwlet', 'А сколько сейчас времени?', 'Sagat näçe häzir?'],
      ['A', 'Сейчас два часа.', 'Häzir sagat iki.'],
      ['Döwlet', 'Ой, правда, уже 2 часа?! Давай обедать!', 'Wah, dogrumy, eýýäm sagat 2mi?! Geliň öýle naharlanaly!'],
    ]);

    final d9_4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 9, 'dialog_number': 4,
      'dialog_name': 'Haçan?',
      'context_tk': 'Wagtlar barada.',
    });
    await _insertLines(db, d9_4, [
      ['A', 'Во сколько ты завтракаешь?', 'Sagat näçede ertirlik edýärsiň?'],
      ['B', 'В 8 часов утра.', 'Ertiriň sagat 8-de.'],
      ['A', 'А ужинаешь?', 'Agşamlyk?'],
      ['B', 'Обычно в 7 часов вечера.', 'Adatça agşamyň sagat 7-de.'],
    ]);

    final d9_5 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 9, 'dialog_number': 5,
      'dialog_name': 'Hepde tertip',
      'context_tk': 'Hepdäniň tertibi.',
    });
    await _insertLines(db, d9_5, [
      ['A', 'В какие дни ты работаешь?', 'Haýsy günler işleýärsiň?'],
      ['B', 'В понедельник, вторник и среду.', 'Duşenbe, sişenbe we çarşenbe.'],
      ['A', 'А в пятницу?', 'Annada-da?'],
      ['B', 'Нет, в пятницу я не работаю.', 'Ýok, annada işlämok.'],
    ]);

    final d9_6 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 9, 'dialog_number': 6,
      'dialog_name': 'Dynç günleri',
      'context_tk': 'Dynç günleri.',
    });
    await _insertLines(db, d9_6, [
      ['A', 'Что ты делаешь в выходные?', 'Dynç günleri näme edýärsiň?'],
      ['B', 'В субботу отдыхаю, а в воскресенье гуляю в парке.', 'Şenbe güni dynç alýaryn, ýekşenbe güni seýilgähde gezýärin.'],
      ['A', 'Один?', 'Ýeke?'],
      ['B', 'Нет, с семьёй.', 'Ýok, maşgala bilen.'],
    ]);

    final d9_7 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 9, 'dialog_number': 7,
      'dialog_name': 'Döwlet öňki güni',
      'context_tk': 'Düýnki günler.',
    });
    await _insertLines(db, d9_7, [
      ['A', 'Döwlet, что ты делал вчера в 9 часов утра?', 'Döwlet, düýn ertiriň sagat 9-da näme etdiň?'],
      ['Döwlet', 'В 9 утра я завтракал. В 10 часов был в университете.', 'Ertiriň 9-da ertirlik etdim. Sagat 10-da uniwersitetde boldym.'],
      ['A', 'А в 2 часа дня?', 'Günüň sagat 2-de?'],
      ['Döwlet', 'В 2 часа дня я обедал дома.', 'Günüň sagat 2-de öýde öýle naharlandym.'],
    ]);

    // Sapak 10 - 4 dialogs
    final d10_1 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 10, 'dialog_number': 1,
      'dialog_name': 'Bегзat we aýaly',
      'context_tk': 'Pensiýadakylaryň güni.',
    });
    await _insertLines(db, d10_1, [
      ['Bегзат', 'Мы пенсионеры. Каждый день встаём в 7 утра.', 'Biz pensiýadaky. Her gün sagat 7-de turýarys.'],
      ['Aýal', 'Сначала принимаем душ, потом готовим завтрак.', 'Ilki duş alýarys, soňra ertirlik taýýarlaýarys.'],
      ['Bегзат', 'Любим завтракать на балконе!', 'Balkondan ertirlik etmegi halaýarys!'],
    ]);

    final d10_2 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 10, 'dialog_number': 2,
      'dialog_name': 'Nirä barýarsyň?',
      'context_tk': 'Куда? we Где? tapawudy.',
    });
    await _insertLines(db, d10_2, [
      ['A', 'Куда ты идёшь?', 'Nirä barýarsyň?'],
      ['B', 'Иду в магазин.', 'Dükana barýaryn.'],
      ['A', 'А потом?', 'Soňra?'],
      ['B', 'Потом иду домой.', 'Soňra öýe barýaryn.'],
    ]);

    final d10_3 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 10, 'dialog_number': 3,
      'dialog_name': 'Sport we saglygyň',
      'context_tk': 'Sport barada.',
    });
    await _insertLines(db, d10_3, [
      ['A', 'Ты занимаешься спортом?', 'Sen sport bilen meşgullanýarsyňmy?'],
      ['B', 'Да, я часто бегаю в парке. Иногда утром, иногда вечером.', 'Hawa, men köp seýilgähde ylgaýaryn. Käwagt ertirden, käwagt agşamyna.'],
      ['A', 'Ты никогда не занимаешься спортом дома?', 'Sen hiç haçan öýde sport bilen meşgullanmaýarsyňmy?'],
      ['B', 'Иногда. Но я люблю парк.', 'Käwagt. Ýöne men seýilgähi halaýaryn.'],
    ]);

    final d10_4 = await db.insert(DbConstants.tDialogs, {
      'lesson_id': 10, 'dialog_number': 4,
      'dialog_name': 'Gündelik tertip',
      'context_tk': 'Günüň tertibi.',
    });
    await _insertLines(db, d10_4, [
      ['A', 'Во сколько ты встаёшь?', 'Sagat näçede turýarsyň?'],
      ['B', 'Обычно в 7 часов утра. Сначала чищу зубы, потом принимаю душ.', 'Adatça ertiriň sagat 7-de. Ilki dişlerimi arassalaýaryn, soňra duş alýaryn.'],
      ['A', 'А когда идёшь на работу?', 'Haçan işe gidýärsiň?'],
      ['B', 'В 9 часов. Но сначала завтракаю.', 'Sagat 9-da. Ýöne ilki ertirlik edýärin.'],
    ]);
  }

  static Future<void> _insertLines(
    Database db,
    int dialogId,
    List<List<String>> lines,
  ) async {
    for (int i = 0; i < lines.length; i++) {
      await db.insert(DbConstants.tDialogLines, {
        'dialog_id': dialogId,
        'line_order': i,
        'speaker': lines[i][0],
        'text_ru': lines[i][1],
        'text_tk': lines[i][2],
      });
    }
  }

  // ─────────────────────────────────────────────────────────
  // GRAMMAR RULES
  // ─────────────────────────────────────────────────────────
  static Future<void> _seedGrammarRules(Database db) async {
    // Sapak 1 - Местоимения
    final g1 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 1, 'table_number': 1,
      'title_ru': 'Таблица 1: Местоимения',
      'title_tk': 'Çalyşmalar tablisasy',
      'explanation_tk': 'Rusça çalyşmalar iki düşümde ulanylýar: Именительный (kim?) we Винительный (зовут bilen).',
      'note_tk': 'Atlandyryş düşümi — predmetiň ady. Günäkärlik düşümi — «зовут» bilen ulanylýar.',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g1, true, [
      ['Именительный (Кто?)', 'Türkmençe', 'Винительный (Меня зовут...)', 'Mysal'],
      ['я', 'men', 'меня', 'Меня зовут Merdan.'],
      ['ты', 'sen', 'тебя', 'Тебя зовут Aýna.'],
      ['он', 'ol-erkek', 'его', 'Его зовут Döwlet.'],
      ['она', 'ol-aýal', 'её', 'Её зовут Gülnar.'],
      ['оно', 'ol-zat', 'его', '—'],
      ['мы', 'biz', 'нас', 'Нас зовут Merdan we Aýna.'],
      ['вы', 'siz', 'вас', 'Вас зовут Döwlet.'],
      ['они', 'olar', 'их', 'Их зовут Serdar we Leýla.'],
    ], redCols: [2]);

    // Sapak 2 - Sözleriň jynsy + Eýelik çalyşmalary
    final g2 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 2, 'table_number': 1,
      'title_ru': 'Таблица 1: Род существительных',
      'title_tk': 'Sözleriň jynsy',
      'explanation_tk': 'Rusça her sözüň jynsy bardyr. Gutarýan harpa seretmeli!',
      'note_tk': 'Erkek: çekimsiz harp | Aýal: а/я | Orta: о/е/мя',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g2, true, [
      ['Erkek (мужской)', 'Aýal (женский)', 'Orta (средний)'],
      ['друг, студент, день', 'подруга, студентка', 'утро, отчество'],
      ['чай (çekimsiz)', 'фамилия (-ия)', 'упражнение (-е)'],
      ['преподаватель (-ь erkek)', 'мать (-ь aýal)', 'имя (-мя)'],
    ], redCols: []);

    final g2b = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 2, 'table_number': 2,
      'title_ru': 'Таблица 2: Притяжательные местоимения',
      'title_tk': 'Eýelik çalyşmalary',
      'explanation_tk': 'Eýelik çalyşmalary sözüň jynsyna we sanyna görä üýtgeýär.',
      'note_tk': 'его / её / их hiç haçan üýtgemeýär!',
      'rule_type': 'table', 'order_index': 2,
    });
    await _insertTableRows(db, g2b, true, [
      ['Sahyp', 'Erkek (он)', 'Aýal (она)', 'Orta (оно)', 'Köplük (они)'],
      ['я', 'мой', 'моя', 'моё', 'мои'],
      ['ты', 'твой', 'твоя', 'твоё', 'твои'],
      ['он/оно', 'его', 'его', 'его', 'его'],
      ['она', 'её', 'её', 'её', 'её'],
      ['мы', 'наш', 'наша', 'наше', 'наши'],
      ['вы', 'ваш', 'ваша', 'ваше', 'ваши'],
      ['они', 'их', 'их', 'их', 'их'],
    ], redCols: [1, 2, 3, 4]);

    // Sapak 4 - Köplük + Предложный
    final g4 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 4, 'table_number': 1,
      'title_ru': 'Таблица 1: Köplük sany',
      'title_tk': 'Atlaryň köplük sany',
      'explanation_tk': 'Köplük san düzgünleri gutarýan harpdan ugur alynýar.',
      'note_tk': 'Käbir atlar düzgünsiz üýtgeýär — друг→друзья, брат→братья, сын→сыновья',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g4, true, [
      ['Ýeke san', 'Köplük san', 'Düzgün'],
      ['студент', 'студенты', '+ы'],
      ['банк', 'банки', '+и'],
      ['преподаватель', 'преподаватели', '+и'],
      ['фамилия', 'фамилии', 'ия→ии'],
      ['упражнение', 'упражнения', 'е→я'],
      ['посольство', 'посольства', 'о→а'],
      ['друг', 'друзья ⚠️', 'düzgünsiz!'],
      ['брат', 'братья ⚠️', 'düzgünsiz!'],
      ['мать', 'матери ⚠️', 'düzgünsiz!'],
      ['дочь', 'дочери ⚠️', 'düzgünsiz!'],
    ], redCols: [1]);

    final g4b = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 4, 'table_number': 2,
      'title_ru': 'Таблица 2: Предложный падёж',
      'title_tk': 'Где? düşümi (Предложный падёж)',
      'explanation_tk': 'Предложный падёж nirede bolmak soragyna jogap berýär.',
      'note_tk': 'в we на tapawudy: на заводе, на почте — beýlekileri в!',
      'rule_type': 'table', 'order_index': 2,
    });
    await _insertTableRows(db, g4b, true, [
      ['Nominatiw', 'Где? (Предл. падёж)', 'Öňdelik'],
      ['университет', 'университете', 'в'],
      ['школа', 'школе', 'в'],
      ['больница', 'больнице', 'в'],
      ['банк', 'банке', 'в'],
      ['посольство', 'посольстве', 'в'],
      ['ресторан', 'ресторане', 'в'],
      ['музей', 'музее', 'в'],
      ['завод', 'заводе ⚠️', 'на'],
      ['почта', 'почте ⚠️', 'на'],
    ], redCols: [1]);

    final g4c = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 4, 'table_number': 3,
      'title_ru': 'Таблица 3: работать / учиться',
      'title_tk': 'работать / учиться işlikleri',
      'explanation_tk': 'Häzirki zaman spryaženiýasy.',
      'note_tk': '',
      'rule_type': 'table', 'order_index': 3,
    });
    await _insertTableRows(db, g4c, true, [
      ['Sahyp', 'работать', 'учиться'],
      ['я', 'работаю', 'учусь'],
      ['ты', 'работаешь', 'учишься'],
      ['он/она', 'работает', 'учится'],
      ['мы', 'работаем', 'учимся'],
      ['вы', 'работаете', 'учитесь'],
      ['они', 'работают', 'учатся'],
    ], redCols: [1, 2]);

    // Sapak 5 - Sypatlaryň goşulmalary
    final g5 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 5, 'table_number': 1,
      'title_ru': 'Таблица 1: Окончания прилагательных',
      'title_tk': 'Sypatlaryň goşulmalary',
      'explanation_tk': 'Sypat hemişe sözüň JYNSYNA we SANYNA görä üýtgeýär.',
      'note_tk': 'ой/ый/ий (erkek) | ая/яя (aýal) | ое/ее (orta) | ые/ие (köplük)',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g5, true, [
      ['Erkek (он)', 'Aýal (она)', 'Orta (оно)', 'Köplük (они)'],
      ['новый', 'новая', 'новое', 'новые'],
      ['старый', 'старая', 'старое', 'старые'],
      ['красивый', 'красивая', 'красивое', 'красивые'],
      ['большой', 'большая', 'большое', 'большие'],
      ['маленький', 'маленькая', 'маленькое', 'маленькие'],
      ['русский', 'русская', 'русское', 'русские'],
      ['родной', 'родная', 'родное', 'родные'],
    ], redCols: [0, 1, 2, 3]);

    final g5b = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 5, 'table_number': 2,
      'title_ru': 'Таблица 2: Предложный падёж — Ýurtlar',
      'title_tk': 'Ýurtlar we şäherler üçin Предложный',
      'explanation_tk': '-ия bilen gutarýan ýurtlar → -ии bolýar!',
      'note_tk': 'Испания→в Испании; Россия→в России; Германия→в Германии',
      'rule_type': 'table', 'order_index': 2,
    });
    await _insertTableRows(db, g5b, true, [
      ['Ýurt / Şäher', 'Где? (Предл. падёж)', 'Düzgün'],
      ['Испания', 'в Испании', '-ия→-ии'],
      ['Россия', 'в России', '-ия→-ии'],
      ['Германия', 'в Германии', '-ия→-ии'],
      ['Англия', 'в Англии', '-ия→-ии'],
      ['Туркменистан', 'в Туркменистане', '-н→-не'],
      ['Ашхабад', 'в Ашхабаде', '-д→-де'],
      ['Китай', 'в Китае', '-й→-е'],
      ['Мары / США', 'в Мары / в США', 'üýtgemeýär'],
    ], redCols: [1]);

    final g5c = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 5, 'table_number': 3,
      'title_ru': 'Таблица 3: Глагол жить',
      'title_tk': 'жить işligi — häzirki we geçen zaman',
      'explanation_tk': 'Geçen zamanda işlikler adamyň jynsyna görä üýtgeýär.',
      'note_tk': '',
      'rule_type': 'table', 'order_index': 3,
    });
    await _insertTableRows(db, g5c, true, [
      ['Sahyp', 'Häzirki zaman', 'Geçen zaman (erkek)', 'Geçen zaman (aýal)'],
      ['я', 'живу', 'жил', 'жила'],
      ['ты', 'живёшь', 'жил', 'жила'],
      ['он/она', 'живёт', 'жил', 'жила'],
      ['мы', 'живём', 'жили', 'жили'],
      ['вы', 'живёте', 'жили', 'жили'],
      ['они', 'живут', 'жили', 'жили'],
    ], redCols: [1, 2, 3]);

    // Sapak 6 - Täze işlikler
    final g6 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 6, 'table_number': 1,
      'title_ru': 'Таблица 1: Новые глаголы',
      'title_tk': 'Täze işlikler — häzirki zaman',
      'explanation_tk': 'говорить, читать, писать, понимать, думать, изучать, мочь işlikleri.',
      'note_tk': 'мочь işliginiň spryaženiýasy düzgünsiz — ýatda saklaň!',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g6, true, [
      ['Sahyp', 'говорить', 'читать', 'писать', 'понимать', 'мочь'],
      ['я', 'говорю', 'читаю', 'пишу', 'понимаю', 'могу'],
      ['ты', 'говоришь', 'читаешь', 'пишешь', 'понимаешь', 'можешь'],
      ['он/она', 'говорит', 'читает', 'пишет', 'понимает', 'может'],
      ['мы', 'говорим', 'читаем', 'пишем', 'понимаем', 'можем'],
      ['вы', 'говорите', 'читаете', 'пишете', 'понимаете', 'можете'],
      ['они', 'говорят', 'читают', 'пишут', 'понимают', 'могут'],
    ], redCols: [1, 2, 3, 4, 5]);

    final g6b = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 6, 'table_number': 2,
      'title_ru': 'Таблица 2: Geçen zaman',
      'title_tk': 'Geçen zaman işlikleri',
      'explanation_tk': 'Geçen zamanda işlik adamyň jynsyna görä üýtgeýär: -л (erkek), -ла (aýal), -ли (köplük).',
      'note_tk': '',
      'rule_type': 'table', 'order_index': 2,
    });
    await _insertTableRows(db, g6b, true, [
      ['Işlik', 'Erkek (-л)', 'Aýal (-ла)', 'Köplük (-ли)'],
      ['говорить', 'говорил', 'говорила', 'говорили'],
      ['читать', 'читал', 'читала', 'читали'],
      ['писать', 'писал', 'писала', 'писали'],
      ['понимать', 'понимал', 'понимала', 'понимали'],
      ['изучать', 'изучал', 'изучала', 'изучали'],
      ['мочь', 'мог', 'могла', 'могли'],
    ], redCols: [1, 2, 3]);

    // Sapak 7 - işlikler -ать/-ять/-ить/-еть
    final g7 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 7, 'table_number': 1,
      'title_ru': 'Таблица 1: Глаголы -ать/-ять',
      'title_tk': '-ать/-ять spryaženiýasy',
      'explanation_tk': 'делать, отдыхать, гулять, играть, слушать, знать — bir düzgüne görä.',
      'note_tk': '',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g7, true, [
      ['Sahyp', 'делать', 'гулять', 'играть', 'знать', 'слушать'],
      ['я', 'делаю', 'гуляю', 'играю', 'знаю', 'слушаю'],
      ['ты', 'делаешь', 'гуляешь', 'играешь', 'знаешь', 'слушаешь'],
      ['он/она', 'делает', 'гуляет', 'играет', 'знает', 'слушает'],
      ['мы', 'делаем', 'гуляем', 'играем', 'знаем', 'слушаем'],
      ['вы', 'делаете', 'гуляете', 'играете', 'знаете', 'слушаете'],
      ['они', 'делают', 'гуляют', 'играют', 'знают', 'слушают'],
    ], redCols: [1, 2, 3, 4, 5]);

    final g7b = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 7, 'table_number': 2,
      'title_ru': 'Таблица 2: Глаголы -еть/-ить + хотеть',
      'title_tk': '-еть/-ить spryaženiýasy + хотеть',
      'explanation_tk': 'смотреть, любить, помнить işlikleri we düzgünsiz хотеть.',
      'note_tk': 'хотеть işliginiň spryaženiýasy iki ösümli — ýatda saklaň!',
      'rule_type': 'table', 'order_index': 2,
    });
    await _insertTableRows(db, g7b, true, [
      ['Sahyp', 'смотреть', 'любить', 'помнить', 'хотеть'],
      ['я', 'смотрю', 'люблю', 'помню', 'хочу'],
      ['ты', 'смотришь', 'любишь', 'помнишь', 'хочешь'],
      ['он/она', 'смотрит', 'любит', 'помнит', 'хочет'],
      ['мы', 'смотрим', 'любим', 'помним', 'хотим'],
      ['вы', 'смотрите', 'любите', 'помните', 'хотите'],
      ['они', 'смотрят', 'любят', 'помнят', 'хотят'],
    ], redCols: [1, 2, 3, 4]);

    // Sapak 8 - Garşylykly sypatlary
    final g8 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 8, 'table_number': 1,
      'title_ru': 'Таблица 1: Прилагательные — 4 формы',
      'title_tk': 'Sypatlaryň 4 görnüşi',
      'explanation_tk': 'Her sypatyň erkek, aýal, orta we köplük görnüşi bar.',
      'note_tk': 'горячий, лёгкий, хороший, последний — -ий/-ее/-ие üýtgeşmesine üns ber!',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g8, true, [
      ['Erkek (-ой/-ый/-ий)', 'Aýal (-ая/-яя)', 'Orta (-ое/-ее)', 'Köplük (-ые/-ие)'],
      ['новый', 'новая', 'новое', 'новые'],
      ['молодой', 'молодая', 'молодое', 'молодые'],
      ['дорогой', 'дорогая', 'дорогое', 'дорогие'],
      ['богатый', 'богатая', 'богатое', 'богатые'],
      ['холодный', 'холодная', 'холодное', 'холодные'],
      ['горячий', 'горячая', 'горячее', 'горячие'],
      ['хороший', 'хорошая', 'хорошее', 'хорошие'],
      ['лёгкий', 'лёгкая', 'лёгкое', 'лёгкие'],
      ['последний', 'последняя', 'последнее', 'последние'],
    ], redCols: [0, 1, 2, 3]);

    // Sapak 9 - Hepde günleri + Sagat
    final g9 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 9, 'table_number': 1,
      'title_ru': 'Таблица 1: Дни недели',
      'title_tk': 'Hepde günleri — Когда? soragy',
      'explanation_tk': 'Hepde günleri Когда? soragyna jogap berýär — Винительный падёж.',
      'note_tk': 'среда→в среду, пятница→в пятницу, суббота→в субботу (а→у!) | вторник→во вторник (во!)',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g9, true, [
      ['Hepde güni', 'Türkmençe', 'Когда? (düşüm)'],
      ['понедельник', 'duşenbe', 'в понедельник'],
      ['вторник', 'sişenbe', 'во вторник ⚠️'],
      ['среда', 'çarşenbe', 'в среду ⚠️'],
      ['четверг', 'penşenbe', 'в четверг'],
      ['пятница', 'anna', 'в пятницу ⚠️'],
      ['суббота', 'şenbe', 'в субботу ⚠️'],
      ['воскресенье', 'ýekşenbe', 'в воскресенье'],
    ], redCols: [2]);

    final g9b = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 9, 'table_number': 2,
      'title_ru': 'Таблица 2: Sagat aýtmak',
      'title_tk': 'Sagat aýtmak — час düşümleri',
      'explanation_tk': '1 — один час; 2/3/4 — два/три/четыре часа; 5-12 — часов.',
      'note_tk': 'Günüň bölümleri Родительный падёжde: утра, дня, вечера, ночи.',
      'rule_type': 'table', 'order_index': 2,
    });
    await _insertTableRows(db, g9b, true, [
      ['Rakam', 'Час görnüşi', 'Mysal'],
      ['1', 'один час', 'Сейчас один час.'],
      ['2, 3, 4', 'два/три/четыре часа', 'Сейчас два часа.'],
      ['5–20', 'пять…часов', 'Сейчас пять часов.'],
      ['Günüň bölümi', 'Родительный падёж', 'Mysal'],
      ['утро', 'утра', '8 часов утра'],
      ['день', 'дня', '2 часа дня'],
      ['вечер', 'вечера', '8 часов вечера'],
      ['ночь', 'ночи', '1 час ночи'],
    ], redCols: [1]);

    final g9c = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 9, 'table_number': 3,
      'title_ru': 'Таблица 3: Наhar işlikleri',
      'title_tk': 'завтракать / обедать / ужинать / спать',
      'explanation_tk': 'Nahar işlikleriniň spryaženiýasy.',
      'note_tk': '',
      'rule_type': 'table', 'order_index': 3,
    });
    await _insertTableRows(db, g9c, true, [
      ['Sahyp', 'завтракать', 'обедать', 'ужинать', 'спать'],
      ['я', 'завтракаю', 'обедаю', 'ужинаю', 'сплю'],
      ['ты', 'завтракаешь', 'обедаешь', 'ужинаешь', 'спишь'],
      ['он/она', 'завтракает', 'обедает', 'ужинает', 'спит'],
      ['мы', 'завтракаем', 'обедаем', 'ужинаем', 'спим'],
      ['вы', 'завтракаете', 'обедаете', 'ужинаете', 'спите'],
      ['они', 'завтракают', 'обедают', 'ужинают', 'спят'],
    ], redCols: [1, 2, 3, 4]);

    // Sapak 10 - täze işlikler + Куда vs Где
    final g10 = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 10, 'table_number': 1,
      'title_ru': 'Таблица 1: Новые глаголы',
      'title_tk': 'Täze işlikler — вставать, идти, готовить...',
      'explanation_tk': 'вставать, заниматься, готовить, бегать, принимать, чистить, идти işlikleri.',
      'note_tk': 'идти işliginiň geçen zamany: шёл (erkek), шла (aýal), шли (köplük).',
      'rule_type': 'table', 'order_index': 1,
    });
    await _insertTableRows(db, g10, true, [
      ['Sahyp', 'вставать', 'идти', 'готовить', 'бегать', 'заниматься'],
      ['я', 'встаю', 'иду', 'готовлю', 'бегаю', 'занимаюсь'],
      ['ты', 'встаёшь', 'идёшь', 'готовишь', 'бегаешь', 'занимаешься'],
      ['он/она', 'встаёт', 'идёт', 'готовит', 'бегает', 'занимается'],
      ['мы', 'встаём', 'идём', 'готовим', 'бегаем', 'занимаемся'],
      ['вы', 'встаёте', 'идёте', 'готовите', 'бегаете', 'занимаетесь'],
      ['они', 'встают', 'идут', 'готовят', 'бегают', 'занимаются'],
    ], redCols: [1, 2, 3, 4, 5]);

    final g10b = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 10, 'table_number': 2,
      'title_ru': 'Таблица 2: Куда? vs Где?',
      'title_tk': 'Куда? (Nirä?) vs Где? (Nirede?)',
      'explanation_tk': 'Куда? — hareket ugry (Винительный). Где? — ýer (Предложный).',
      'note_tk': 'школа, больница, работа: Где? → е; Куда? → у! | дом → дома vs домой',
      'rule_type': 'table', 'order_index': 2,
    });
    await _insertTableRows(db, g10b, true, [
      ['At', 'Где? (Предл.)', 'Куда? (Вин.)'],
      ['университет', 'в университете', 'в университет'],
      ['школа', 'в школе', 'в школу ⚠️'],
      ['больница', 'в больнице', 'в больницу ⚠️'],
      ['работа', 'на работе', 'на работу ⚠️'],
      ['магазин', 'в магазине', 'в магазин'],
      ['парк', 'в парке', 'в парк'],
      ['дом', 'дома', 'домой ⚠️'],
    ], redCols: [1, 2]);

    final g10c = await db.insert(DbConstants.tGrammarRules, {
      'lesson_id': 10, 'table_number': 3,
      'title_ru': 'Таблица 3: Günüň bölümleri',
      'title_tk': 'Günüň bölümleri — Творительный падёж',
      'explanation_tk': 'Haçan? soragy Творительный падёžde: утром, днём, вечером, ночью.',
      'note_tk': 'Sagat bilen → Родительный: 8 часов утра, 2 часа дня...',
      'rule_type': 'table', 'order_index': 3,
    });
    await _insertTableRows(db, g10c, true, [
      ['Bölüm', 'Haçan? (Творит.)', 'Sagat bilen (Родит.)'],
      ['утро', 'утром', 'утра'],
      ['день', 'днём', 'дня'],
      ['вечер', 'вечером', 'вечера'],
      ['ночь', 'ночью', 'ночи'],
    ], redCols: [1, 2]);
  }

  static Future<void> _insertTableRows(
    Database db,
    int grammarId,
    bool firstIsHeader,
    List<List<String>> rows,
    {required List<int> redCols}
  ) async {
    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];
      final isHeader = firstIsHeader && i == 0;
      final cells = List.filled(7, '');
      for (int j = 0; j < row.length && j < 7; j++) {
        cells[j] = row[j];
      }
      await db.insert(DbConstants.tGrammarTableRows, {
        'grammar_id': grammarId,
        'row_order': i,
        'is_header': isHeader ? 1 : 0,
        'cell_1': cells[0], 'cell_2': cells[1], 'cell_3': cells[2],
        'cell_4': cells[3], 'cell_5': cells[4], 'cell_6': cells[5],
        'cell_7': cells[6],
        'red_cells': redCols.isEmpty ? '' : redCols.join(','),
      });
    }
  }

  // ─────────────────────────────────────────────────────────
  // EXERCISES
  // ─────────────────────────────────────────────────────────
  static Future<void> _seedExercises(Database db) async {
    // SAPAK 1 - Ýumuş 1: Boş ýerleri doldur
    final e1_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 1, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — Boş ýerleri doldur',
      'instruction_tk': 'Dogry sözi boş ýere goy.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 1,
    });
    final q1_1 = await _insertQuestion(db, e1_1, '_______, Aýna!', 'Привет', 1, 'Salam berme sözi');
    await _insertOptions(db, q1_1, ['Привет', 'Пока', 'Спасибо', 'Нормально'], 'Привет');
    final q1_2 = await _insertQuestion(db, e1_1, 'Добрый _______, Merdan!', 'день', 2, 'Günüň bölümi');
    await _insertOptions(db, q1_2, ['день', 'утро', 'вечер', 'ночь'], 'день');
    final q1_3 = await _insertQuestion(db, e1_1, 'Как _______ тебя дела?', 'у', 3, 'Öňdelik');
    await _insertOptions(db, q1_3, ['у', 'в', 'на', 'с'], 'у');
    final q1_4 = await _insertQuestion(db, e1_1, '_______ у вас?', 'А', 4, null);
    await _insertOptions(db, q1_4, ['А', 'И', 'Но', 'Или'], 'А');
    final q1_5 = await _insertQuestion(db, e1_1, 'Тоже _______.', 'нормально', 5, null);
    await _insertOptions(db, q1_5, ['нормально', 'хорошо', 'плохо', 'отлично'], 'нормально');
    final q1_6 = await _insertQuestion(db, e1_1, '_______, отлично.', 'Спасибо', 6, null);
    await _insertOptions(db, q1_6, ['Спасибо', 'Пожалуйста', 'Привет', 'Пока'], 'Спасибо');
    final q1_7 = await _insertQuestion(db, e1_1, 'Как вас _______?', 'зовут', 7, null);
    await _insertOptions(db, q1_7, ['зовут', 'есть', 'живут', 'знают'], 'зовут');
    final q1_8 = await _insertQuestion(db, e1_1, '_______, хорошо. А у тебя?', 'Спасибо', 8, null);
    await _insertOptions(db, q1_8, ['Спасибо', 'Пока', 'Привет', 'Ладно'], 'Спасибо');

    // SAPAK 1 - Ýumuş 2: Меня зовут → üýtget
    final e1_2 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 1, 'exercise_number': 2,
      'title_tk': 'Ýumuş 2 — Üýtget: Меня зовут nusgasy',
      'instruction_tk': 'Mysala görä üýtgediň.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 2,
    });
    await _insertQuestion(db, e1_2, 'Я Döwlet. → _______ зовут Döwlet.', 'Меня', 1, 'я → меня');
    await _insertQuestion(db, e1_2, 'Ты Aýna. → _______ зовут Aýna.', 'Тебя', 2, 'ты → тебя');
    await _insertQuestion(db, e1_2, 'Он Merdan. → _______ зовут Merdan.', 'Его', 3, 'он → его');
    await _insertQuestion(db, e1_2, 'Она Gülnar. → _______ зовут Gülnar.', 'Её', 4, 'она → её');
    await _insertQuestion(db, e1_2, 'Мы Jeren и Döwlet. → _______ зовут Jeren и Döwlet.', 'Нас', 5, 'мы → нас');
    await _insertQuestion(db, e1_2, 'Вы Serdar. → _______ зовут Serdar.', 'Вас', 6, 'вы → вас');
    await _insertQuestion(db, e1_2, 'Они Leýla и Bегзат. → _______ зовут Leýla и Bегзат.', 'Их', 7, 'они → их');
    await _insertQuestion(db, e1_2, 'Я Nurmuhammet. → _______ зовут Nurmuhammet.', 'Меня', 8, 'я → меня');

    // SAPAK 1 - Ýumuş 3: Flashcard üçin söz joýy
    final e1_3 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 1, 'exercise_number': 3,
      'title_tk': 'Ýumuş 3 — Flash kartlar: Sözler',
      'instruction_tk': 'Flash kartlary öwren.',
      'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 3,
    });
    await _insertQuestion(db, e1_3, 'Привет!', 'Salam! (resmi däl)', 1, null);
    await _insertQuestion(db, e1_3, 'Добрый день!', 'Günüň haýyrly!', 2, null);
    await _insertQuestion(db, e1_3, 'Как дела?', 'Işleriň nähili?', 3, null);
    await _insertQuestion(db, e1_3, 'хорошо', 'gowy', 4, null);
    await _insertQuestion(db, e1_3, 'спасибо', 'sag boluň / sag bol', 5, null);
    await _insertQuestion(db, e1_3, 'пока', 'hoş gal (resmi däl)', 6, null);
    await _insertQuestion(db, e1_3, 'Меня зовут…', 'Meniň adym…', 7, null);
    await _insertQuestion(db, e1_3, 'Как вас зовут?', 'Adyňyz näme?', 8, null);

    // SAPAK 2 exercises
    final e2_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 2, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — Sözleriň jynsyny kesgitle (он/она/оно)',
      'instruction_tk': 'Sözleriň jynsyny догры belläň.',
      'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 1,
    });
    for (final entry in [
      ['студент', 'он'], ['книга', 'она'], ['имя', 'оно'],
      ['день', 'он'], ['вечер', 'он'], ['утро', 'оно'],
      ['фамилия', 'она'], ['вопрос', 'он'], ['преподаватель', 'он'],
      ['упражнение', 'оно'], ['мать', 'она'], ['подруга', 'она'],
    ]) {
      final q = await _insertQuestion(db, e2_1, '${entry[0]} → ?', entry[1], 0, null);
      await _insertOptions(db, q, ['он', 'она', 'оно'], entry[1]);
    }

    final e2_2 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 2, 'exercise_number': 2,
      'title_tk': 'Ýumuş 2 — Меня зовут üýtgediş',
      'instruction_tk': 'Mysala görä üýtgediň.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 2,
    });
    await _insertQuestion(db, e2_2, 'Я Döwlet. → _______ зовут Döwlet.', 'Меня', 1, null);
    await _insertQuestion(db, e2_2, 'Ты Aýna. → _______ зовут Aýna.', 'Тебя', 2, null);
    await _insertQuestion(db, e2_2, 'Он Merdan. → _______ зовут Merdan.', 'Его', 3, null);
    await _insertQuestion(db, e2_2, 'Она Gülnar. → _______ зовут Gülnar.', 'Её', 4, null);
    await _insertQuestion(db, e2_2, 'Мы Jeren и Döwlet. → _______ зовут...', 'Нас', 5, null);
    await _insertQuestion(db, e2_2, 'Вы Serdar. → _______ зовут Serdar.', 'Вас', 6, null);
    await _insertQuestion(db, e2_2, 'Они Leýla и Bегзат. → _______ зовут...', 'Их', 7, null);

    final e2_6 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 2, 'exercise_number': 6,
      'title_tk': 'Ýumuş 6 — Eýelik çalyşmalary',
      'instruction_tk': 'Dogry çalyşmany saýla.',
      'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3,
    });
    for (final entry in [
      ['_______ дом (я)', 'мой'], ['_______ подруга (я)', 'моя'],
      ['_______ имя (я)', 'моё'], ['_______ студент (ты)', 'твой'],
      ['_______ фамилия (ты)', 'твоя'], ['_______ отчество (ты)', 'твоё'],
      ['_______ преподаватель (мы)', 'наш'], ['_______ студентка (мы)', 'наша'],
      ['_______ утро (мы)', 'наше'], ['_______ вопрос (вы)', 'ваш'],
      ['_______ книга (вы)', 'ваша'], ['_______ упражнение (вы)', 'ваше'],
    ]) {
      final q = await _insertQuestion(db, e2_6, entry[0], entry[1], 0, null);
      await _insertOptions(db, q, ['мой', 'моя', 'моё', 'твой', 'твоя', 'наш', 'наша', 'ваш', 'ваша', 'ваше']
          .where((o) => o == entry[1] || o != entry[1]).take(4).toList(), entry[1]);
    }

    // SAPAK 4 exercises
    final e4_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 4, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — Işligiň dogry görnüşini ýaz',
      'instruction_tk': 'работать ýa-da учиться işliginiň dogry görnüşini saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 1,
    });
    for (final entry in [
      ['Я _______ (учиться) в университете.', 'учусь'],
      ['Где ты _______ (работать)?', 'работаешь'],
      ['Мы _______ (работать) в магазине.', 'работаем'],
      ['Вы _______ (работать) в банке?', 'работаете'],
      ['Где они _______ (учиться)? В школе.', 'учатся'],
      ['Где она _______ (учиться)? В университете.', 'учится'],
    ]) {
      final q = await _insertQuestion(db, e4_1, entry[0], entry[1], 0, null);
      await _insertOptions(db, q, _getVerbOptions('работать/учиться', entry[1]), entry[1]);
    }

    final e4_2 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 4, 'exercise_number': 2,
      'title_tk': 'Ýumuş 2 — Предложный падёж',
      'instruction_tk': 'Sözleri Предложный падёжde ýaz.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 2,
    });
    await _insertQuestion(db, e4_2, 'Мой друг учится в _______ (университет).', 'университете', 1, '+е goşulmasy');
    await _insertQuestion(db, e4_2, 'Его подруга работает на _______ (почта).', 'почте', 2, 'а→е | на!');
    await _insertQuestion(db, e4_2, 'Моя подруга работает в _______ (банк).', 'банке', 3, '+е goşulmasy');
    await _insertQuestion(db, e4_2, 'Мой отец работает в _______ (посольство).', 'посольстве', 4, 'о→е goşulmasy');
    await _insertQuestion(db, e4_2, 'Брат работает на _______ (завод).', 'заводе', 5, '+е | на!');
    await _insertQuestion(db, e4_2, 'Дядя работает в _______ (музей).', 'музее', 6, 'й→е');

    // SAPAK 5 exercises
    final e5_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 5, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — жить işligi',
      'instruction_tk': 'жить işligini dogry görnüşde ýaz.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 1,
    });
    await _insertQuestion(db, e5_1, 'Сейчас я _______ в Ашхабаде.', 'живу', 1, 'я → живу');
    await _insertQuestion(db, e5_1, 'Раньше я _______ в Мары.', 'жил/жила', 2, 'geçen zaman');
    await _insertQuestion(db, e5_1, 'Сейчас Gülnar _______ в России.', 'живёт', 3, 'она → живёт');
    await _insertQuestion(db, e5_1, 'Раньше мы _______ в Ашхабаде.', 'жили', 4, 'мы → жили');
    await _insertQuestion(db, e5_1, 'Döwlet раньше _______ в Англии.', 'жил', 5, 'он → жил');
    await _insertQuestion(db, e5_1, 'Мои друзья сейчас _______ в Италии.', 'живут', 6, 'они → живут');

    final e5_2 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 5, 'exercise_number': 2,
      'title_tk': 'Ýumuş 2 — Предложный падёж: Ýurtlar',
      'instruction_tk': 'Ýurtlary Предложный падёžde ýaz.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 2,
    });
    await _insertQuestion(db, e5_2, 'Pedro живёт в _______ (Испания).', 'Испании', 1, '-ия → -ии');
    await _insertQuestion(db, e5_2, 'Wan живёт в _______ (Китай).', 'Китае', 2, '-й → -е');
    await _insertQuestion(db, e5_2, 'Вы живёте в _______ (Англия).', 'Англии', 3, '-ия → -ии');
    await _insertQuestion(db, e5_2, 'Ты живёшь во _______ (Франция).', 'Франции', 4, '-ия → -ии | во!');
    await _insertQuestion(db, e5_2, 'Он живёт в _______ (Германия).', 'Германии', 5, '-ия → -ии');

    final e5_3 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 5, 'exercise_number': 3,
      'title_tk': 'Ýumuş 3 — Sypatlaryň goşulmalary',
      'instruction_tk': 'Dogry goşulmany goy.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 3,
    });
    await _insertQuestion(db, e5_3, 'больш_____ дом (он)', 'ой', 1, 'erkek: -ой');
    await _insertQuestion(db, e5_3, 'нов_____ завод (он)', 'ый', 2, 'erkek: -ый');
    await _insertQuestion(db, e5_3, 'красив_____ жена (она)', 'ая', 3, 'aýal: -ая');
    await _insertQuestion(db, e5_3, 'стар_____ почта (она)', 'ая', 4, 'aýal: -ая');
    await _insertQuestion(db, e5_3, 'больш_____ университеты (они)', 'ие', 5, 'köplük: -ие');
    await _insertQuestion(db, e5_3, 'нов_____ слово (оно)', 'ое', 6, 'orta: -ое');
    await _insertQuestion(db, e5_3, 'маленьк_____ страна (она)', 'ая', 7, 'aýal: -ая');
    await _insertQuestion(db, e5_3, 'родн_____ город (он)', 'ой', 8, 'erkek: -ой');

    // SAPAK 6 exercises
    final e6_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 6, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — Işligiň dogry görnüşi (häzirki+geçen)',
      'instruction_tk': 'Dogry görnüşi goy.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 1,
    });
    await _insertQuestion(db, e6_1, 'Раньше Döwlet плохо _______ (говорить) по-английски.', 'говорил', 1, 'geçen zaman, erkek');
    await _insertQuestion(db, e6_1, 'Сейчас Döwlet хорошо _______ (говорить) по-английски.', 'говорит', 2, 'häzirki zaman, он');
    await _insertQuestion(db, e6_1, 'Раньше Gülnar ничего не _______ (понимать) по-французски.', 'понимала', 3, 'geçen zaman, aýal');
    await _insertQuestion(db, e6_1, 'Сейчас они _______ (писать) по-немецки отлично.', 'пишут', 4, 'häzirki zaman, они');
    await _insertQuestion(db, e6_1, 'Раньше я _______ (изучать) испанский.', 'изучал/изучала', 5, 'geçen zaman');
    await _insertQuestion(db, e6_1, 'Сейчас я _______ (изучать) немецкий.', 'изучаю', 6, 'häzirki zaman, я');
    await _insertQuestion(db, e6_1, 'Я _______ (мочь) говорить по-туркменски.', 'могу', 7, 'я → могу');

    final e6_5 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 6, 'exercise_number': 5,
      'title_tk': 'Ýumuş 5 — учиться ýa-da изучать?',
      'instruction_tk': 'учиться (Где?) ýa-da изучать (Что?) saýla.',
      'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2,
    });
    for (final entry in [
      ['Моя сестра _______ в институте.', 'учится'],
      ['Она _______ немецкий язык.', 'изучает'],
      ['Ты работаешь или _______?', 'учишься'],
      ['Мы _______ испанский в университете.', 'изучаем'],
      ['Вы _______ в институте?', 'учитесь'],
      ['Что твои дети _______?', 'изучают'],
    ]) {
      final q = await _insertQuestion(db, e6_5, entry[0], entry[1], 0, null);
      await _insertOptions(db, q, ['учусь', 'учишься', 'учится', 'учимся', 'учитесь', 'учатся',
          'изучаю', 'изучаешь', 'изучает', 'изучаем', 'изучаете', 'изучают']
          .where((o) => o.startsWith(entry[1].substring(0, 4))).take(4).toList(), entry[1]);
    }

    // SAPAK 7 exercises
    final e7_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 7, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — Häzirki zaman işlikleri',
      'instruction_tk': 'Işligiň häzirki zaman görnüşini ýaz.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 1,
    });
    await _insertQuestion(db, e7_1, 'Мой дедушка _______ (гулять) в парке.', 'гуляет', 1, 'он → гуляет');
    await _insertQuestion(db, e7_1, 'Она _______ (знать) это слово.', 'знает', 2, 'она → знает');
    await _insertQuestion(db, e7_1, 'Он не _______ (помнить) моё имя.', 'помнит', 3, 'он → помнит');
    await _insertQuestion(db, e7_1, 'Музыкант _______ (играть) в ресторане.', 'играет', 4, 'он → играет');
    await _insertQuestion(db, e7_1, 'Дети сейчас _______ (смотреть) телевизор.', 'смотрят', 5, 'они → смотрят');
    await _insertQuestion(db, e7_1, 'Студентка _______ (любить) изучать языки.', 'любит', 6, 'она → любит');
    await _insertQuestion(db, e7_1, 'Мы _______ (хотеть) говорить по-английски.', 'хотим', 7, 'мы → хотим');

    final e7_2 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 7, 'exercise_number': 2,
      'title_tk': 'Ýumuş 2 — Geçen zaman işlikleri',
      'instruction_tk': 'Işligiň geçen zaman görnüşini ýaz.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 2,
    });
    await _insertQuestion(db, e7_2, 'Aýna, вчера ты _______ (делать) домашнее задание?', 'делала', 1, 'ты (aýal) → делала');
    await _insertQuestion(db, e7_2, 'Раньше мы плохо _______ (знать) русский язык.', 'знали', 2, 'мы → знали');
    await _insertQuestion(db, e7_2, 'Вчера Merdan _______ (отдыхать) в парке.', 'отдыхал', 3, 'он → отдыхал');
    await _insertQuestion(db, e7_2, 'Раньше моя сестра _______ (изучать) китайский язык.', 'изучала', 4, 'она → изучала');
    await _insertQuestion(db, e7_2, 'Вчера они не _______ (хотеть) смотреть телевизор.', 'хотели', 5, 'они → хотели');

    // SAPAK 8 exercises
    final e8_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 8, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — Sypat goşulmalaryny doldur',
      'instruction_tk': 'Dogry goşulmany goy.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 1,
    });
    await _insertQuestion(db, e8_1, 'стар_____ дом (он)', 'ый', 1, 'erkek: -ый');
    await _insertQuestion(db, e8_1, 'стар_____ слово (оно)', 'ое', 2, 'orta: -ое');
    await _insertQuestion(db, e8_1, 'стар_____ книга (она)', 'ая', 3, 'aýal: -ая');
    await _insertQuestion(db, e8_1, 'стар_____ друзья (они)', 'ые', 4, 'köplük: -ые');
    await _insertQuestion(db, e8_1, 'последн_____ день (он)', 'ий', 5, 'erkek: -ий');
    await _insertQuestion(db, e8_1, 'последн_____ ночь (она)', 'яя', 6, 'aýal: -яя');
    await _insertQuestion(db, e8_1, 'горяч_____ чай (он)', 'ий', 7, 'erkek: -ий');
    await _insertQuestion(db, e8_1, 'горяч_____ вода (она)', 'ая', 8, 'aýal: -ая');
    await _insertQuestion(db, e8_1, 'горяч_____ молоко (оно)', 'ее', 9, 'orta: -ее');
    await _insertQuestion(db, e8_1, 'хорош_____ фильм (он)', 'ий', 10, 'erkek: -ий');

    final e8_3 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 8, 'exercise_number': 3,
      'title_tk': 'Ýumuş 3 — Garşylykly sypaty ýaz',
      'instruction_tk': 'Soragy garşylykly sypat bilen jogapla.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 2,
    });
    await _insertQuestion(db, e8_3, 'Это холодный чай? → Нет, это _______ чай.', 'горячий', 1, 'garşylygy: горячий');
    await _insertQuestion(db, e8_3, 'Это дешёвый дом? → Нет, это _______ дом.', 'дорогой', 2, 'garşylygy: дорогой');
    await _insertQuestion(db, e8_3, 'Это лёгкая работа? → Нет, это _______ работа.', 'трудная', 3, 'aýal: трудная');
    await _insertQuestion(db, e8_3, 'Это молодой человек? → Нет, это _______ человек.', 'старый', 4, 'garşylygy: старый');
    await _insertQuestion(db, e8_3, 'Это первый урок? → Нет, это _______ урок.', 'последний', 5, 'garşylygy: последний');
    await _insertQuestion(db, e8_3, 'Это длинная улица? → Нет, это _______ улица.', 'короткая', 6, 'aýal: короткая');

    final e8_5 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 8, 'exercise_number': 5,
      'title_tk': 'Ýumuş 5 — Gykylyma sözlemleri düz',
      'instruction_tk': 'Mysala görä gykylyma sözlem düz: Это трудное упражнение. → Какое трудное упражнение!',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 3,
    });
    await _insertQuestion(db, e8_5, 'Это скучная книга. → _______ скучная книга!', 'Какая', 1, 'aýal → Какая');
    await _insertQuestion(db, e8_5, 'Это горячий чай. → _______ горячий чай!', 'Какой', 2, 'erkek → Какой');
    await _insertQuestion(db, e8_5, 'Это длинная война. → _______ длинная война!', 'Какая', 3, 'aýal → Какая');
    await _insertQuestion(db, e8_5, 'Это холодная зима. → _______ холодная зима!', 'Какая', 4, 'aýal → Какая');
    await _insertQuestion(db, e8_5, 'Это маленький дом. → _______ маленький дом!', 'Какой', 5, 'erkek → Какой');
    await _insertQuestion(db, e8_5, 'Это короткое лето. → _______ короткое лето!', 'Какое', 6, 'orta → Какое');

    // SAPAK 9 exercises
    final e9_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 9, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — «час» sözüni dogry görnüşde ýaz',
      'instruction_tk': '1 час | 2/3/4 часа | 5+ часов',
      'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 1,
    });
    for (final entry in [
      ['Сейчас четыре _______ (час) дня.', 'часа'],
      ['Сейчас восемь _______ (час) вечера.', 'часов'],
      ['Сейчас один _______ (час) ночи.', 'час'],
      ['Сейчас десять _______ (час) утра.', 'часов'],
      ['Сейчас три _______ (час) ночи.', 'часа'],
      ['Сейчас двенадцать _______ (час).', 'часов'],
    ]) {
      final q = await _insertQuestion(db, e9_1, entry[0], entry[1], 0, null);
      await _insertOptions(db, q, ['час', 'часа', 'часов'], entry[1]);
    }

    final e9_3 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 9, 'exercise_number': 3,
      'title_tk': 'Ýumuş 3 — Hepde günlerini düşüme geçir',
      'instruction_tk': 'Hepde günlerini Когда? görnüşine geçiriň.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 2,
    });
    await _insertQuestion(db, e9_3, 'Наш секретарь не работает в _______ (суббота).', 'субботу', 1, 'а→у');
    await _insertQuestion(db, e9_3, 'В _______ (понедельник) я изучаю русский.', 'понедельник', 2, 'üýtgemeýär');
    await _insertQuestion(db, e9_3, 'Они учатся в _______ (среда).', 'среду', 3, 'а→у');
    await _insertQuestion(db, e9_3, 'Они учатся в _______ (пятница).', 'пятницу', 4, 'а→у');
    await _insertQuestion(db, e9_3, 'Во _______ (вторник) мы ужинали в ресторане.', 'вторник', 5, 'во!');
    await _insertQuestion(db, e9_3, 'В _______ (воскресенье) я отдыхаю.', 'воскресенье', 6, 'üýtgemeýär');

    final e9_7 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 9, 'exercise_number': 7,
      'title_tk': 'Ýumuş 7 — Işlikleri doldur',
      'instruction_tk': 'Işligiň dogry görnüşini ýaz.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 3,
    });
    await _insertQuestion(db, e9_7, 'Во сколько ты обычно _______ (завтракать)?', 'завтракаешь', 1, 'ты → завтракаешь');
    await _insertQuestion(db, e9_7, 'Вчера он _______ (обедать) в ресторане.', 'обедал', 2, 'geçen zaman, он');
    await _insertQuestion(db, e9_7, 'Они обычно _______ (ужинать) дома?', 'ужинают', 3, 'они → ужинают');
    await _insertQuestion(db, e9_7, 'Мы обычно _______ (спать) в 11.', 'спим', 4, 'мы → спим');
    await _insertQuestion(db, e9_7, 'Раньше мы _______ (обедать) в ресторане.', 'обедали', 5, 'geçen zaman, мы');

    // SAPAK 10 exercises
    final e10_1 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 10, 'exercise_number': 1,
      'title_tk': 'Ýumuş 1 — заниматься işligi',
      'instruction_tk': 'заниматься işligini doldur.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 1,
    });
    await _insertQuestion(db, e10_1, 'Я _______ (заниматься) спортом утром.', 'занимаюсь', 1, 'я → занимаюсь');
    await _insertQuestion(db, e10_1, 'Мы _______ (заниматься) спортом в парке.', 'занимаемся', 2, 'мы → занимаемся');
    await _insertQuestion(db, e10_1, 'Когда она _______ (заниматься) спортом?', 'занимается', 3, 'она → занимается');
    await _insertQuestion(db, e10_1, 'Вчера он _______ (заниматься) спортом рано утром.', 'занимался', 4, 'geçen zaman, он');
    await _insertQuestion(db, e10_1, 'Они _______ (заниматься) спортом каждый день.', 'занимаются', 5, 'они → занимаются');

    final e10_2 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 10, 'exercise_number': 2,
      'title_tk': 'Ýumuş 2 — Где? vs Куда?',
      'instruction_tk': 'Sözleri dogry düşüme geçir.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 2,
    });
    await _insertQuestion(db, e10_2, 'Merdan работает в _______ (больница).', 'больнице', 1, 'Где? → -е');
    await _insertQuestion(db, e10_2, 'Его жена работает на _______ (почта).', 'почте', 2, 'Где? на почте');
    await _insertQuestion(db, e10_2, 'Сын учится в _______ (школа).', 'школе', 3, 'Где? → -е');
    await _insertQuestion(db, e10_2, 'Каждый день Merdan идёт на _______ (работа).', 'работу', 4, 'Куда? → -у');
    await _insertQuestion(db, e10_2, 'Döwlet идёт в _______ (школа).', 'школу', 5, 'Куда? → -у');
    await _insertQuestion(db, e10_2, 'Aýna идёт _______ (домой).', 'домой', 6, 'Куда? → домой');
    await _insertQuestion(db, e10_2, 'Вечером она идёт в _______ (магазин).', 'магазин', 7, 'Куда? üýtgemeýär');

    final e10_7 = await db.insert(DbConstants.tExercises, {
      'lesson_id': 10, 'exercise_number': 7,
      'title_tk': 'Ýumuş 7 — Ýalňyşy tap we düzet',
      'instruction_tk': 'Her sözlemdäki ýalňyşy tap we düzet.',
      'exercise_type': DbConstants.exerciseFillBlank, 'order_index': 3,
    });
    await _insertQuestion(db, e10_7, 'Завтра мои родители идут в ресторане. (ýalňyş!)', 'в ресторан', 1, 'Куда? → в ресторан');
    await _insertQuestion(db, e10_7, 'В выходные я встаю в 10 часов утром. (ýalňyş!)', 'утра', 2, 'Sagat bilen → утра');
    await _insertQuestion(db, e10_7, 'Раньше его племянник работал в заводе. (ýalňyş!)', 'на заводе', 3, 'завод → на заводе');
    await _insertQuestion(db, e10_7, 'Наша подруга занимает спортом в субботу. (ýalňyş!)', 'занимается', 4, 'занимается!');
    await _insertQuestion(db, e10_7, 'В пятница мы часто ужинаем. (ýalňyş!)', 'В пятницу', 5, 'В пятницу!');
    await _insertQuestion(db, e10_7, 'Вечера он читает журнал. (ýalňyş!)', 'Вечером', 6, 'Haçan? → Вечером');
  }

  static List<String> _getVerbOptions(String verbType, String correct) {
    final opts = {
      'работать/учиться': [
        'работаю', 'работаешь', 'работает', 'работаем', 'работаете', 'работают',
        'учусь', 'учишься', 'учится', 'учимся', 'учитесь', 'учатся',
      ],
    };
    final all = opts[verbType] ?? [correct, 'wrong1', 'wrong2', 'wrong3'];
    final others = all.where((o) => o != correct).toList()..shuffle();
    return ([correct, ...others.take(3)])..shuffle();
  }

  static Future<int> _insertQuestion(
    Database db, int exerciseId, String questionText,
    String correctAnswer, int order, String? hint,
  ) async {
    return db.insert(DbConstants.tExerciseQuestions, {
      'exercise_id': exerciseId,
      'question_order': order,
      'question_text': questionText,
      'correct_answer': correctAnswer,
      'hint_tk': hint,
    });
  }

  static Future<void> _insertOptions(
    Database db, int questionId, List<String> options, String correct,
  ) async {
    // Ensure correct answer is in options
    final allOptions = options.contains(correct) ? options : [correct, ...options];
    final limited = allOptions.take(4).toList();
    if (!limited.contains(correct)) limited[0] = correct;
    limited.shuffle();
    for (final opt in limited) {
      await db.insert(DbConstants.tExerciseOptions, {
        'question_id': questionId,
        'option_text': opt,
        'is_correct': opt == correct ? 1 : 0,
      });
    }
  }

  // ─────────────────────────────────────────────────────────
  // READING TEXTS
  // ─────────────────────────────────────────────────────────
  static Future<void> _seedReadingTexts(Database db) async {
    final texts = [
      {
        'lesson_id': 3,
        'title_ru': 'Моя семья',
        'content_ru': 'Давайте познакомимся! Меня зовут Aýna. Моя фамилия — Amanowa. Это моя семья. Это мой отец. Его зовут Serdar. А это моя мать. Её зовут Ogulgerek. Мой папа и моя мама — это мои родители. А это мой брат. Его зовут Merdan. Это его жена. Её зовут Gülnar. Это их дети: сын Döwlet и дочь Jeren. Döwlet — мой племянник, а Jeren — моя племянница. Я — их тётя. А это моя бабушка и мой дедушка. Я — их внучка, а Merdan — их внук. Вот наш дом. Это наша собака. Его зовут Düýe. А где наша кошка? Вот она!',
      },
      {
        'lesson_id': 4,
        'title_ru': 'Наши профессии',
        'content_ru': 'Здравствуйте! Меня зовут Serdar. Я по профессии — продавец. Я работаю в магазине. Мой отец — инженер, работает на заводе. Моя мать — преподаватель, работает в университете. Моя тётя Leýla — врач, работает в больнице. Мои братья Merdan и Döwlet не работают — учатся в школе. Моя подруга Aýna работает и учится в институте — официантка. А Bегзат работает в музее — гид.',
      },
      {
        'lesson_id': 5,
        'title_ru': 'Наши страны',
        'content_ru': 'Здравствуйте! Меня зовут Ральф. Я немец. Мой родной город — Берлин. Раньше я жил в Берлине, а сейчас живу в Ашхабаде. Моя жена Gülnar — туркменка. Она живёт в Ашхабаде. Раньше она жила в Мары. Мары — красивый город! Ашхабад — тоже красивый и большой. Наш друг Pedro — испанец, живёт в Мадриде. А наша подруга Lily — американка, живёт в Нью-Йорке.',
      },
      {
        'lesson_id': 6,
        'title_ru': 'Языки',
        'content_ru': 'Здравствуйте! Меня зовут Merdan. Мой родной язык — туркменский. Я хорошо говорю по-русски и немного по-английски. Раньше я не понимал по-русски. Потом я изучал русский язык. Сейчас я могу читать, писать и говорить по-русски. Моя сестра Gülnar изучает английский и французский языки. Она отлично говорит по-французски! Я думаю, что французский — красивый язык.',
      },
      {
        'lesson_id': 7,
        'title_ru': 'Наша семья',
        'content_ru': 'Дедушка смотрит телевизор — любит смотреть футбол. А бабушка гуляет в парке. Они пенсионеры. Раньше дедушка работал на заводе, а бабушка — в библиотеке. Брат Serdar учится в университете, сейчас дома — смотрит телевизор и отдыхает. Он изучает английский, читает английские журналы и смотрит фильмы по-английски. Мама — врач, сейчас дома, готовит и слушает радио. Любит слушать старые туркменские песни. А я, Döwlet, делаю домашнее задание. Но хочу смотреть телевизор или играть на улице!',
      },
      {
        'lesson_id': 8,
        'title_ru': 'Ашхабад',
        'content_ru': 'Ашхабад — красивый и большой город. Это новый город — белый и современный. Здесь много новых парков и красивых зданий. В центре города есть большой и старый базар. Там дешёвые и хорошие продукты. Есть дорогие рестораны и дешёвые кафе. Летом в Ашхабаде очень горячо, а зимой холодно. Но туркменцы — добрые и гостеприимные люди. Мне нравится Ашхабад!',
      },
      {
        'lesson_id': 9,
        'title_ru': 'Рабочая неделя',
        'content_ru': 'Меня зовут Döwlet. Я работаю пять дней в неделю: с понедельника по пятницу. В понедельник, среду и пятницу у меня лекции в университете. Обычно я завтракаю в 8 часов утра, обедаю в 2 часа дня и ужинаю в 7 часов вечера. В субботу я не работаю и не учусь. В воскресенье я сплю до 10 часов и гуляю с семьёй в парке. Это хорошая неделя!',
      },
      {
        'lesson_id': 10,
        'title_ru': 'Мой день',
        'content_ru': 'Добрый день. Меня зовут Bегзат. Моя жена и я — пенсионеры. Мы всегда встаём рано — в 7 часов утра. Сначала мы принимаем душ, а потом готовим завтрак. Мы любим завтракать на балконе. Потом мы чистим зубы и идём в парк. В парке мы гуляем или читаем газеты. В час дня мы обычно обедаем дома. Потом я чуть-чуть сплю, а моя жена идёт в магазин. Вечером мы ужинаем и смотрим телевизор. В выходные мы часто ужинаем вместе с сыном Serdar.',
      },
    ];

    for (final text in texts) {
      await db.insert(DbConstants.tReadingTexts, text,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ─────────────────────────────────────────────────────────
  // LESSON PROGRESS (initial)
  // ─────────────────────────────────────────────────────────
  static Future<void> _seedLessonProgress(Database db) async {
    for (int i = 1; i <= 10; i++) {
      await db.insert(DbConstants.tLessonProgress, {
        'lesson_id': i,
        'vocab_studied': 0,
        'dialogs_read': 0,
        'exercises_done': 0,
        'exercises_total': i <= 3 ? 3 : (i <= 6 ? 5 : 7),
        'score_percent': 0.0,
        'is_completed': 0,
        'last_studied': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }
}
