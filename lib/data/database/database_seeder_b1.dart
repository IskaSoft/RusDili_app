import 'package:sqflite/sqflite.dart';
import '../../core/constants/db_constants.dart';

/// B1 Red Kalinka УРОК 21-28, Lesson ID 34-41
/// Ähli text_ru hakyky kirill harplary bilen
/// Adam atlary: Merýem, Azat, Aýna, Kemal, Serdar, Läle, Ogulnur, Oraz, Döwlet, Gülnara
/// Ýerler: Aşgabat, Türkmenabat, Türkmenistan, Hazar deňzi, Garagum
class DatabaseSeederB1 {
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

  static Future<void> _seedLessons(Transaction txn) async {
    final lessons = [
      {'id': 34, 'sapak_number': 34, 'title_ru': 'В ДЕРЕВНЕ И НА ДАЧЕ', 'title_tk': 'Obada we Daçada', 'subtitle_tk': 'Öý bölümleri, gap-gaç, işlikler, Предложный падёж', 'description_tk': 'Öý bölümleri, gap-gaç, işlikler, Предложный падёж.', 'image_path': 'assets/images/lessons/b1_01_dacha.png', 'order_index': 34},
      {'id': 35, 'sapak_number': 35, 'title_ru': 'КУЛЬТУРНАЯ ЖИЗНЬ', 'title_tk': 'Medeni Durmuş', 'subtitle_tk': 'Teatr, kino, konsert, işlik aspektleri НСВ/СВ', 'description_tk': 'Teatr, kino, konsert, işlik aspektleri НСВ/СВ.', 'image_path': 'assets/images/lessons/b1_02_kultura.png', 'order_index': 35},
      {'id': 36, 'sapak_number': 36, 'title_ru': 'СЕМЕЙНЫЙ ПОРТРЕТ', 'title_tk': 'Maşgala Portreti', 'subtitle_tk': 'Daş keşp, maşgala agzalary, Творительный падёж', 'description_tk': 'Daş keşp, maşgala agzalary, Творительный падёж.', 'image_path': 'assets/images/lessons/b1_03_semya.png', 'order_index': 36},
      {'id': 37, 'sapak_number': 37, 'title_ru': 'НАША РОДИНА', 'title_tk': 'Biziň Watanymyz', 'subtitle_tk': 'Döwlet, tebigat baýlyklary, Родительный падёж', 'description_tk': 'Döwlet, tebigat baýlyklary, Родительный падёж.', 'image_path': 'assets/images/lessons/b1_04_rodina.png', 'order_index': 37},
      {'id': 38, 'sapak_number': 38, 'title_ru': 'ЖИВОТНЫЙ МИР', 'title_tk': 'Haýwanat Dünýäsi', 'subtitle_tk': 'Haýwanlar, guşlar, mör-möjekler, Дательный падёж', 'description_tk': 'Haýwanlar, guşlar, mör-möjekler, Дательный падёж.', 'image_path': 'assets/images/lessons/b1_05_zhivotny.png', 'order_index': 38},
      {'id': 39, 'sapak_number': 39, 'title_ru': 'РУССКИЕ ПРАЗДНИКИ', 'title_tk': 'Rus Baýramlary', 'subtitle_tk': 'Baýramlar, sowgatlar, Краткие прилагательные', 'description_tk': 'Baýramlar, sowgatlar, Краткие прилагательные.', 'image_path': 'assets/images/lessons/b1_06_prazdniki.png', 'order_index': 39},
      {'id': 40, 'sapak_number': 40, 'title_ru': 'ВЕЛИКИЕ ЛЮДИ', 'title_tk': 'Beýik Adamlar', 'subtitle_tk': 'Hünärler, ylym we sport, Причастие', 'description_tk': 'Hünärler, ylym we sport, Причастие.', 'image_path': 'assets/images/lessons/b1_07_velikie.png', 'order_index': 40},
      {'id': 41, 'sapak_number': 41, 'title_ru': 'ГЛОБАЛЬНЫЕ ПРОБЛЕМЫ', 'title_tk': 'Global Meseleler', 'subtitle_tk': 'Tebigy heläkçilikler, jemgyýet, Деепричастие', 'description_tk': 'Tebigy heläkçilikler, jemgyýet, Деепричастие.', 'image_path': 'assets/images/lessons/b1_08_global.png', 'order_index': 41},
    ];
    for (final l in lessons) { await txn.insert(DbConstants.tLessons, l, conflictAlgorithm: ConflictAlgorithm.ignore); }
  }

  static Future<void> _seedVocabulary(Transaction txn) async {
    final vocab = [
      {'lesson_id': 34, 'word_ru': 'слесарь', 'word_tk': 'çilikçi usta', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'этаж', 'word_tk': 'gat', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'чердак', 'word_tk': 'üçek aşagy', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'подвал', 'word_tk': 'ýerasty ammar', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'веранда', 'word_tk': 'açyk örtüksiz eýwan', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'баня', 'word_tk': 'rus hammamy', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'посуда', 'word_tk': 'gap-gaç', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'сковорода', 'word_tk': 'gazan / tawa', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'кастрюля', 'word_tk': 'gapakly gazan', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'камин', 'word_tk': 'ojaklyk', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'раковина', 'word_tk': 'sink / ýuwujy', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'микроволновка', 'word_tk': 'mikrodalga peji', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'посудомоечная машина', 'word_tk': 'gap ýuwujy maşyn', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'унитаз', 'word_tk': 'hajathana', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'лестница', 'word_tk': 'basgançak', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'вешалка', 'word_tk': 'eşik ilgyç', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'полотенце', 'word_tk': 'el süpürgüji', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'халат', 'word_tk': 'ýapynjy / halat', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'река', 'word_tk': 'derýa', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'комар', 'word_tk': 'çybyn', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'шашлык', 'word_tk': 'şaşlyk (kebap)', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'лук', 'word_tk': 'sogan', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'перец', 'word_tk': 'burç', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'огурец - огурцы', 'word_tk': 'hyýar - hyýarlar', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'тихий - шумный', 'word_tk': 'asuda - şowhunly', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'чистый - грязный', 'word_tk': 'arassa - hapa', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'свежий', 'word_tk': 'täze / ter', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'замечательный', 'word_tk': 'ajaýyp', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'Угощайтесь!', 'word_tk': 'Iýiň! / Hezil ediň!', 'category': 'b1'},
      {'lesson_id': 34, 'word_ru': 'особенно', 'word_tk': 'aýratynam', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'спектакль', 'word_tk': 'sahna / spektakl', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'партер', 'word_tk': 'aşaky oturgyçly bölüm', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'касса', 'word_tk': 'kassa / bilet satyş', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'скидка', 'word_tk': 'arzanladyş', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'наличные', 'word_tk': 'nagt pul', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'сеанс', 'word_tk': 'seans / görkeziş wagty', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'фильм ужасов', 'word_tk': 'gorkunç film', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'мультфильм', 'word_tk': 'multfilm / animasiýa', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'очередь', 'word_tk': 'nobat', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'сюжет', 'word_tk': 'süjet / waka', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'актёр - актриса', 'word_tk': 'aktýor (erkek/aýal)', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'певец - певица', 'word_tk': 'aýdymçy (erkek/aýal)', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'заранее', 'word_tk': 'öňünden / wagtynda', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'народный', 'word_tk': 'halk / milli', 'category': 'b1'},
      {'lesson_id': 35, 'word_ru': 'известный', 'word_tk': 'meşhur / belli', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'волосы', 'word_tk': 'saç', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'усы', 'word_tk': 'murt', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'борода', 'word_tk': 'sakgal', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'очки', 'word_tk': 'äýnek', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'рост', 'word_tk': 'boý', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'улыбка', 'word_tk': 'ýylgyryş', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'художник', 'word_tk': 'suratçy', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'кондитер', 'word_tk': 'şirinlikçi / konditer', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'кудрявый', 'word_tk': 'gyrym saçly', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'лысый', 'word_tk': 'baldyr / saçsyz', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'счастливый', 'word_tk': 'bagtyýar / bagtly', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'похожий', 'word_tk': 'meňzeş', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'стройный - полный', 'word_tk': 'inçe - doly (beden)', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'высокий - низкий', 'word_tk': 'uzyn - gysga (boý)', 'category': 'b1'},
      {'lesson_id': 36, 'word_ru': 'итак', 'word_tk': 'ine şeýle / onda', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'родина', 'word_tk': 'watan / dogduk ýurt', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'столица', 'word_tk': 'paýtagt', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'государство', 'word_tk': 'döwlet', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'население', 'word_tk': 'ilat', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'флаг', 'word_tk': 'baýdak', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'герб', 'word_tk': 'gerb / döwlet nyşany', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'нефть', 'word_tk': 'nebit', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'газ', 'word_tk': 'gaz', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'золото', 'word_tk': 'altyn', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'серебро', 'word_tk': 'kümüş', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'официальный', 'word_tk': 'resmi', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'древний', 'word_tk': 'gadymy / köne', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'деревянный', 'word_tk': 'agaçdan ýasalan', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'каменный', 'word_tk': 'daşdan ýasalan', 'category': 'b1'},
      {'lesson_id': 37, 'word_ru': 'верность', 'word_tk': 'wepalylyk', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'животное', 'word_tk': 'haýwan', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'птица', 'word_tk': 'guş', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'слон', 'word_tk': 'pil', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'медведь', 'word_tk': 'aýy', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'волк', 'word_tk': 'möjek / gurt', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'заяц', 'word_tk': 'towşan', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'лиса', 'word_tk': 'tilki', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'корова', 'word_tk': 'sygyr', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'лошадь', 'word_tk': 'at', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'змея', 'word_tk': 'ýylan', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'ядовитый', 'word_tk': 'zäherly / zyýanly', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'домашний - дикий', 'word_tk': 'öý - ýabany (haýwan)', 'category': 'b1'},
      {'lesson_id': 38, 'word_ru': 'огромный', 'word_tk': 'haýran galdyryjy uly', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'Рождество', 'word_tk': 'Roždestwo / Milad', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'ёлка', 'word_tk': 'bezelen arça', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'традиция', 'word_tk': 'däp-dessur', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'игрушка', 'word_tk': 'oýunjak', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'родственник', 'word_tk': 'garyndaş', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'конфета', 'word_tk': 'konfet / süýji', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'новогодний', 'word_tk': 'Täze ýyl (syp.)', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'букет', 'word_tk': 'gül desseji', 'category': 'b1'},
      {'lesson_id': 39, 'word_ru': 'вечеринка', 'word_tk': 'agşam meýlisi', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'балерина', 'word_tk': 'balerina / tansçy', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'хирург', 'word_tk': 'hirurg / operasiýa lukmany', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'учёный', 'word_tk': 'alym', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'писатель', 'word_tk': 'ýazyjy', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'достижение', 'word_tk': 'üstünlik / gazanylan', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'успех', 'word_tk': 'üstünlik / başarylyk', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'медаль', 'word_tk': 'medal', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'космос', 'word_tk': 'kosmos / älem', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'полёт', 'word_tk': 'uçuş', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'поэт', 'word_tk': 'şahyr', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'великий', 'word_tk': 'beýik / uly', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'несомненно', 'word_tk': 'şübhesiz / elbetde', 'category': 'b1'},
      {'lesson_id': 40, 'word_ru': 'творчество', 'word_tk': 'döredijilik', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'наводнение', 'word_tk': 'suw joşguny / sel', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'пожар', 'word_tk': 'ot ýangyny', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'землетрясение', 'word_tk': 'ýer titremesi', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'цунами', 'word_tk': 'sunami / deňiz tolkuny', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'стихийное бедствие', 'word_tk': 'tebigy betbagtçylyk', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'глобальное потепление', 'word_tk': 'global ýylylyk', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'окружающая среда', 'word_tk': 'daşky gurşaw', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'загрязнение', 'word_tk': 'hapalama', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'голод', 'word_tk': 'açlyk', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'спасатель', 'word_tk': 'halas ediji', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'беженец', 'word_tk': 'bosgun', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'безработица', 'word_tk': 'işsizlik', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'зарплата', 'word_tk': 'aýlyk / zähmet haky', 'category': 'b1'},
      {'lesson_id': 41, 'word_ru': 'равнодушие', 'word_tk': 'biparhlyk / sowuklyk', 'category': 'b1'},
    ];
    for (final v in vocab) { await txn.insert(DbConstants.tVocabulary, v, conflictAlgorithm: ConflictAlgorithm.ignore); }
  }

  static Future<void> _seedDialogs(Transaction txn) async {
    await _d(txn, 34, 701, 'Şäherde mi, obada mı?', 'Iki dostuň pikir alyşmagy', [
      ['Merýem', 'Мерьем, где ты предпочитаешь жить, в городе или в деревне?', 'Merýem, nirde ýaşamagy halaýarsyň?'],
      ['Azat', 'Я предпочитаю город. В городах интересная жизнь. Можно учиться и работать.', 'Men şäheri halaýaryn. Şäherde gyzykly durmuş.'],
      ['Merýem', 'А у меня другое мнение. В городах шумно и грязно. А в деревне тихо и спокойно.', 'Meniň başgaça pikirimi bar. Obada asuda we parahat.'],
      ['Azat', 'Когда я буду на пенсии, я буду жить на даче! Летом можно ловить рыбу и жарить шашлык.', 'Pensiyaga çykanymda daçada ýaşaryn!'],
    ]);
    await _d(txn, 34, 702, 'Öý satmak barada', 'Öý satyn almak söhbeti', [
      ['Aýna', 'Здравствуйте! Это правда, что вы продаёте ваш дом?', 'Salam! Öýüňizi satýandygyňyz hakykatmy?'],
      ['Serdar', 'Да. Мы хотим переехать в Ашгабат. Здесь жизнь очень спокойна.', 'Hawa. Biz Aşgabada göçmek isleýäris.'],
      ['Aýna', 'Сколько у вас этажей? У вас есть баня?', 'Näçe gatly? Hammamыňyz barmy?'],
      ['Serdar', 'Да, есть баня и огород. Дом очень большой и уютный. Вот наш телефон. Звоните!', 'Hawa, hamman we bakja bar. Ine biziň telefonymyz. Jaň ediň!'],
    ]);
    await _d(txn, 34, 703, 'Daçada tomus', 'Tomus dynç alyşy barada', [
      ['Kemal', 'Кемал, где ты обычно проводишь лето?', 'Kemal, adatça tomusy nirede geçirýärsiň?'],
      ['Läle', 'Летом я всегда отдыхаю в деревне у бабушки и дедушки.', 'Tomusda hemişe obadaky mama-babamda dynç alýaryn.'],
      ['Kemal', 'Что ты там делаешь?', 'Sen şol ýerde näme edýärsiň?'],
      ['Läle', 'Утром я обычно помогаю по дому или работаю в огороде. А днём мы с друзьями загораем и купаемся в реке. Вечером жарим шашлык.', 'Irden öýe kömek edýärin. Günortan dostlar bilen suwa düşýäris. Agşam şaşlyk goýýarys.'],
    ]);
    await _d(txn, 34, 704, 'Öýdäki iş bölünişigi', 'Maşgala öý işleri', [
      ['Ogulnur', 'Огулнур, ты любишь готовить?', 'Ogulnur, nahar bişirmeyi gowy görýärsiňmi?'],
      ['Oraz', 'Да, я очень люблю готовить! Особенно люблю жарить мясо и готовить салаты из овощей.', 'Hawa, nahar bişirmeyi örän gowy görýärin!'],
      ['Ogulnur', 'А где ты хранишь посуду?', 'Gap-gaçlaryňy nirede saklaýarsyň?'],
      ['Oraz', 'У нас есть большой шкаф на кухне. Там мы храним кастрюли, сковороды и другую посуду. А в подвале мы храним овощи.', 'Biziň aşhanasynda uly şkap bar. Şol ýerde gap-gaçlar. Podwalda gök önümler.'],
    ]);
    await _d(txn, 35, 705, 'Teatrda bilet almak', 'Kassa öňünde söhbet', [
      ['Döwlet', 'Скажите, пожалуйста, есть ещё билеты на сегодняшний спектакль?', 'Aýdyň, haýyşt, bu günki sahna üçin bilet barmy?'],
      ['Kassa', 'Одну минутку... Билеты в партер уже закончились, но есть билеты в амфитеатр на последний ряд и на балкон.', 'Bir minut... Parterdäki biletler gutardy, ýöne amfiteatrda bar.'],
      ['Döwlet', 'Хорошо, три билета на балкон, пожалуйста. А есть скидка для студентов?', 'Bolýar, balkon üçin üç bilet, haýyşt. Talyp skidkasy barmy?'],
      ['Kassa', 'Да, скидка 15 процентов. С вас тысяча рублей за три билета. Можно заплатить картой или наличными.', 'Hawa, 15 göterim. Üç bilet üçin müň rubl.'],
    ]);
    await _d(txn, 35, 706, 'Kino kassasynda', 'Kino bilet almak', [
      ['Gülnara', 'Скажите, пожалуйста, фильм «Акула-убийца» уже начался?', 'Haýyşt, «Akula-öldüriji» filmi başladymy?'],
      ['Kassa', 'Сеанс уже начался, но сейчас показывают рекламу. У вас ещё есть время.', 'Seans başlady, ýöne häzir reklama görkezilýär.'],
      ['Gülnara', 'Детский? Но это фильм ужасов!', 'Çagalar üçin? Bu gorkunç film ahyryn!'],
      ['Kassa', 'Ой, я не подумал об этом. Через 15 минут начинается мультфильм. Хорошо, дайте два билета на восьмой ряд.', 'Wah, muny pikir etmedim. 15 minutdan multfilm başlaýar.'],
    ]);
    await _d(txn, 35, 707, 'Film barada pikir', 'Film synlandan soň gürrüňdeşlik', [
      ['Maral', 'Марал, что ты думаешь о фильме? Он тебе понравился?', 'Maral, film barada näme pikir edýärsiň?'],
      ['Serdar', 'Мне очень понравились актёры. Эта молодая актриса играла просто замечательно.', 'Maňa aktýorlar örän ýarady.'],
      ['Maral', 'Мне кажется, что я уже видел эту актрису раньше. Если я не ошибаюсь, раньше она была певицей.', 'Pikir edýärin, bu aktisany öňem görendirin.'],
      ['Serdar', 'Я не знала об этом. Но сюжет фильма был очень глупый. В следующий раз выберем детектив или триллер.', 'Men muny bilmeýärdim. Indiki gezek detektif saýlarys.'],
    ]);
    await _d(txn, 35, 708, 'Konsert planlary', 'Konserte gitmek barada', [
      ['Azat', 'Азат, как давно мы не были в театре! Пойдём в эти выходные?', 'Azat, näçe wagt teatrda bolmadyk! Bu dynç günleri gideliň?'],
      ['Läle', 'Мне не очень нравится театр. В эту субботу одна известная группа даёт концерт в Ашгабате.', 'Maňa teatr gaty ýaramaýar. Bu şenbe Aşgabatda meşhur topar konsert berýär.'],
      ['Azat', 'Давай. А как называется эта группа? Мне очень нравится туркменская народная музыка.', 'Bolýar. Bu toparyň ady näme? Maňa türkmen halk sazy örän ýaraýar.'],
      ['Läle', 'Эта группа называется «Дурна». Это вовсе не народная музыка, но я уверен, что тебе понравится.', 'Bu toparyň ady «Durna». Bu halk sazy däl, ýöne saňa ýarajakdygyna ynamym bar.'],
    ]);
    await _d(txn, 36, 709, 'Köne tanyşy görmek', 'Uzak görülmedik dost bilen duşuşyk', [
      ['Merýem', 'Мерьем! Сколько лет, сколько зим! Как поживаешь?', 'Merýem! Näçe ýyl, näçe gyş! Ýagdaý nähili?'],
      ['Kemal', 'Кемал! Как давно мы не виделись! Дело в том, что я сейчас живу в Туркменабаде.', 'Kemal! Örän uzak görüşmedik! Häzir Türkmenabatda ýaşaýaryn.'],
      ['Merýem', 'Этот высокий стройный парень? У него были светлые кудрявые волосы?', 'Şol uzyn we syratly oglan? Onuň açyk gyrym saçy bardy?'],
      ['Kemal', 'Да, правда сейчас он лысый. Мы поженились два года назад. Я очень счастлива.', 'Hawa, indi baldyr. Iki ýyl öň öýlendik. Men örän bagtly.'],
    ]);
    await _d(txn, 36, 710, 'Maşgala albomy', 'Ene-atanyň suraty barada', [
      ['Aýna', 'Айна, кто это на фотографии? Это твоя мама?', 'Aýna, suratdaky kim? Bu seniň ejeňmi?'],
      ['Ogulnur', 'Нет, это моя бабушка. Но здесь она ещё молодая. В то время она работала в булочной.', 'Ýok, bu meniň mamam. Şol döwür çörekçi dükanda işleýärdi.'],
      ['Aýna', 'Мне кажется, что ты очень похожа на неё. А это твой дедушка?', 'Pikir edýärin, sen oňa örän meňzeýärsiň. Bu seniň babаňmy?'],
      ['Ogulnur', 'Да, вот его последняя фотография. К сожалению, он умер год назад. Мы все по нему скучаем.', 'Hawa, ine onuň iň soňky suraty. Gynansam-da, bir ýyl öň aradan çykdy.'],
    ]);
    await _d(txn, 36, 711, 'Doganlyk barada', 'Maşgala agzalary', [
      ['Döwlet', 'Довлет, у тебя есть братья или сёстры?', 'Döwlet, doganyň ýa-da uýaň barmy?'],
      ['Serdar', 'Нет, я единственный ребёнок в семье. Но у меня есть двоюродный брат и двоюродная сестра. Мы очень близки.', 'Ýok, men maşgaladaky ýeke çaga. Ýöne ýegen oglanym we ýegen gyzym bar.'],
      ['Döwlet', 'Раньше мы проводили каждое лето в деревне у бабушки. А у тебя есть братья и сёстры?', 'Öňler her tomusy mama öýünde geçirýärdik.'],
      ['Serdar', 'Нет, к сожалению, я сирота. Я выросла в детском доме. Но сейчас у меня есть семья. Я замужем и у меня есть дочь.', 'Ýok, gynansam-da, men ýetim. Çagalar öýünde ulaldym. Ýöne häzir maşgalam bar.'],
    ]);
    await _d(txn, 36, 712, 'Maşgala portreti', 'Suratdaky adamlary tanyşdyrmak', [
      ['Läle', 'Лале, кто это на картине?', 'Läle, suratdaky kim?'],
      ['Gülnara', 'Это наш семейный портрет. Мой старший брат — художник. Он рисовал этот портрет целый год.', 'Bu biziň maşgala portretimiz. Meniň uly doganymy suratçy.'],
      ['Läle', 'А кто этот пожилой мужчина с бородой и очками?', 'Bu sakgally we äýnekli ýaşuly kim?'],
      ['Gülnara', 'Это мой папа. Ему уже 65 лет, но он очень привлекательный. Он работает преподавателем в университете. Папа высокий и стройный.', 'Bu meniň kakam. Onuň 65 ýaşy bar. Ol örän özüne çekiji mugallym.'],
    ]);
    await _d(txn, 37, 713, 'Türkmenistanda diller', 'Diller barada söhbet', [
      ['Azat', 'Азат, как ты думаешь, сколько языков есть в Туркменистане?', 'Azat, Türkmenistanda näçe dil bar?'],
      ['Merýem', 'В Туркменистане есть туркменский, русский и другие языки. Официальный язык — туркменский.', 'Türkmenistanda türkmen, rus we başga diller bar. Resmi dil — türkmen dili.'],
      ['Azat', 'А каково население Туркменистана?', 'Türkmenistanyň ilaty nähili?'],
      ['Merýem', 'В Туркменистане живут около 6 миллионов человек. Столица — Ашгабат. Это красивый и современный город.', 'Türkmenistanda takmynan 6 million adam ýaşaýar. Paýtagt — Aşgabat.'],
    ]);
    await _d(txn, 37, 714, 'Türkmenistanyň baýlyklary', 'Tebigy serişdeler barada', [
      ['Kemal', 'Кемал, ты знал, что Туркменистан — одна из богатейших стран по запасам газа?', 'Kemal, Türkmenistanyň gaz ätiýaçlygy boýunça iň baý ýurtlardandygyny bilýärdiňmi?'],
      ['Läle', 'Неужели? А я думал, что только Россия.', 'Dogrydanmy? Men diňe Russiýa diýip pikir edýärdim.'],
      ['Kemal', 'Нет. В Туркменистане очень много природных ресурсов: газ, нефть, золото и серебро. Кроме того, здесь широко известны туркменский хлопок и ковры.', 'Ýok. Türkmenistanda örän köp tebigy serişde bar: gaz, nebit, altyn we kümüş.'],
      ['Läle', 'А каковы условия жизни на севере Туркменистана?', 'Türkmenistanyň demirgazygynda ýaşaýyş şertleri nähili?'],
    ]);
    await _d(txn, 37, 715, 'Türkmenistanyň döwlet nyşanlary', 'Baýdak, gerb we gimn barada', [
      ['Ogulnur', 'Огулнур, какие государственные символы есть в Туркменистане?', 'Ogulnur, Türkmenistanda haýsy döwlet nyşanlary bar?'],
      ['Döwlet', 'Государственные символы Туркменистана — это флаг, герб и гимн. Герб Туркменистана — это семь ковровых орнаментов и звёздочка.', 'Türkmenistanyň döwlet nyşanlary — bu baýdak, gerb we gimn.'],
      ['Ogulnur', 'А что означают цвета флага?', 'Baýdakyň reňkleri näme diýmegi?'],
      ['Döwlet', 'На флаге Туркменистана есть зелёный цвет, белая полоса и пять ковровых орнаментов. Зелёный цвет — это символ природы и жизни.', 'Türkmenistanyň baýdagynda ýaşyl reňk, ak zolak we bäş haly nagşy bar.'],
    ]);
    await _d(txn, 37, 716, 'Aşgabat şäheri barada', 'Paýtagt barada gürrüň', [
      ['Serdar', 'Сердар, ты уже был в Ашгабате?', 'Serdar, sen Aşgabatda bolduňmy?'],
      ['Azat', 'Да, я был там месяц назад. Это очень красивый и современный город! В центре города есть очень красивые белые здания.', 'Hawa, bir aý öň şol ýerde boldum. Ol örän owadan we döwrebap şäher!'],
      ['Serdar', 'Что интересного можно увидеть в Ашгабате?', 'Aşgabatda näme gyzykly görüp bolýar?'],
      ['Azat', 'В Ашгабате есть много музеев, парков и базаров. Особенно интересен рынок Толкучка. Там можно купить туркменские ковры и национальные игрушки.', 'Aşgabatda köp museum, seýilgäh we bazar bar. Esasanam Tolkuçka bazary gyzykly.'],
    ]);
    await _d(txn, 38, 717, 'Haýwanat bagynda', 'Haýwanat bagyna baryş', [
      ['Merýem', 'Мерьем, в эти выходные вы ходили в зоопарк? Каких животных ты там видела?', 'Merýem, bu dynç günleri haýwanat bagyna gitdiňizmi?'],
      ['Aýna', 'Я видела слона, жирафа, тигра, обезьяну. Я не знала, что пингвины так хорошо плавают!', 'Men pil, žiraf, gaplaň, maýmyn gördüm.'],
      ['Merýem', 'Мне очень нравится смотреть на животных, но я ненавижу зоопарки. Животные должны жить на свободе, а не в клетках.', 'Maňa haýwanlara seredip durmak örän ýaraýar, ýöne haýwanat baglaryny ýigrenýärin.'],
      ['Aýna', 'Согласна. Использовать животных в цирке — это преступление против природы.', 'Ylalaşýaryn. Haýwanlary sirkde ulanmak tebigatyň garşysyna jenaýat.'],
    ]);
    await _d(txn, 38, 718, 'Syýahat wagtynda haýwanlar', 'Syýahat barada söhbet', [
      ['Kemal', 'Кемал, ты уже вернулся! Как твой отпуск? Ты ездил в Южную Азию, правда?', 'Kemal, sen gaýdyp geldiň! Dynç alyş nähilidi?'],
      ['Döwlet', 'Да, я был в Индии. Я ходил на экскурсию в джунгли! Если честно, мне было очень страшно. Я никогда в жизни не видел столько насекомых!', 'Hawa, Hindistanda boldum. Dünýä gitdim! Örän gorkdym.'],
      ['Kemal', 'Это была ядовитая змея?', 'Bu zäherly ýylanydy?'],
      ['Döwlet', 'Конечно, ядовитая. В джунглях почти всё ядовито. Больше всего мне понравились попугаи. Они такие разноцветные и так красиво поют!', 'Elbetde, zäherly. Dünýäde diýen ýaly hemme zat zäherly. Iň gowy gören zadym totuguşlardы.'],
    ]);
    await _d(txn, 38, 719, 'Öý haýwany barada', 'Öý haýwanlary barada gürrüňdeşlik', [
      ['Serdar', 'Сердар, у вас есть домашние животные?', 'Serdar, siziňde öý haýwany barmy?'],
      ['Gülnara', 'Да, у нас есть кошка. Её зовут Пишик. Я очень люблю кошек.', 'Hawa, bizde pişik bar. Onuň ady Pişik. Men pişikleri örän gowy görýärin.'],
      ['Serdar', 'А я предпочитаю собак. Собака — самый верный друг. Она всегда тебе рада.', 'Men bolsa itleri halaýaryn. It iň wepaly dost.'],
      ['Gülnara', 'Кошкам не нужно гулять. В холодную зимнюю погоду люди предпочитают оставаться дома. С кошкой это очень удобно.', 'Pişiklere gezim etdirmek gerek däl. Bu örän amatly.'],
    ]);
    await _d(txn, 38, 720, 'Goraghanada gezelenç', 'Türkmenistanyň goraghanasynda', [
      ['Azat', 'Вы знаете, что такое заповедник? Заповедник — это место, где все растения, животные, птицы и насекомые защищены от воздействия человека.', 'Goraghana näme bilýärsiňizmi? Goraghana — ähli ösümlikler we haýwanlar adam täsirinden goralýan ýer.'],
      ['Merýem', 'В Туркменистане есть Репетекский государственный заповедник — это часть пустыни Каракумы.', 'Türkmenistanda Repetek Döwlet Goraghanasy bar — Garagum çölüniň bir bölegi.'],
      ['Azat', 'Там обитают редкие животные: гепард, джейран, вараны. Гепард — это самое быстрое животное на Земле!', 'Şol ýerde seýrek haýwanlar: gepard, jeren, waran ýaşaýar. Gepard — dünýäde iň çalt haýwan!'],
      ['Merýem', 'Берегите и цените природу нашей Родины!', 'Watanymyzyň tebigatyny goralyň we gadyryny biliň!'],
    ]);
    await _d(txn, 39, 721, 'Russiýada Roždestwo', 'Rus baýramlary barada söhbet', [
      ['Kemal', 'Кемал, когда вы отмечаете Рождество?', 'Kemal, Roždestwony haçan belleýärsiňiz?'],
      ['Läle', 'Русские православные христиане отмечают Рождество седьмого января. Дело в том, что русская православная церковь использует старый, юлианский календарь.', 'Rus prawoslaw hristianlary Roždestwony ýanwaryň ýedisinde belleýärler.'],
      ['Kemal', 'А кто приносит детям подарки на Рождество?', 'Roždestwo üçin çagalara sowgat kim getirýär?'],
      ['Läle', 'Дети в России получают подарки не на Рождество, а на Новый год. Дед Мороз и его внучка Снегурочка оставляют детям подарки под ёлкой.', 'Russiýadaky çagalar sowgatlary Täze ýylda alýarlar. Aýaz Baba arçanyň aşagyna sowgat goýýar.'],
    ]);
    await _d(txn, 39, 722, 'Maslenitsa baýramy', 'Rus ýaz baýramy', [
      ['Döwlet', 'Довлет, куда ты идёшь?', 'Döwlet, nirä barýarsyň?'],
      ['Aýna', 'Я иду к моей тёще на блины. Сейчас Масленица. Разве ты не знаешь эту традицию?', 'Gaýynenemde blinlere barýaryn. Häzir Maslenitsa. Bu däbi bilmeýärmiň?'],
      ['Döwlet', 'Нет, я живу в Туркменистане всего полгода. Я слышал, что Масленица — это древний славянский праздник.', 'Ýok, men Türkmenistanda diňe alty aý ýaşaýaryn.'],
      ['Aýna', 'Это верно. Люди делают огромную куклу из соломы и сжигают её. Блин — символ солнца. Он круглый и жёлтый. Сейчас в центре города на площади есть ярмарка!', 'Dogry. Adamlar samandan guw edip ýakýarlar. Blin günüň nyşany. Häzir meýdançada ýarmarkа bar!'],
    ]);
    await _d(txn, 39, 723, 'Täze ýyl taýýarlyklary', 'Täze ýyla taýýarlyk görmek', [
      ['Gülnara', 'Гюльнара, что ты собираешься делать в новогодние каникулы?', 'Gülnara, Täze ýyl dynç günlerinde näme etmekçi?'],
      ['Merýem', 'Обычно в новогодние каникулы мы остаёмся дома. Мы катаемся на лыжах и ходим в гости к нашим родственникам. Но в этом году мы решили поехать на Каспийское море.', 'Adatça öýde galýarys. Bu ýyl Hazar deňzine gitmek kararyna geldik.'],
      ['Gülnara', 'Как здорово! А мы будем дома. Мы всегда ставим ёлку и вешаем на неё красивые разноцветные шары, гирлянды и игрушки.', 'Näme ajaýyp! Biz öýde bolarys. Hemişe arça goýup üstüne owadan bezeglerini asýarys.'],
      ['Merýem', 'Это так мило!', 'Bu şeýle süýji!'],
    ]);
    await _d(txn, 39, 724, 'Sowgat saýlamak', 'Baýram sowgatlary barada', [
      ['Azat', 'Азат, скоро 8 Марта. Ты уже купила подарки?', 'Azat, ýakynda 8-nji Mart. Sowgatlary aldyňmy?'],
      ['Kemal', 'Конечно. Моей бабушке я купила шерстяной свитер. Моей сестре я купила часы. А моей маме я купила туалетную воду.', 'Elbetde. Mamama ýüňli switer, uýama sagat, ejeme atyrly su aldym.'],
      ['Azat', 'А что вы будете дарить женщинам на работе?', 'Işdäki aýallara näme sowgat beresiňiz?'],
      ['Kemal', 'Мы заказали очень стильные кожаные ежедневники. Я думаю, они будут им рады.', 'Biz örän stilistik deri gündelikleri sargyt etdik. Pikir edýärin, olar şatlanar.'],
    ]);
    await _d(txn, 40, 725, 'Geljekki käri barada', 'Çaganyň höwesini soramak', [
      ['Serdar', 'Сердар, кем хочет стать ваша дочь, когда вырастет?', 'Serdar, gyzyňyz ulаlanda kim bolmak isleýär?'],
      ['Ogulnur', 'Раньше она хотела стать балериной. Она увлекалась танцами и спортом и мечтала танцевать в большом театре.', 'Öňler ol balerina bolmak isleýärdi. Tans we sport bilen meşgullanýardy.'],
      ['Serdar', 'А теперь?', 'Indi?'],
      ['Ogulnur', 'Потом она прочитала книгу про хирурга и теперь она хочет стать врачом. Мы гордимся её выбором. Мы уверены, что она добьётся успеха в жизни.', 'Soňra hirurg barada kitap okady we indi lukman bolmak isleýär. Biz onuň saýlawyna buýsanýarys.'],
    ]);
    await _d(txn, 40, 726, 'Sport bilen meşgullanmak', 'Sport höwesleri barada', [
      ['Döwlet', 'Довлет, ты любишь заниматься спортом?', 'Döwlet, sporty söýýärsiňmi?'],
      ['Läle', 'Да, очень. Я занимаюсь гимнастикой. Когда я был маленьким, я всегда смотрел соревнования по гимнастике по телевизору. Мне очень нравились чемпионы Олимпийских игр.', 'Hawa, örän. Gimnastika bilen meşgullanýaryn. Kiçikenimde hemişe ýaryşlary tomaşa ederdim.'],
      ['Döwlet', 'А ты занимаешься спортом?', 'Sen sport bilen meşgullanýarmyňmy?'],
      ['Läle', 'Зимой я обычно занимаюсь йогой. А летом мне нравится бегать в парке. Прошлой весной я участвовала в марафоне. Я закончила его пятой!', 'Gyşda ýoga edýärin. Tomusda seýilgähde ylgaýaryn. Geçen ýaz marafona gatnaşdym.'],
    ]);
    await _d(txn, 40, 727, 'Kino dostlary', 'Döredijilik we sungat barada', [
      ['Azat', 'Что ты собираешься делать сегодня вечером?', 'Bu agşam näme etmekçi?'],
      ['Gülnara', 'Сегодня вечером я иду обедать с моим другом. Я училась с ним в школе. Мы не виделись уже сто лет. Недавно я узнала, что сейчас он работает режиссёром.', 'Bu agşam dostumy bilen nahar iýmäge barýaryn. Biz mekdepde okapdyk. Ýakynda ol režissýor bolup işleýändigini bildim.'],
      ['Azat', 'А какие фильмы он снимает?', 'Ol nähili filmler surata düşürýär?'],
      ['Gülnara', 'Он снимает комедии. Ему всегда нравилось творчество известных туркменских режиссёров. И не удивительно! Они действительно были выдающимися.', 'Ol komediýa düşürýär. Oňa hemişe meşhur türkmen režissýorlarynyň döredijiligini halaýardy.'],
    ]);
    await _d(txn, 40, 728, 'Sungata gyzyklanmak', 'Ýaş suratçy barada', [
      ['Merýem', 'Мерьем, это правда, что ты хочешь стать художником?', 'Merýem, hakykatdan hem suratçy bolmak isleýärsiňmi?'],
      ['Kemal', 'Да, я всегда интересовался искусством. Произведения Джалаладдина Руми и Махтумгулы всегда были моим вдохновением.', 'Hawa, men hemişe sungata gyzyklandym. Jelaleddin Rumy we Magtymgulynyň eserleri meniň elmydama ylhamym boldy.'],
      ['Merýem', 'Неужели? У тебя настоящий талант! Когда-нибудь ты станешь знаменитым!', 'Dogrudanmy? Seniň hakyky talantyň bar! Bir gün meşhur bolarsyň!'],
      ['Kemal', 'Несомненно, я буду стараться. Великие люди нашей Родины вдохновляют поколения.', 'Şübhesiz, yhlas ederin. Watanymyzyň beýik adamlary nesillere ylham berýär.'],
    ]);
    await _d(txn, 41, 729, 'Habarlar görüp gepleşmek', 'Suw joşguny barada', [
      ['Ogulnur', 'Огулнур, давай посмотрим новости. Я хочу узнать, что случилось в мире.', 'Ogulnur, habarlara seredeliň. Dünýäde näme bolanyny bilmek isleýärin.'],
      ['Döwlet', 'Сейчас по всем каналам говорят только о наводнении. Ты слышал об этом?', 'Häzir ähli kanalda diňe suw joşguny barada gürleýärler.'],
      ['Ogulnur', 'Нет, я не знал. Какой ужас. Есть жертвы? Погибли люди?', 'Ýok, bilmeýärdim. Näme gorkunç. Pida bolanlar barmy?'],
      ['Döwlet', 'Да, есть много погибших. Сейчас там работают спасатели. Они эвакуируют жителей на лодках и вертолётах и помогают пострадавшим.', 'Hawa, köp adam pida boldy. Häzir şol ýerde halas ediçiler işleýär.'],
    ]);
    await _d(txn, 41, 730, 'Ýangyn howpy barada', 'Ýangyn söndüriji bilen söhbet', [
      ['Serdar', 'Сердар, как дела у твоего сына? Я слышал, что он работает пожарным.', 'Serdar, ogluňyň ýagdaýy nähili? Onuň ýangyn söndüriji bolup işleýändigini eşitdim.'],
      ['Läle', 'Да, я всегда очень беспокоюсь за него. Тушить пожары — это опасное дело.', 'Hawa, men oňa hemişe örän alada edýärin. Ot öçürmek howply iş.'],
      ['Serdar', 'Ты знаешь, летом опасность пожаров увеличивается. Люди ходят в лес на пикник, курят, бросают окурок, забывают потушить костёр.', 'Bilýäňmi, tomusda ýangyn howpy artyýar. Adamlar tokaýa barýarlar, ojagy öçürmegi unudýarlar.'],
      ['Läle', 'К сожалению, большинство людей очень безответственные. Пожары в домах тоже случаются чаще. Люди забывают выключить газ.', 'Gynansam-da, adamlaryň köpüsi jogapkärçiliksiz. Adamlar gazy öçürmegi unudýarlar.'],
    ]);
    await _d(txn, 41, 731, 'Ýer titremesi barada', 'Tebigy heläkçilikler', [
      ['Azat', 'Азат, в Туркменистане бывают землетрясения?', 'Azat, Türkmenistanda ýer titremesi bolýarmy?'],
      ['Merýem', 'Да, бывают. Обычно они случаются на границе с Ираном и Афганистаном. Иногда из-за землетрясений бывают волны в Каспийском море.', 'Hawa, bolýar. Adatça Eýran we Owganystan serhedinde bolýar.'],
      ['Azat', 'А какие природные явления бывают на Каспии?', 'Hazarda haýsy tebigy hadysalar bolýar?'],
      ['Merýem', 'На Каспийском море иногда бывают сильные штормы. Зимой кое-где очень холодно и бывает сильный ветер. Глобальное потепление влияет на погоду.', 'Hazarda käwagt güýçli tupanlar bolýar. Global ýylylyk howanyň üýtgemesine täsir edýär.'],
    ]);
    await _d(txn, 41, 732, 'Haýyr-sahawat işi', 'Jemgyýetiň meselelerini çözmek', [
      ['Kemal', 'Кемал, это правда, что ты работаешь в благотворительной организации? Какие самые важные глобальные проблемы сегодня?', 'Kemal, haýyr-sahawat guramada işleýändigiň dogry?'],
      ['Läle', 'Да, наша организация собирает еду и одежду для беженцев. Я думаю, что самые важные проблемы — это загрязнение окружающей среды, голод, войны, бедность и эпидемии.', 'Hawa, biziň guramaмyz bosgunlar üçin iýmit we egin-eşik ýygnaýar.'],
      ['Kemal', 'Согласна. Что мы можем сделать, чтобы помочь?', 'Ylalaşýaryn. Kömek etmek üçin näme edip bileris?'],
      ['Läle', 'Люди всего мира должны стараться решать эти проблемы вместе. Не стоит быть равнодушными.', 'Dünýäniň ähli adamlary bu meseleleri bilelikde çözmäge çalyşmaly.'],
    ]);
  }

  static Future<void> _seedGrammar(Transaction txn) async {
    final g34_1 = await txn.insert(DbConstants.tGrammarRules, {'lesson_id': 34, 'table_number': 1, 'title_ru': 'Таблица 1: Новые глаголы', 'title_tk': 'Täze işlikler — häzirki we geçen zaman', 'explanation_tk': 'Bu işlikler B1 derejesinde iň köp ulanylýar.', 'note_tk': 'проводить/загорать — I goşulma; хранить/звонить — II goşulma', 'rule_type': 'table', 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_1, 'row_order': 0, 'is_header': 1, 'cell_1': 'Kim?', 'cell_2': 'проводить', 'cell_3': 'жарить', 'cell_4': 'загорать', 'cell_5': 'искать', 'cell_6': 'хранить', 'cell_7': 'звонить', 'red_cells': '1,2,3,4,5'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_1, 'row_order': 1, 'is_header': 0, 'cell_1': 'Я', 'cell_2': 'провожу', 'cell_3': 'жарю', 'cell_4': 'загораю', 'cell_5': 'ищу', 'cell_6': 'храню', 'cell_7': 'звоню', 'red_cells': '1,2,3,4,5'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_1, 'row_order': 2, 'is_header': 0, 'cell_1': 'Ты', 'cell_2': 'проводишь', 'cell_3': 'жаришь', 'cell_4': 'загораешь', 'cell_5': 'ищешь', 'cell_6': 'хранишь', 'cell_7': 'звонишь', 'red_cells': '1,2,3,4,5'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_1, 'row_order': 3, 'is_header': 0, 'cell_1': 'Он/Она', 'cell_2': 'проводит', 'cell_3': 'жарит', 'cell_4': 'загорает', 'cell_5': 'ищет', 'cell_6': 'хранит', 'cell_7': 'звонит', 'red_cells': '1,2,3,4,5'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_1, 'row_order': 4, 'is_header': 0, 'cell_1': 'Мы', 'cell_2': 'проводим', 'cell_3': 'жарим', 'cell_4': 'загораем', 'cell_5': 'ищем', 'cell_6': 'храним', 'cell_7': 'звоним', 'red_cells': '1,2,3,4,5'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_1, 'row_order': 5, 'is_header': 0, 'cell_1': 'Они', 'cell_2': 'проводят', 'cell_3': 'жарят', 'cell_4': 'загорают', 'cell_5': 'ищут', 'cell_6': 'хранят', 'cell_7': 'звонят', 'red_cells': '1,2,3,4,5'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_1, 'row_order': 6, 'is_header': 0, 'cell_1': 'Он (geçen)', 'cell_2': 'проводил', 'cell_3': 'жарил', 'cell_4': 'загорал', 'cell_5': 'искал', 'cell_6': 'хранил', 'cell_7': 'звонил', 'red_cells': '1,2,3,4,5'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_1, 'row_order': 7, 'is_header': 0, 'cell_1': 'Она (geçen)', 'cell_2': 'проводила', 'cell_3': 'жарила', 'cell_4': 'загорала', 'cell_5': 'искала', 'cell_6': 'хранила', 'cell_7': 'звонила', 'red_cells': '1,2,3,4,5'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g34_2 = await txn.insert(DbConstants.tGrammarRules, {'lesson_id': 34, 'table_number': 2, 'title_ru': 'Таблица 2: Предложный падёж', 'title_tk': 'Yer düşümi — atlaryň üýtgeşmesi', 'explanation_tk': 'Nirede? soragyna jogap berýär. в/на öň sözleri bilen ulanylýar.', 'note_tk': '-ия bilen gutarýan sözler: Россия → в России (-ии!)', 'rule_type': 'table', 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_2, 'row_order': 0, 'is_header': 1, 'cell_1': 'Jyns', 'cell_2': 'Görnüş', 'cell_3': 'Mysal', 'cell_4': 'Предл. падёж', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_2, 'row_order': 1, 'is_header': 0, 'cell_1': 'Erkek (çek.)', 'cell_2': '+е', 'cell_3': 'город / стол', 'cell_4': 'в городе / на столе', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_2, 'row_order': 2, 'is_header': 0, 'cell_1': 'Erkek (-й)', 'cell_2': 'й → е', 'cell_3': 'музей', 'cell_4': 'в музее', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_2, 'row_order': 3, 'is_header': 0, 'cell_1': 'Aýal (-а/-я)', 'cell_2': '-а/-я → е', 'cell_3': 'деревня', 'cell_4': 'в деревне', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_2, 'row_order': 4, 'is_header': 0, 'cell_1': 'Aýal (-ия)', 'cell_2': '-ия → -ии', 'cell_3': 'Россия', 'cell_4': 'в России ⚠️', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_2, 'row_order': 5, 'is_header': 0, 'cell_1': 'Aýal (-ь)', 'cell_2': '-ь → и', 'cell_3': 'площадь', 'cell_4': 'на площади', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_2, 'row_order': 6, 'is_header': 0, 'cell_1': 'Orta (-о/-е)', 'cell_2': '-о/-е → е', 'cell_3': 'письмо / море', 'cell_4': 'в письме / в море', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g34_2, 'row_order': 7, 'is_header': 0, 'cell_1': 'Orta (-ие)', 'cell_2': '-ие → -ии', 'cell_3': 'здание', 'cell_4': 'в здании ⚠️', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g35_1 = await txn.insert(DbConstants.tGrammarRules, {'lesson_id': 35, 'table_number': 1, 'title_ru': 'Таблица 1: Видовые пары глаголов', 'title_tk': 'Işlik jübütleri (НСВ / СВ)', 'explanation_tk': 'НСВ — gaýtalanýan ýa-da dowam edýän iş. СВ — tamamlanan, netijeli iş.', 'note_tk': 'НСВ: Я часто покупаю хлеб. | СВ: Я уже купил хлеб.', 'rule_type': 'table', 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 0, 'is_header': 1, 'cell_1': 'НСВ (dowam)', 'cell_2': 'СВ (tamaml.)', 'cell_3': 'Manysy', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 1, 'is_header': 0, 'cell_1': 'говорить', 'cell_2': 'сказать', 'cell_3': 'gürlemek', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 2, 'is_header': 0, 'cell_1': 'брать', 'cell_2': 'взять', 'cell_3': 'almak', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 3, 'is_header': 0, 'cell_1': 'покупать', 'cell_2': 'купить', 'cell_3': 'satyn almak', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 4, 'is_header': 0, 'cell_1': 'находить', 'cell_2': 'найти', 'cell_3': 'tapmak', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 5, 'is_header': 0, 'cell_1': 'начинать', 'cell_2': 'начать', 'cell_3': 'başlamak', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 6, 'is_header': 0, 'cell_1': 'показывать', 'cell_2': 'показать', 'cell_3': 'görkezmek', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 7, 'is_header': 0, 'cell_1': 'получать', 'cell_2': 'получить', 'cell_3': 'almak (netije)', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 8, 'is_header': 0, 'cell_1': 'платить', 'cell_2': 'заплатить', 'cell_3': 'tölemek', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 9, 'is_header': 0, 'cell_1': 'видеть', 'cell_2': 'увидеть', 'cell_3': 'görmek', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g35_1, 'row_order': 10, 'is_header': 0, 'cell_1': 'слышать', 'cell_2': 'услышать', 'cell_3': 'eşitmek', 'cell_4': '', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g36_1 = await txn.insert(DbConstants.tGrammarRules, {'lesson_id': 36, 'table_number': 1, 'title_ru': 'Таблица 1: Творительный падёж', 'title_tk': 'Gural düşümi — kim bilen? näme bilen?', 'explanation_tk': 'Işlem guraly, mesleği we birlikde bolmagy aňladýar.', 'note_tk': 'Он работает врачом. | Я иду с другом.', 'rule_type': 'table', 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g36_1, 'row_order': 0, 'is_header': 1, 'cell_1': 'Jyns', 'cell_2': 'Goşulma', 'cell_3': 'Mysal', 'cell_4': 'Творит. падёж', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g36_1, 'row_order': 1, 'is_header': 0, 'cell_1': 'Erkek (çek.)', 'cell_2': '+ом', 'cell_3': 'друг / врач', 'cell_4': 'другом / врачом', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g36_1, 'row_order': 2, 'is_header': 0, 'cell_1': 'Erkek (-й)', 'cell_2': 'й → ем', 'cell_3': 'гений', 'cell_4': 'гением', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g36_1, 'row_order': 3, 'is_header': 0, 'cell_1': 'Aýal (-а)', 'cell_2': '-а → +ой', 'cell_3': 'подруга', 'cell_4': 'подругой', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g36_1, 'row_order': 4, 'is_header': 0, 'cell_1': 'Aýal (-я)', 'cell_2': '-я → +ей', 'cell_3': 'семья', 'cell_4': 'семьёй', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g36_1, 'row_order': 5, 'is_header': 0, 'cell_1': 'Aýal (-ь)', 'cell_2': '+ью', 'cell_3': 'мать / дочь', 'cell_4': 'матерью / дочерью', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g36_1, 'row_order': 6, 'is_header': 0, 'cell_1': 'Orta (-о/-е)', 'cell_2': '+ом/ем', 'cell_3': 'окно / море', 'cell_4': 'окном / морем', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g37_1 = await txn.insert(DbConstants.tGrammarRules, {'lesson_id': 37, 'table_number': 1, 'title_ru': 'Таблица 1: Родительный падёж', 'title_tk': 'Eýelik düşümi — kimiň? nämäniň?', 'explanation_tk': 'Eýelik, ýokluk (нет), nireden (из/с), san+at (5+) bilen ulanylýar.', 'note_tk': 'У меня нет времени. | Он из Ашгабата. | Пять студентов.', 'rule_type': 'table', 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g37_1, 'row_order': 0, 'is_header': 1, 'cell_1': 'Jyns', 'cell_2': 'Goşulma', 'cell_3': 'Mysal', 'cell_4': 'Родит. падёж', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g37_1, 'row_order': 1, 'is_header': 0, 'cell_1': 'Erkek (çek.)', 'cell_2': '+а', 'cell_3': 'город / студент', 'cell_4': 'города / студента', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g37_1, 'row_order': 2, 'is_header': 0, 'cell_1': 'Erkek (-й)', 'cell_2': 'й → +я', 'cell_3': 'музей', 'cell_4': 'музея', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g37_1, 'row_order': 3, 'is_header': 0, 'cell_1': 'Aýal (-а)', 'cell_2': '-а → +ы/-и', 'cell_3': 'книга', 'cell_4': 'книги', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g37_1, 'row_order': 4, 'is_header': 0, 'cell_1': 'Aýal (-ия)', 'cell_2': '-ия → -ии', 'cell_3': 'Россия', 'cell_4': 'России', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g37_1, 'row_order': 5, 'is_header': 0, 'cell_1': 'Aýal (-ь)', 'cell_2': '-ь → +и', 'cell_3': 'площадь', 'cell_4': 'площади', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g37_1, 'row_order': 6, 'is_header': 0, 'cell_1': 'Orta (-о/-е)', 'cell_2': '-о → +а', 'cell_3': 'окно', 'cell_4': 'окна', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g38_1 = await txn.insert(DbConstants.tGrammarRules, {'lesson_id': 38, 'table_number': 1, 'title_ru': 'Таблица 1: Дательный падёж', 'title_tk': 'Berim düşümi — kime? nämä?', 'explanation_tk': 'Я дам книгу другу. (Dosta kitap bererin.) Кому? нämä?', 'note_tk': 'нравиться: Мне нравится кошка. (Maňa pişik ýaraýar.)', 'rule_type': 'table', 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g38_1, 'row_order': 0, 'is_header': 1, 'cell_1': 'Jyns', 'cell_2': 'Goşulma', 'cell_3': 'Mysal', 'cell_4': 'Dat. падёж', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g38_1, 'row_order': 1, 'is_header': 0, 'cell_1': 'Erkek (çek.)', 'cell_2': '+у', 'cell_3': 'друг / врач', 'cell_4': 'другу / врачу', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g38_1, 'row_order': 2, 'is_header': 0, 'cell_1': 'Aýal (-а)', 'cell_2': '-а → +е', 'cell_3': 'подруга', 'cell_4': 'подруге', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g38_1, 'row_order': 3, 'is_header': 0, 'cell_1': 'Aýal (-ь)', 'cell_2': '-ь → +и', 'cell_3': 'мать', 'cell_4': 'матери', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g38_1, 'row_order': 4, 'is_header': 0, 'cell_1': 'Çalyşma', 'cell_2': 'ýörite', 'cell_3': 'я / ты / он / она', 'cell_4': 'мне / тебе / ему / ей', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g38_1, 'row_order': 5, 'is_header': 0, 'cell_1': 'Çalyşma', 'cell_2': 'ýörite', 'cell_3': 'мы / вы / они', 'cell_4': 'нам / вам / им', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final g39_1 = await txn.insert(DbConstants.tGrammarRules, {'lesson_id': 39, 'table_number': 1, 'title_ru': 'Таблица 1: Краткие прилагательные', 'title_tk': 'Gysgaldylan sypatlyklar', 'explanation_tk': 'Sözlemde: at + gysgaldylan syp. predikaty hökmünde ulanylýar.', 'note_tk': 'Он счастлив. (Ol bagtly.) | Она красива. (Ol owadan.)', 'rule_type': 'table', 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g39_1, 'row_order': 0, 'is_header': 1, 'cell_1': 'Doly görnüş', 'cell_2': 'Erkek', 'cell_3': 'Aýal', 'cell_4': 'Köplük', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2,3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g39_1, 'row_order': 1, 'is_header': 0, 'cell_1': 'красивый', 'cell_2': 'красив', 'cell_3': 'красива', 'cell_4': 'красивы', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2,3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g39_1, 'row_order': 2, 'is_header': 0, 'cell_1': 'свободный', 'cell_2': 'свободен', 'cell_3': 'свободна', 'cell_4': 'свободны', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2,3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g39_1, 'row_order': 3, 'is_header': 0, 'cell_1': 'готовый', 'cell_2': 'готов', 'cell_3': 'готова', 'cell_4': 'готовы', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2,3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g39_1, 'row_order': 4, 'is_header': 0, 'cell_1': 'счастливый', 'cell_2': 'счастлив', 'cell_3': 'счастлива', 'cell_4': 'счастливы', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2,3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g39_1, 'row_order': 5, 'is_header': 0, 'cell_1': 'похожий', 'cell_2': 'похож', 'cell_3': 'похожа', 'cell_4': 'похожи', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2,3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tGrammarTableRows, {'grammar_id': g39_1, 'row_order': 6, 'is_header': 0, 'cell_1': 'доволен', 'cell_2': 'доволен', 'cell_3': 'довольна', 'cell_4': 'довольны', 'cell_5': '', 'cell_6': '', 'cell_7': '', 'red_cells': '1,2,3'}, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<void> _seedExercises(Transaction txn) async {
    final e34_1 = await txn.insert(DbConstants.tExercises, {'lesson_id': 34, 'exercise_number': 1, 'title_tk': 'Sözler — Flash kart', 'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.', 'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 0, 'question_text': 'слесарь', 'correct_answer': 'çilikçi usta'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 1, 'question_text': 'этаж', 'correct_answer': 'gat'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 2, 'question_text': 'чердак', 'correct_answer': 'üçek aşagy'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 3, 'question_text': 'подвал', 'correct_answer': 'ýerasty ammar'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 4, 'question_text': 'баня', 'correct_answer': 'rus hammamy'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 5, 'question_text': 'посуда', 'correct_answer': 'gap-gaç'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 6, 'question_text': 'камин', 'correct_answer': 'ojaklyk'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 7, 'question_text': 'свежий', 'correct_answer': 'täze / ter'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 8, 'question_text': 'тихий', 'correct_answer': 'asuda'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e34_1, 'question_order': 9, 'question_text': 'особенно', 'correct_answer': 'aýratynam'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final e34_2 = await txn.insert(DbConstants.tExercises, {'lesson_id': 34, 'exercise_number': 2, 'title_tk': 'Предложный падёж — dogry görnüşi saýla', 'instruction_tk': 'Dogry görnüşi saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e34_2, 'В моём _____ лежат вещи. (шкаф)', 'шкафе', 'шкафу', 'шкафа', 'шкафов');
    await _mcq(txn, e34_2, 'Он живёт в _____. (деревня)', 'деревне', 'деревни', 'деревню', 'деревнях');
    await _mcq(txn, e34_2, 'Машины стоят на _____. (мост)', 'мосту', 'мосте', 'моста', 'мостов');
    await _mcq(txn, e34_2, 'Мы гуляем в _____. (лес)', 'лесу', 'лесе', 'леса', 'лесов');
    final e34_3 = await txn.insert(DbConstants.tExercises, {'lesson_id': 34, 'exercise_number': 3, 'title_tk': 'Tekst soroglary — «Daçada»', 'instruction_tk': 'Tekste görä dogry jogaby saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e34_3, 'Daça öýüniň näçe gaty bar?', 'Iki gat + podwal + çardaq', 'Bir gat', 'Üç gat', 'Dört gat');
    await _mcq(txn, e34_3, 'Birinji gatda näme bar?', 'Myhman otag we aşhana', 'Ýatakhana', 'Çardaq', 'Garaž');
    await _mcq(txn, e34_3, 'Näme üçin eýwanda iýmek gowy däl?', 'Çybyn köp bolýar', 'Yssы gaty', 'Guşlar gelýär', 'Ýel öwüsýär');
    await _mcq(txn, e34_3, 'Podwalda näme saklanýar?', 'Şerap we gök önümler', 'Gap-gaç', 'Eşik', 'Ulag');
    final e35_1 = await txn.insert(DbConstants.tExercises, {'lesson_id': 35, 'exercise_number': 1, 'title_tk': 'Sözler — Flash kart', 'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.', 'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 0, 'question_text': 'спектакль', 'correct_answer': 'sahna'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 1, 'question_text': 'касса', 'correct_answer': 'kassa'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 2, 'question_text': 'скидка', 'correct_answer': 'arzanladyş'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 3, 'question_text': 'наличные', 'correct_answer': 'nagt pul'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 4, 'question_text': 'сеанс', 'correct_answer': 'seans'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 5, 'question_text': 'актёр', 'correct_answer': 'aktýor'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 6, 'question_text': 'певец', 'correct_answer': 'aýdymçy'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 7, 'question_text': 'заранее', 'correct_answer': 'öňünden'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 8, 'question_text': 'народный', 'correct_answer': 'halk / milli'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e35_1, 'question_order': 9, 'question_text': 'очередь', 'correct_answer': 'nobat'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final e35_2 = await txn.insert(DbConstants.tExercises, {'lesson_id': 35, 'exercise_number': 2, 'title_tk': 'İşlik aspekti — НСВ ýa СВ?', 'instruction_tk': 'Dogry görnüşi saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e35_2, 'Я уже _____ эту книгу. (читать/прочитать)', 'прочитал', 'читал', 'читаю', 'буду читать');
    await _mcq(txn, e35_2, 'Каждый день она _____ хлеб. (покупать/купить)', 'покупает', 'купит', 'купила', 'покупала');
    await _mcq(txn, e35_2, 'Завтра я _____ этот фильм. (смотреть/посмотреть)', 'посмотрю', 'смотрю', 'смотрела', 'буду смотреть');
    await _mcq(txn, e35_2, 'Обычно мы _____ билеты. (брать/взять)', 'берём', 'возьмём', 'взяли', 'брали');
    final e35_3 = await txn.insert(DbConstants.tExercises, {'lesson_id': 35, 'exercise_number': 3, 'title_tk': 'Tekst soroglary — «Aşgabatda dynç günleri»', 'instruction_tk': 'Tekste görä dogry jogaby saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e35_3, 'Ýazyjy biletleri nirede tapýar?', 'Internetde', 'Kassada', 'Dostlaryndan', 'Agentlikde');
    await _mcq(txn, e35_3, 'Teatrda näme ulanylýar?', 'Kart ýa-da nagt', 'Diňe nagt', 'Diňe kart', 'Tölegsiz');
    await _mcq(txn, e35_3, 'Sabah seanslaryna näme üçin barylýar?', 'Arzan we nobat az', 'Has gowy ekran', 'Popcorn mugt', 'Has köp ýer');
    await _mcq(txn, e35_3, 'Olar nämäni halaýarlar?', 'Teatr we kino', 'Diňe kino', 'Diňe teatr', 'Sport');
    final e36_1 = await txn.insert(DbConstants.tExercises, {'lesson_id': 36, 'exercise_number': 1, 'title_tk': 'Sözler — Flash kart', 'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.', 'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 0, 'question_text': 'волосы', 'correct_answer': 'saç'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 1, 'question_text': 'борода', 'correct_answer': 'sakgal'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 2, 'question_text': 'очки', 'correct_answer': 'äýnek'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 3, 'question_text': 'рост', 'correct_answer': 'boý'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 4, 'question_text': 'улыбка', 'correct_answer': 'ýylgyryş'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 5, 'question_text': 'художник', 'correct_answer': 'suratçy'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 6, 'question_text': 'кудрявый', 'correct_answer': 'gyrym saçly'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 7, 'question_text': 'лысый', 'correct_answer': 'baldyr'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 8, 'question_text': 'похожий', 'correct_answer': 'meňzeş'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e36_1, 'question_order': 9, 'question_text': 'счастливый', 'correct_answer': 'bagtly'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final e36_2 = await txn.insert(DbConstants.tExercises, {'lesson_id': 36, 'exercise_number': 2, 'title_tk': 'Творительный падёж — dogry görnüş', 'instruction_tk': 'Dogry görnüşi saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e36_2, 'Он работает _____. (учитель)', 'учителем', 'учителя', 'учителю', 'учителе');
    await _mcq(txn, e36_2, 'Я иду с _____. (подруга)', 'подругой', 'подруги', 'подруге', 'подругу');
    await _mcq(txn, e36_2, 'Она стала _____. (врач)', 'врачом', 'врача', 'врачу', 'враче');
    await _mcq(txn, e36_2, 'Мы едем с _____. (друзья)', 'друзьями', 'друзей', 'друзьям', 'друзьях');
    final e36_3 = await txn.insert(DbConstants.tExercises, {'lesson_id': 36, 'exercise_number': 3, 'title_tk': 'Tekst soroglary — «Maşgala portreti»', 'instruction_tk': 'Tekste görä dogry jogaby saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e36_3, 'Kakam nähili görünýär?', 'Uzyn, syratly, sakgally, äýnekli', 'Arryk, ýaş', 'Semiz, gysga', 'Baldyr, garry');
    await _mcq(txn, e36_3, 'Ejemiň käri näme?', 'Konditer / çörekçi', 'Mugallym', 'Lukman', 'Suratçy');
    await _mcq(txn, e36_3, 'Uly doganym kim?', 'Suratçy', 'Režissýor', 'Ýazyjy', 'Aktýor');
    await _mcq(txn, e36_3, 'Kiçi maşgala agzasy kim?', 'Pişik Barsik', 'Uly doganы', 'Ejem', 'Kakam');
    final e37_1 = await txn.insert(DbConstants.tExercises, {'lesson_id': 37, 'exercise_number': 1, 'title_tk': 'Sözler — Flash kart', 'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.', 'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 0, 'question_text': 'родина', 'correct_answer': 'watan'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 1, 'question_text': 'столица', 'correct_answer': 'paýtagt'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 2, 'question_text': 'флаг', 'correct_answer': 'baýdak'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 3, 'question_text': 'герб', 'correct_answer': 'gerb'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 4, 'question_text': 'нефть', 'correct_answer': 'nebit'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 5, 'question_text': 'газ', 'correct_answer': 'gaz'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 6, 'question_text': 'золото', 'correct_answer': 'altyn'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 7, 'question_text': 'серебро', 'correct_answer': 'kümüş'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 8, 'question_text': 'официальный', 'correct_answer': 'resmi'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e37_1, 'question_order': 9, 'question_text': 'древний', 'correct_answer': 'gadymy'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final e37_2 = await txn.insert(DbConstants.tExercises, {'lesson_id': 37, 'exercise_number': 2, 'title_tk': 'Родительный падёж — dogry görnüş', 'instruction_tk': 'Dogry görnüşi saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e37_2, 'У меня нет _____. (время)', 'времени', 'время', 'время', 'времена');
    await _mcq(txn, e37_2, 'Он из _____. (Ашгабат)', 'Ашгабата', 'Ашгабате', 'Ашгабату', 'Ашгабатом');
    await _mcq(txn, e37_2, 'Пять _____. (студент)', 'студентов', 'студент', 'студента', 'студентах');
    await _mcq(txn, e37_2, 'Это флаг _____. (Туркменистан)', 'Туркменистана', 'Туркменистане', 'Туркменистану', 'Туркменистаном');
    final e37_3 = await txn.insert(DbConstants.tExercises, {'lesson_id': 37, 'exercise_number': 3, 'title_tk': 'Tekst soroglary — «Aşgabat — paýtagt»', 'instruction_tk': 'Tekste görä dogry jogaby saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e37_3, 'Aşgabat nirede ýerleşýär?', 'Köpetdag daglarynda', 'Hazaryň kenarynda', 'Owganystanyň serhedinde', 'Garagumda');
    await _mcq(txn, e37_3, 'Türkmen baýdagyndaky reňkler?', 'Ýaşyl, ak we haly nagşy', 'Gyzyl, ak, gök', 'Sary, ýaşyl, gara', 'Gök, ak, gyzyl');
    await _mcq(txn, e37_3, 'Türkmenistanyň resmi dili?', 'Türkmen dili', 'Rus dili', 'Iňlis dili', 'Pars dili');
    await _mcq(txn, e37_3, 'Türkmenistanda iň uly baýlyk?', 'Gaz we nebit', 'Altyn we kümüş', 'Suw', 'Agaç');
    final e38_1 = await txn.insert(DbConstants.tExercises, {'lesson_id': 38, 'exercise_number': 1, 'title_tk': 'Sözler — Flash kart', 'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.', 'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 0, 'question_text': 'животное', 'correct_answer': 'haýwan'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 1, 'question_text': 'птица', 'correct_answer': 'guş'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 2, 'question_text': 'слон', 'correct_answer': 'pil'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 3, 'question_text': 'медведь', 'correct_answer': 'aýy'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 4, 'question_text': 'волк', 'correct_answer': 'möjek'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 5, 'question_text': 'лиса', 'correct_answer': 'tilki'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 6, 'question_text': 'змея', 'correct_answer': 'ýylan'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 7, 'question_text': 'ядовитый', 'correct_answer': 'zäherly'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 8, 'question_text': 'домашний', 'correct_answer': 'öý (haýwan)'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e38_1, 'question_order': 9, 'question_text': 'огромный', 'correct_answer': 'ullakan'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final e38_2 = await txn.insert(DbConstants.tExercises, {'lesson_id': 38, 'exercise_number': 2, 'title_tk': 'Дательный падёж — dogry görnüş', 'instruction_tk': 'Dogry görnüşi saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e38_2, 'Мне _____ кошки. (нравиться)', 'нравятся', 'нравится', 'нравилась', 'понравится');
    await _mcq(txn, e38_2, 'Он дал книгу _____. (друг)', 'другу', 'друга', 'другом', 'о друге');
    await _mcq(txn, e38_2, 'Я иду к _____. (врач)', 'врачу', 'врача', 'врачом', 'о враче');
    await _mcq(txn, e38_2, 'Напиши _____ письмо. (мама)', 'маме', 'мамы', 'мамой', 'о маме');
    final e38_3 = await txn.insert(DbConstants.tExercises, {'lesson_id': 38, 'exercise_number': 3, 'title_tk': 'Tekst soroglary — «Goraghanada»', 'instruction_tk': 'Tekste görä dogry jogaby saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e38_3, 'Goraghana näme?', 'Tebigatyň goragly ýeri', 'Haýwanat bаgy', 'Tokaý', 'Milli park');
    await _mcq(txn, e38_3, 'Repetek goraghanasy nirede?', 'Garagum çölünde', 'Hazaryň kenarynda', 'Daglarda', 'Aşgabadyň ýanynda');
    await _mcq(txn, e38_3, 'Gepard näme üçin meşhur?', 'Dünýäde iň çalt haýwan', 'Iň uly haýwan', 'Iň zäherly haýwan', 'Iň owadan haýwan');
    await _mcq(txn, e38_3, 'Tebigatы goramak üçin?', 'Zibil zyňmazlyk, agaç kesmezlik', 'Köp balyk tutmak', 'Awlamak', 'Garaşmak');
    final e39_1 = await txn.insert(DbConstants.tExercises, {'lesson_id': 39, 'exercise_number': 1, 'title_tk': 'Sözler — Flash kart', 'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.', 'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e39_1, 'question_order': 0, 'question_text': 'Рождество', 'correct_answer': 'Roždestwo'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e39_1, 'question_order': 1, 'question_text': 'ёлка', 'correct_answer': 'bezelen arça'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e39_1, 'question_order': 2, 'question_text': 'традиция', 'correct_answer': 'däp-dessur'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e39_1, 'question_order': 3, 'question_text': 'игрушка', 'correct_answer': 'oýunjak'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e39_1, 'question_order': 4, 'question_text': 'родственник', 'correct_answer': 'garyndaş'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e39_1, 'question_order': 5, 'question_text': 'конфета', 'correct_answer': 'konfet'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e39_1, 'question_order': 6, 'question_text': 'новогодний', 'correct_answer': 'Täze ýyl (syp.)'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e39_1, 'question_order': 7, 'question_text': 'букет', 'correct_answer': 'gül desseji'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final e39_2 = await txn.insert(DbConstants.tExercises, {'lesson_id': 39, 'exercise_number': 2, 'title_tk': 'Gysgaldylan sypatlyklar — dogry saýla', 'instruction_tk': 'Dogry görnüşi saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e39_2, 'Она очень _____. (красивый)', 'красива', 'красивая', 'красивый', 'красивы');
    await _mcq(txn, e39_2, 'Стол _____. (свободный)', 'свободен', 'свободна', 'свободны', 'свободный');
    await _mcq(txn, e39_2, 'Мы _____! (готовый)', 'готовы', 'готов', 'готова', 'готовые');
    await _mcq(txn, e39_2, 'Она _____ на сестру. (похожий)', 'похожа', 'похож', 'похожи', 'похожая');
    final e39_3 = await txn.insert(DbConstants.tExercises, {'lesson_id': 39, 'exercise_number': 3, 'title_tk': 'Tekst soroglary — «Biziň halaýan baýramlarymyz»', 'instruction_tk': 'Tekste görä dogry jogaby saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e39_3, 'Täze ýyly restoranda kim belleýär?', 'Ýazyjy we dostlary', 'Maşgala öýde', 'Ýakynlaryna myhman bolýarlar', 'Syýahata gidýärler');
    await _mcq(txn, e39_3, 'Uýasynyň iň halaýan baýramy?', 'Maslenitsa — ýaz baýramy', 'Täze ýyl', '8-nji Mart', 'Başga baýram');
    await _mcq(txn, e39_3, '8-nji Marta kim sowgat alýar?', 'Aýallar we gyzlar', 'Diňe ýaşlar', 'Erkekler hem', 'Çagalar');
    await _mcq(txn, e39_3, 'Maslenitsa haçan bellenilýär?', 'Ýazda, bir hepde', 'Gyşda, bir gün', 'Tomusda', 'Güýzde');
    final e40_1 = await txn.insert(DbConstants.tExercises, {'lesson_id': 40, 'exercise_number': 1, 'title_tk': 'Sözler — Flash kart', 'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.', 'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e40_1, 'question_order': 0, 'question_text': 'учёный', 'correct_answer': 'alym'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e40_1, 'question_order': 1, 'question_text': 'писатель', 'correct_answer': 'ýazyjy'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e40_1, 'question_order': 2, 'question_text': 'достижение', 'correct_answer': 'üstünlik'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e40_1, 'question_order': 3, 'question_text': 'космос', 'correct_answer': 'kosmos'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e40_1, 'question_order': 4, 'question_text': 'полёт', 'correct_answer': 'uçuş'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e40_1, 'question_order': 5, 'question_text': 'несомненно', 'correct_answer': 'şübhesiz'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e40_1, 'question_order': 6, 'question_text': 'творчество', 'correct_answer': 'döredijilik'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e40_1, 'question_order': 7, 'question_text': 'великий', 'correct_answer': 'beýik'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final e40_2 = await txn.insert(DbConstants.tExercises, {'lesson_id': 40, 'exercise_number': 2, 'title_tk': 'Hünäri tapmaklyk', 'instruction_tk': 'Dogry görnüşi saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e40_2, 'Operasiýa geçirýän lukman:', 'хирург', 'балерина', 'учёный', 'режиссёр');
    await _mcq(txn, e40_2, 'Film düşürýän:', 'режиссёр', 'писатель', 'хирург', 'изобретатель');
    await _mcq(txn, e40_2, 'Ylym bilen meşgullanýan:', 'учёный', 'писатель', 'режиссёр', 'хирург');
    await _mcq(txn, e40_2, 'Goşgy ýazýan:', 'поэт', 'учёный', 'хирург', 'изобретатель');
    final e40_3 = await txn.insert(DbConstants.tExercises, {'lesson_id': 40, 'exercise_number': 3, 'title_tk': 'Tekst soroglary — «Kim bilen buýsanýarys?»', 'instruction_tk': 'Tekste görä dogry jogaby saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e40_3, 'Magtymguly Pyragy kim boldy?', 'Beýik şahyr we akyldar', 'Lukman', 'Alym', 'Sazanda');
    await _mcq(txn, e40_3, 'Beýik adamlaryň umumy häsiýeti?', 'Halka peýdaly iş etmek', 'Köp pul gazanmak', 'Şöhrat islemek', 'Uzak ýaşamak');
    await _mcq(txn, e40_3, 'Her nesilde näme bolýar?', 'Öz gahrymanlary döreýär', 'Bir gahryman bolýar', 'Gahryman bolmaýar', 'Üýtgemeýär');
    await _mcq(txn, e40_3, 'Türkmenistanyň beýik adamy?', 'Magtymguly Pyragy', 'Diňe taryhy şahslar', 'Ýokdur', 'Bilinmeýär');
    final e41_1 = await txn.insert(DbConstants.tExercises, {'lesson_id': 41, 'exercise_number': 1, 'title_tk': 'Sözler — Flash kart', 'instruction_tk': 'Rusça sözi görüň, türkmen manysyny ýatda saklaň.', 'exercise_type': DbConstants.exerciseFlashcard, 'order_index': 1}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e41_1, 'question_order': 0, 'question_text': 'наводнение', 'correct_answer': 'suw joşguny'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e41_1, 'question_order': 1, 'question_text': 'пожар', 'correct_answer': 'ot ýangyny'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e41_1, 'question_order': 2, 'question_text': 'землетрясение', 'correct_answer': 'ýer titremesi'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e41_1, 'question_order': 3, 'question_text': 'спасатель', 'correct_answer': 'halas ediji'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e41_1, 'question_order': 4, 'question_text': 'беженец', 'correct_answer': 'bosgun'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e41_1, 'question_order': 5, 'question_text': 'безработица', 'correct_answer': 'işsizlik'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e41_1, 'question_order': 6, 'question_text': 'загрязнение', 'correct_answer': 'hapalama'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': e41_1, 'question_order': 7, 'question_text': 'равнодушие', 'correct_answer': 'biparhlyk'}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final e41_2 = await txn.insert(DbConstants.tExercises, {'lesson_id': 41, 'exercise_number': 2, 'title_tk': 'Tebigy hadysa — dogry at', 'instruction_tk': 'Dogry görnüşi saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 2}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e41_2, 'Derýanyň joşup daşyna çykmagy:', 'наводнение', 'пожар', 'смерч', 'цунами');
    await _mcq(txn, e41_2, 'Ýeriň titremegi:', 'землетрясение', 'взрыв', 'смерч', 'наводнение');
    await _mcq(txn, e41_2, 'Deňiz tolkuny:', 'цунами', 'наводнение', 'смерч', 'взрыв');
    await _mcq(txn, e41_2, 'Dowamly güýçli ot:', 'пожар', 'взрыв', 'цунами', 'землетрясение');
    final e41_3 = await txn.insert(DbConstants.tExercises, {'lesson_id': 41, 'exercise_number': 3, 'title_tk': 'Tekst soroglary — «Sosyal meseleler»', 'instruction_tk': 'Tekste görä dogry jogaby saýlaň.', 'exercise_type': DbConstants.exerciseMultipleChoice, 'order_index': 3}, conflictAlgorithm: ConflictAlgorithm.ignore);
    await _mcq(txn, e41_3, 'Garyplyk näme?', 'Girdejiniň azdanlygy we ýaşaýyş şertleriniň agyrlygy', 'Işsizlik', 'Köp pul gazanmak', 'Baý bolmak');
    await _mcq(txn, e41_3, 'Işsizlik nämä getirip biler?', 'Ogurlyk, garyplyk', 'Diňe baýlyga', 'Hiç zada', 'Saglyga peýdaly');
    await _mcq(txn, e41_3, 'Emigrasiýa näme?', 'Başga ýurda göçmek', 'Öz ýurtda göçmek', 'Dynç almak', 'Syýahat');
    await _mcq(txn, e41_3, 'Sosyal meseleleri çözmek üçin?', 'Bilelikde tagalla etmek', 'Biparh bolmak', 'Başgasyna bildirmek', 'Garaşmak');
  }

  static Future<void> _seedReadingTexts(Transaction txn) async {
    final texts = [
      {'lesson_id': 34, 'title_ru': 'На даче', 'content_ru': 'Добро пожаловать на нашу дачу! Меня зовут Мердан, а это моя жена Гюльшат. Сейчас мы оба на пенсии. По профессии я слесарь и мне очень нравится строить. Всю мебель на даче я делал своими руками. Снаружи кажется, что дом не очень большой. Но в нём есть два этажа, подвал, чердак и веранда. Вот первый этаж. Здесь находится гостиная и кухня. А в центре стоит большой круглый стол. Летом мы часто обедаем на веранде, а ужинаем на кухне. Вечером здесь всегда много комаров, поэтому ужин на веранде — не самая хорошая идея. Моё любимое место в гостиной — это кресло у камина. Зимой мы любим сидеть у камина и пить чай. Когда у нас есть гости, мы всегда делаем шашлык. Угощайтесь!'},
      {'lesson_id': 35, 'title_ru': 'Выходные в Ашгабате', 'content_ru': 'В Ашгабате есть столько театров, кинотеатров, концертов и музеев, что сидеть дома — это просто преступление! Главное — это подготовка. Я всегда ищу недорогие спектакли и концерты заранее. В Интернете я всегда нахожу билеты со скидкой. Зимой я часто хожу в театр, а летом я предпочитаю концерты на свежем воздухе. Когда мы идём в театр, мы всегда одеваемся красиво. Сначала мы получаем билеты в кассе, а потом оставляем пальто в гардеробе. Обычно мы берём места в амфитеатре. Больше всего мы любим классические спектакли, балеты и оперы.'},
      {'lesson_id': 36, 'title_ru': 'Наш семейный портрет', 'content_ru': 'У нас дома есть семейный портрет. Он висит на стене в гостиной. Дело в том, что мой старший брат — художник. Он рисовал этот портрет целый год. В центре картины вы видите нашего папу. Его зовут Овез. Папа уже пожилой, но очень привлекательный мужчина. Он работает преподавателем в университете. Папа высокий и стройный. Как видите, он носит бороду и очки. Обычно папа серьёзный, но на самом деле он часто смеётся и любит шутить. Рядом с папой стоит наша мама. Её зовут Марал. У неё короткие светлые волосы. Мама немного полная. Дело в том, что мама работает кондитером в булочной. Моего старшего брата зовут Сердар. Он очень похож на нашего отца. Сейчас Сердар работает дизайнером. А это я. Все говорят, что я похожа на маму. Я воспитатель и хочу работать в детском саду.'},
      {'lesson_id': 37, 'title_ru': 'Ашгабат — столица Туркменистана', 'content_ru': 'Ашгабат находится в центре Туркменистана, у подножия гор Копетдаг. На сегодняшний день это один из самых красивых и современных городов Центральной Азии. Здесь живут около полутора миллионов человек. Население Ашгабата увеличивается с каждым годом. В центре Ашгабата находится много красивых белых зданий, парков и фонтанов. Особенно известен монумент Нейтралитета. Если вы хотите увидеть традиционный туркменский базар, вы должны посетить рынок Толкучка. Там можно купить туркменские ковры, национальные игрушки и вкусные национальные блюда. Туркменистан — красивая и богатая страна!'},
      {'lesson_id': 38, 'title_ru': 'В заповеднике', 'content_ru': 'Вы знаете, что такое заповедник? Заповедник — это место, где все растения, животные, птицы и насекомые защищены от воздействия человека. Здесь нельзя охотиться, бросать мусор или рубить деревья. Меня зовут Азат. Я биолог. Сегодня я еду на экскурсию в Репетекский заповедник первый раз. Туда нужно ехать на машине, потому что ходить по территории пешком слишком трудно и опасно. В Репетекском заповеднике обитают редкие животные: гепард, джейран и варан. Гепард — это самое быстрое животное на Земле! В заповеднике понимаешь, что природа каждого региона уникальна. Люди, не разрушайте эту красоту. Цените и берегите природу нашей Родины!'},
      {'lesson_id': 39, 'title_ru': 'Наши любимые праздники', 'content_ru': 'В каждой стране и в каждой семье праздники отмечаются по-своему. Некоторые любят тихие семейные праздники, а другие предпочитают шумные вечеринки в большом кругу друзей. Мне, к примеру, очень нравится Новый год. Обычно мы с друзьями отмечаем Новый год в ресторане. В новогоднее меню всегда входит плов, самса, шашлык и другие типичные блюда. А вот моей сестре не очень нравятся вечеринки. Её любимый праздник — это Масленица. Масленица отмечается весной и длится целую неделю. Ещё один любимый праздник — Международный женский день. Он отмечается 8 марта. Папа всегда дарит маме букет цветов и конфеты.'},
      {'lesson_id': 40, 'title_ru': 'Кем мы гордимся?', 'content_ru': 'У каждого народа есть свои герои. Обычно это люди, которые оставили важный след в истории своей страны. Несомненно, это Махтумкули Фраги. Он был великим поэтом и мыслителем туркменского народа. Махтумкули жил в XVIII веке. Его стихи полны мудрости и любви к родине. Его поэзия до сих пор вдохновляет миллионы людей. Кроме того, в Туркменистане есть много писателей, художников, учёных и спортсменов, которыми мы гордимся. Великие люди есть в каждом поколении. Возможно, кто-то из вас тоже когда-нибудь станет героем для своего народа и своей страны.'},
      {'lesson_id': 41, 'title_ru': 'Социальные проблемы', 'content_ru': 'Человечество не стоит на месте. Оно постоянно развивается, делает научные открытия и учится на своих ошибках. Однако, на каждом этапе развития в обществе возникают социальные проблемы. Одна из самых древних социальных проблем — это бедность. Частая причина бедности — это безработица. Безработица заставляет людей жить на социальные пособия или идти на такие преступления, как воровство. Иногда из-за безработицы люди должны менять место жительства. Они переезжают в другие регионы и страны, чтобы найти работу. Страна теряет своих специалистов. Каждая страна старается решить социальные проблемы по-своему. Главная причина многих проблем — это равнодушие людей. Чтобы изменить мир к лучшему, нужно стараться помогать друг другу.'},
    ];
    for (final t in texts) { await txn.insert(DbConstants.tReadingTexts, t, conflictAlgorithm: ConflictAlgorithm.ignore); }
  }

  static Future<void> _seedLessonProgress(Transaction txn) async {
    for (int i = 34; i <= 41; i++) {
      await txn.insert(DbConstants.tLessonProgress, {'lesson_id': i, 'vocab_studied': 0, 'dialogs_read': 0, 'exercises_done': 0, 'exercises_total': 3, 'score_percent': 0.0, 'is_completed': 0}, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  static Future<void> _d(Transaction txn, int lessonId, int num, String name, String ctx, List<List<String>> lines) async {
    final id = await txn.insert(DbConstants.tDialogs, {'lesson_id': lessonId, 'dialog_number': num, 'dialog_name': name, 'context_tk': ctx, 'category': DbConstants.dialogCategoryLesson}, conflictAlgorithm: ConflictAlgorithm.ignore);
    for (int i = 0; i < lines.length; i++) {
      await txn.insert(DbConstants.tDialogLines, {'dialog_id': id, 'line_order': i, 'speaker': lines[i][0], 'text_ru': lines[i][1], 'text_tk': lines[i][2]}, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  static Future<void> _mcq(Transaction txn, int exId, String q, String a, String w1, String w2, String w3) async {
    final qId = await txn.insert(DbConstants.tExerciseQuestions, {'exercise_id': exId, 'question_order': q.hashCode.abs() % 1000, 'question_text': q, 'correct_answer': a}, conflictAlgorithm: ConflictAlgorithm.ignore);
    final opts = [a, w1, w2, w3]..shuffle();
    for (final o in opts) {
      await txn.insert(DbConstants.tExerciseOptions, {'question_id': qId, 'option_text': o, 'is_correct': o == a ? 1 : 0}, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }
}