import 'package:sqflite/sqflite.dart';
import '../../core/constants/db_constants.dart';

/// Kitaphana bölüminiň ähli datasy:
///   - Gündelik frazalar (dialogs category='phrase')
///   - Ýagdaý dialoglar (dialogs category='situational')
///   - Iň köp ulanylýan sözler kontekst bilen (vocabulary category='top_words')
///   - Söz düzümleri (vocabulary category='phrases')
///   - Özbaşdak gönükmeler (exercises is_standalone=1)
class DatabaseSeederLibrary {
  static Future<void> seed(Database db) async {
    await db.transaction((txn) async {
      await _seedPhraseDialogs(txn);
      await _seedSituationalDialogs(txn);
      await _seedTopWords(txn);
      await _seedWordPhrases(txn);
      await _seedStandaloneExercises(txn);
    });
  }

  // ══════════════════════════════════════════════════════════
  // 1. GÜNDELIK FRAZALAR — category='phrase'
  //    lesson_id=null (sapaga bagly däl)
  //    dialog_number 501+
  // ══════════════════════════════════════════════════════════
  static Future<void> _seedPhraseDialogs(Transaction txn) async {
    final phrases = [
      {
        'name': 'Salam berme we hoşlaşmak',
        'context': 'Gündelik duşuşykda ilkinji sözler',
        'number': 501,
        'lines': [
          ['—', 'Привет!', 'Salam! (ýakyn)'],
          ['—', 'Здравствуйте!', 'Salam! (resmi)'],
          ['—', 'Доброе утро!', 'Haýyrly irden!'],
          ['—', 'Добрый день!', 'Haýyrly gün!'],
          ['—', 'Добрый вечер!', 'Haýyrly agşam!'],
          ['—', 'Пока! / До свидания!', 'Hoş gal! / Hoş boluň!'],
          ['—', 'До завтра!', 'Ertir görüşeli!'],
          ['—', 'Увидимся!', 'Görüşeris!'],
          ['—', 'Спокойной ночи!', 'Gowy uky!'],
        ],
      },
      {
        'name': 'Ýagdaý soramak',
        'context': 'Tanyşyňy göreniňde',
        'number': 502,
        'lines': [
          ['A', 'Как дела?', 'Ýagdaý nähili?'],
          ['B', 'Хорошо, спасибо! А у тебя?', 'Gowy, sag bol! Seniňki?'],
          ['A', 'Тоже хорошо!', 'Meniňki hem gowy!'],
          ['—', 'Как жизнь?', 'Durmuş nähili?'],
          ['—', 'Всё отлично!', 'Hemme zat ajaýyp!'],
          ['—', 'Неплохо.', 'Erbetleşip gidenok.'],
          ['—', 'Нормально.', 'Kadaly.'],
          ['—', 'Устал(а).', 'Ýadaw.'],
          ['—', 'Не очень хорошо.', 'Gaty gowy däl.'],
        ],
      },
      {
        'name': 'Minnetdarlyk we ötünç soramak',
        'context': 'Hoşniýetlilik sözleri',
        'number': 503,
        'lines': [
          ['—', 'Спасибо!', 'Sag bol!'],
          ['—', 'Большое спасибо!', 'Köp sag bol!'],
          ['—', 'Спасибо большое!', 'Örän köp sag bol!'],
          ['—', 'Пожалуйста.', 'Dälde näme. / Haýyşt.'],
          ['—', 'Не за что.', 'Gerek däl, zat etmedi.'],
          ['—', 'Извините!', 'Bagyşlaň! (resmi)'],
          ['—', 'Прости!', 'Bagyşla! (ýakyn)'],
          ['—', 'Простите, пожалуйста.', 'Bagyşlaň, haýyşt.'],
          ['—', 'Ничего страшного.', 'Geçer, hiç zat däl.'],
        ],
      },
      {
        'name': 'Haýyş etmek we rugsat soramak',
        'context': 'Haçan bir zat gerek bolanda',
        'number': 504,
        'lines': [
          ['—', 'Можно…?', 'Bolarmı…? / Rugsat barmy?'],
          ['—', 'Помогите, пожалуйста!', 'Kömek ediň, haýyşt!'],
          ['—', 'Скажите, пожалуйста…', 'Aýdyň, haýyşt…'],
          ['—', 'Повторите, пожалуйста!', 'Gaýtalaň, haýyşt!'],
          ['—', 'Говорите медленнее!', 'Haýalrak gürläň!'],
          ['—', 'Я не понимаю.', 'Düşünemok.'],
          ['—', 'Не могли бы вы…?', 'Mümkin bolsa…? (resmi)'],
          ['—', 'Дайте мне, пожалуйста…', 'Maňa beriň, haýyşt…'],
        ],
      },
      {
        'name': 'Ylalaşmak we ret etmek',
        'context': 'Pikirini aýtmak',
        'number': 505,
        'lines': [
          ['—', 'Да, конечно!', 'Hawa, elbetde!'],
          ['—', 'Хорошо.', 'Bolýar.'],
          ['—', 'Согласен(на).', 'Ylalaşýaryn.'],
          ['—', 'Отлично!', 'Ajaýyp!'],
          ['—', 'Нет, спасибо.', 'Ýok, sag bol.'],
          ['—', 'К сожалению, нет.', 'Gynansam-da, ýok.'],
          ['—', 'Не могу.', 'Bilmok.'],
          ['—', 'Может быть.', 'Bolup biler.'],
          ['—', 'Не знаю.', 'Bilemok.'],
        ],
      },
      {
        'name': 'Özüňi tanatmak',
        'context': 'Tanyş bolanyňda',
        'number': 506,
        'lines': [
          ['A', 'Как тебя зовут?', 'Adyň näme?'],
          ['B', 'Меня зовут Азат.', 'Meniň adym Azat.'],
          ['A', 'Очень приятно! Я — Мерьем.', 'Örän şatdyryn! Men Meryem.'],
          ['—', 'Откуда ты?', 'Sen nireden?'],
          ['—', 'Я из Туркменистана.', 'Men Türkmenistandan.'],
          ['—', 'Сколько тебе лет?', 'Seniň ýaşyň näçe?'],
          ['—', 'Мне двадцать лет.', 'Meniň ýigrim ýaşym bar.'],
          ['—', 'Кем ты работаешь?', 'Sen nirä işleýärsiň?'],
          ['—', 'Я — студент / учитель.', 'Men talyp / mugallym.'],
        ],
      },
      {
        'name': 'Wagt we sene',
        'context': 'Wagt we senäni aýtmak',
        'number': 507,
        'lines': [
          ['—', 'Который час?', 'Sagat näçe?'],
          ['—', 'Сейчас три часа.', 'Häzir sagat üç.'],
          ['—', 'Сейчас полдень.', 'Häzir günortan.'],
          ['—', 'Утром / Вечером', 'Irden / Agşam'],
          ['—', 'Сегодня / Завтра / Вчера', 'Bu gün / Ertir / Düýn'],
          ['—', 'На этой неделе', 'Şu hepde'],
          ['—', 'В понедельник', 'Duşenbe güni'],
          ['—', 'Какой сегодня день?', 'Bu gün näçesi?'],
          ['—', 'Сегодня первое мая.', 'Bu gün birinji maý.'],
        ],
      },
      {
        'name': 'San we mukdar',
        'context': 'Mukdar sorananda',
        'number': 508,
        'lines': [
          ['—', 'Сколько стоит?', 'Bahasy näçe?'],
          ['—', 'Сколько это стоит?', 'Bu näçä durýar?'],
          ['—', 'Это дорого.', 'Bu gymmat.'],
          ['—', 'Это дёшево.', 'Bu arzan.'],
          ['—', 'Дайте мне два, пожалуйста.', 'Maňa iki sany beriň.'],
          ['—', 'Немного / Много', 'Az / Köp'],
          ['—', 'Достаточно.', 'Ýeterlik.'],
          ['—', 'Хватит!', 'Ýetdi!'],
        ],
      },
      {
        'name': 'Telefon söhbeti',
        'context': 'Telefonda gürleşmek',
        'number': 509,
        'lines': [
          ['—', 'Алло!', 'Alo!'],
          ['—', 'Это вы, Азат?', 'Bu siziňmi, Azat?'],
          ['—', 'Да, это я.', 'Hawa, men.'],
          ['—', 'Минуту, пожалуйста.', 'Bir minut, haýyşt.'],
          ['—', 'Перезвоните позже.', 'Soňrak jaň ediň.'],
          ['—', 'Я перезвоню.', 'Men gaýtadan jaň ederin.'],
          ['—', 'Плохо слышно.', 'Ýaramaz eşidilýär.'],
          ['—', 'До свидания!', 'Hoş!'],
        ],
      },
      {
        'name': 'Düşünmedik wagtyň',
        'context': 'Dil öwrenenler üçin zerur frazalar',
        'number': 510,
        'lines': [
          ['—', 'Я не понимаю.', 'Düşünemok.'],
          ['—', 'Повторите, пожалуйста.', 'Gaýtalaň, haýyşt.'],
          ['—', 'Говорите медленнее.', 'Haýalrak gürläň.'],
          ['—', 'Что это значит?', 'Bu näme diýmegi?'],
          ['—', 'Как это по-русски?', 'Rusça bu nähili?'],
          ['—', 'Как это по-туркменски?', 'Türkmençe bu nähili?'],
          ['—', 'Напишите, пожалуйста.', 'Ýazyň, haýyşt.'],
          ['—', 'Я немного говорю по-русски.', 'Men biraz rusça gürleýärin.'],
        ],
      },
    ];

    for (final p in phrases) {
      final id = await txn.insert(DbConstants.tDialogs, {
        'lesson_id': null,
        'dialog_number': p['number'],
        'dialog_name': p['name'],
        'context_tk': p['context'],
        'category': DbConstants.dialogCategoryPhrase,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      await _insertLines(txn, id, p['lines'] as List);
    }
  }

  // ══════════════════════════════════════════════════════════
  // 2. ÝAGDAÝ DIALOGLAR — category='situational'
  //    Hakyky durmuş ýagdaýlary üçin doly dialoglar
  //    dialog_number 601+
  // ══════════════════════════════════════════════════════════
  static Future<void> _seedSituationalDialogs(Transaction txn) async {
    final dialogs = [
      {
        'name': 'Restoranda nahar sargyt etmek',
        'context': 'Kafede ofisant bilen',
        'number': 601,
        'lines': [
          ['Ofis', 'Добро пожаловать! Вы готовы заказать?', 'Hoş geldiňiz! Sargyt etmäge taýynmy?'],
          ['Müşd', 'Да. Что вы рекомендуете?', 'Hawa. Näme maslahat berýärsiňiz?'],
          ['Ofis', 'Борщ очень вкусный сегодня.', 'Bu gün borş örän lezzetli.'],
          ['Müşd', 'Хорошо, борщ и чай, пожалуйста.', 'Bolýar, borş we çaý, haýyşt.'],
          ['Ofis', 'С молоком или без?', 'Süýtli ýa-da süýtsiz?'],
          ['Müşd', 'Без молока.', 'Süýtsiz.'],
          ['Ofis', 'Хорошо. Что-нибудь ещё?', 'Bolýar. Başga bir zat?'],
          ['Müşd', 'Нет, спасибо. Это всё.', 'Ýok, sag bol. Şol ýeterlik.'],
          ['Müşd', 'Можно счёт, пожалуйста?', 'Hasap alyp bolarmy?'],
          ['Ofis', 'Конечно! Двести рублей.', 'Elbetde! Iki ýüz rubl.'],
        ],
      },
      {
        'name': 'Dükanda haryt satyn almak',
        'context': 'Azyk dükanda',
        'number': 602,
        'lines': [
          ['Sat', 'Добрый день! Чем могу помочь?', 'Haýyrly gün! Nähili kömek edip bilerin?'],
          ['Al', 'Здравствуйте! Мне нужен хлеб и молоко.', 'Salam! Maňa çörek we süýt gerek.'],
          ['Sat', 'Какое молоко — 1 литр или 2?', 'Süýt — 1 litr ýa-da 2?'],
          ['Al', 'Один литр, пожалуйста.', 'Bir litr, haýyşt.'],
          ['Sat', 'Что-нибудь ещё?', 'Başga bir zat?'],
          ['Al', 'Есть яблоки?', 'Alma barmy?'],
          ['Sat', 'Да, вот свежие.', 'Hawa, ine täzeleri.'],
          ['Al', 'Дайте килограмм.', 'Bir kilogram beriň.'],
          ['Sat', 'С вас триста рублей.', 'Sizden üç ýüz rubl.'],
          ['Al', 'Вот, пожалуйста. Спасибо!', 'Ine. Sag boluň!'],
        ],
      },
      {
        'name': 'Lukmana barmak',
        'context': 'Saglyk öýünde',
        'number': 603,
        'lines': [
          ['Lukm', 'Здравствуйте! На что жалуетесь?', 'Salam! Näme şikaýatyňyz bar?'],
          ['Näsag', 'Здравствуйте! У меня болит голова и горло.', 'Salam! Başym we bokurdagym agyrýar.'],
          ['Lukm', 'Как давно?', 'Näçe wagt bäri?'],
          ['Näsag', 'Со вчерашнего вечера.', 'Düýnki agşamdan bäri.'],
          ['Lukm', 'Температура есть?', 'Gyzzyrma barmy?'],
          ['Näsag', 'Да, тридцать восемь.', 'Hawa, otuz sekiz.'],
          ['Lukm', 'Откройте рот. Скажите «А-а-а».', 'Agzyňyzy açyň. «A-a-a» diýiň.'],
          ['Lukm', 'Ангина. Вот рецепт.', 'Angina. Ine resept.'],
          ['Näsag', 'Как принимать?', 'Nähili içmeli?'],
          ['Lukm', 'Три раза в день, после еды.', 'Günde üç gezek, iýenden soň.'],
        ],
      },
      {
        'name': 'Myhmanhanada otag almak',
        'context': 'Myhmanhana administratory bilen',
        'number': 604,
        'lines': [
          ['Adm', 'Добро пожаловать! Вы бронировали номер?', 'Hoş geldiňiz! Otag sargytladyňyzmy?'],
          ['Myh', 'Да, на имя Нуров.', 'Hawa, Nurow adyna.'],
          ['Adm', 'Одну минуту… Да, номер 215.', 'Bir minut… Hawa, 215-nji otag.'],
          ['Myh', 'На сколько ночей?', 'Näçe gije?'],
          ['Adm', 'У вас на три ночи, верно?', 'Siziňki üç gije, dogry?'],
          ['Myh', 'Да, верно. Завтрак включён?', 'Hawa, dogry. Ertirlik girýärmi?'],
          ['Adm', 'Да, с 7 до 10.', 'Hawa, 7-den 10-a çenli.'],
          ['Myh', 'Отлично! Где лифт?', 'Ajaýyp! Lift nirede?'],
          ['Adm', 'Прямо и направо.', 'Göni we saga.'],
          ['Myh', 'Спасибо!', 'Sag boluň!'],
        ],
      },
      {
        'name': 'Ulag duralgasynda bilet almak',
        'context': 'Awtobus stansiýasynda',
        'number': 605,
        'lines': [
          ['Al', 'Здравствуйте! Один билет до Москвы.', 'Salam! Moskwa çenli bir bilet.'],
          ['Kas', 'На какой день?', 'Haýsy güne?'],
          ['Al', 'На завтра, пожалуйста.', 'Ertire, haýyşt.'],
          ['Kas', 'Утром или вечером?', 'Irden ýa-da agşam?'],
          ['Al', 'Утром, если есть.', 'Irden, bar bolsa.'],
          ['Kas', 'Есть в 8:30. Цена — пятьсот рублей.', '8:30-da bar. Bahasy — bäş ýüz rubl.'],
          ['Al', 'Хорошо, возьму.', 'Bolýar, alaryn.'],
          ['Kas', 'Ваш паспорт, пожалуйста.', 'Pasportyňyz, haýyşt.'],
          ['Al', 'Вот, пожалуйста.', 'Ine, haýyşt.'],
          ['Kas', 'Ваш билет. Счастливого пути!', 'Biletiňiz. Hoş ýol!'],
        ],
      },
      {
        'name': 'Ugur soramak',
        'context': 'Köçede ýol soramak',
        'number': 606,
        'lines': [
          ['A', 'Извините, как пройти до метро?', 'Bagyşlaň, metro nähili barmaly?'],
          ['B', 'Идите прямо, потом направо.', 'Göni gidiň, soňra saga.'],
          ['A', 'Далеко идти?', 'Ýöremek uzakmy?'],
          ['B', 'Минут десять пешком.', 'Ýöräp on minut.'],
          ['A', 'Спасибо большое!', 'Köp sag bol!'],
          ['B', 'Пожалуйста!', 'Dälde näme!'],
          ['—', 'Налево / Направо / Прямо', 'Çepe / Saga / Göni'],
          ['—', 'На углу / Рядом', 'Burçda / Ýanynda'],
        ],
      },
      {
        'name': 'Bankomatta we bankda',
        'context': 'Bank işleri',
        'number': 607,
        'lines': [
          ['Işg', 'Здравствуйте! Чем могу помочь?', 'Salam! Nähili kömek edip bilerin?'],
          ['Müş', 'Хочу открыть счёт.', 'Hasap açmak isleýärin.'],
          ['Işg', 'Паспорт и ИНН, пожалуйста.', 'Pasport we INN, haýyşt.'],
          ['Müş', 'Вот документы.', 'Ine resminamalar.'],
          ['Işg', 'Карта будет готова через 5 дней.', 'Kart 5 günden taýýar bolar.'],
          ['Müş', 'Можно снять деньги здесь?', 'Pul çekip bolarmy şu ýerde?'],
          ['Işg', 'Да, банкомат — справа.', 'Hawa, bankomat — sagda.'],
          ['Müş', 'Спасибо!', 'Sag boluň!'],
        ],
      },
      {
        'name': 'Iş söhbetdeşligi',
        'context': 'Iş interwiýusy',
        'number': 608,
        'lines': [
          ['Işb', 'Расскажите о себе.', 'Özüňiz barada gürrüň beriň.'],
          ['Dala', 'Я окончил университет в 2020 году.', 'Men 2020-nji ýylda uniwersiteti gutardym.'],
          ['Işb', 'Какой у вас опыт работы?', 'Iş tejribäňiz näçe ýyl?'],
          ['Dala', 'Три года в IT-компании.', 'IT kompaniýasynda üç ýyl.'],
          ['Işb', 'Почему вы хотите работать у нас?', 'Näme üçin bizde işlemek isleýärsiňiz?'],
          ['Dala', 'Ваша компания известна качеством.', 'Siziň kompaniýaňyz hili bilen meşhur.'],
          ['Işb', 'Каковы ваши ожидания по зарплате?', 'Aýlyk gatlaşyňyz nähili?'],
          ['Dala', 'Я готов обсудить этот вопрос.', 'Bu meseläni ara alyp maslahatlaşmaga taýyn.'],
        ],
      },
    ];

    for (final d in dialogs) {
      final id = await txn.insert(DbConstants.tDialogs, {
        'lesson_id': null,
        'dialog_number': d['number'],
        'dialog_name': d['name'],
        'context_tk': d['context'],
        'category': DbConstants.dialogCategorySituational,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      await _insertLines(txn, id, d['lines'] as List);
    }
  }

  // ══════════════════════════════════════════════════════════
  // 3. IŇ KÖP ULANYLÝAN SÖZLER — category='top_words'
  //    500 iň ýygy ulanylýan rusça söz kontekst bilen
  // ══════════════════════════════════════════════════════════
  static Future<void> _seedTopWords(Transaction txn) async {
    // A1 derejesi üçin iň möhüm 60 söz (doly 500 sözlük seeder-da giňeldilip bilner)
    final words = [
      // Esasy işlikler
      ['быть', 'bolmak', 'Я хочу быть врачом.', 'Men lukman bolmak isleýärin.', 'top_words', 1],
      ['иметь', 'bolmak (bar)', 'У меня есть книга.', 'Mende kitap bar.', 'top_words', 1],
      ['знать', 'bilmek', 'Я знаю русский язык.', 'Men rus dilini bilýärin.', 'top_words', 1],
      ['мочь', 'bilmek (başarmak)', 'Я могу говорить.', 'Men gürläp bilýärin.', 'top_words', 1],
      ['хотеть', 'islemek', 'Она хочет учиться.', 'Ol okamak isleýär.', 'top_words', 1],
      ['говорить', 'gürlemek', 'Говорите медленнее!', 'Haýalrak gürläň!', 'top_words', 1],
      ['идти', 'gitmek (pyýada)', 'Я иду домой.', 'Men öýe barýaryn.', 'top_words', 1],
      ['делать', 'etmek', 'Что ты делаешь?', 'Sen näme edýärsiň?', 'top_words', 1],
      ['работать', 'işlemek', 'Он работает в школе.', 'Ol mekdepde işleýär.', 'top_words', 1],
      ['думать', 'pikir etmek', 'Я думаю, что да.', 'Pikir edýärin, hawa.', 'top_words', 1],
      ['читать', 'okamak', 'Мы читаем книгу.', 'Biz kitap okaýarys.', 'top_words', 1],
      ['писать', 'ýazmak', 'Пишите аккуратно!', 'Arassa ýazyň!', 'top_words', 1],
      ['жить', 'ýaşamak', 'Где вы живёте?', 'Siz nirede ýaşaýarsyňyz?', 'top_words', 1],
      ['любить', 'söýmek / halaýar', 'Я люблю музыку.', 'Men sazy gowy görýärin.', 'top_words', 1],
      ['понимать', 'düşünmek', 'Ты понимаешь меня?', 'Maňa düşünýärsiňmi?', 'top_words', 1],
      // Esasy atlar
      ['человек', 'adam', 'Он хороший человек.', 'Ol gowy adam.', 'top_words', 1],
      ['время', 'wagt', 'У меня нет времени.', 'Meniň wagtym ýok.', 'top_words', 1],
      ['дело', 'iş / ýagdaý', 'Как твои дела?', 'Ýagdaýyň nähili?', 'top_words', 1],
      ['день', 'gün', 'Добрый день!', 'Haýyrly gün!', 'top_words', 1],
      ['год', 'ýyl', 'В этом году.', 'Şu ýyl.', 'top_words', 1],
      ['рука', 'el', 'Дайте руку.', 'Eliňizi beriň.', 'top_words', 1],
      ['работа', 'iş', 'Где ваша работа?', 'Siziň iş ýeriňiz nirede?', 'top_words', 1],
      ['слово', 'söz', 'Новое слово.', 'Täze söz.', 'top_words', 1],
      ['место', 'ýer', 'Свободное место.', 'Boş ýer.', 'top_words', 1],
      ['вопрос', 'sorag', 'У меня есть вопрос.', 'Mende sorag bar.', 'top_words', 1],
      ['ответ', 'jogap', 'Правильный ответ.', 'Dogry jogap.', 'top_words', 1],
      ['друг', 'dost', 'Мой лучший друг.', 'Meniň iň gowy dosdum.', 'top_words', 1],
      ['дом', 'öý / jaý', 'Я иду домой.', 'Men öýe barýaryn.', 'top_words', 1],
      ['город', 'şäher', 'Большой город.', 'Uly şäher.', 'top_words', 1],
      ['страна', 'ýurt / döwlet', 'Красивая страна.', 'Owadan ýurt.', 'top_words', 1],
      // Esasy sypatlyklary
      ['хороший', 'gowy', 'Хороший день.', 'Gowy gün.', 'top_words', 1],
      ['новый', 'täze', 'Новый телефон.', 'Täze telefon.', 'top_words', 1],
      ['большой', 'uly', 'Большой дом.', 'Uly öý.', 'top_words', 1],
      ['маленький', 'kiçi', 'Маленький ребёнок.', 'Kiçi çaga.', 'top_words', 1],
      ['красивый', 'owadan', 'Красивый город.', 'Owadan şäher.', 'top_words', 1],
      ['трудный', 'kyn', 'Трудный вопрос.', 'Kyn sorag.', 'top_words', 1],
      ['лёгкий', 'ýeňil', 'Лёгкое задание.', 'Ýeňil ýumuş.', 'top_words', 1],
      ['нужный', 'gerekli', 'Нужная информация.', 'Gerekli maglumat.', 'top_words', 1],
      // Esasy baglanyşdyryjylar
      ['и', 'we', 'Я и ты.', 'Men we sen.', 'top_words', 1],
      ['но', 'ýöne', 'Хочу, но не могу.', 'Isleýärin, ýöne bilemok.', 'top_words', 1],
      ['или', 'ýa-da', 'Чай или кофе?', 'Çaý ýa-da kofe?', 'top_words', 1],
      ['потому что', 'sebäbi', 'Я устал, потому что работал.', 'Ýadaw, sebäbi işledim.', 'top_words', 1],
      ['если', 'eger', 'Если хочешь, иди.', 'Eger isleseň, git.', 'top_words', 1],
      ['когда', 'haçan', 'Когда ты придёшь?', 'Haçan gelýärsiň?', 'top_words', 1],
      ['где', 'nirede', 'Где ты?', 'Sen nirede?', 'top_words', 1],
      ['уже', 'eýýäm', 'Я уже дома.', 'Men eýýäm öýde.', 'top_words', 1],
      ['ещё', 'heniz / ýene', 'Ещё раз.', 'Ýene bir gezek.', 'top_words', 1],
      ['очень', 'örän', 'Очень хорошо!', 'Örän gowy!', 'top_words', 1],
      ['тоже', 'hem', 'Я тоже хочу.', 'Men hem isleýärin.', 'top_words', 1],
      ['только', 'diňe', 'Только ты.', 'Diňe sen.', 'top_words', 1],
    ];

    for (final w in words) {
      await txn.insert(DbConstants.tVocabulary, {
        'lesson_id': null,
        'word_ru': w[0],
        'word_tk': w[1],
        'example_ru': w[2],
        'example_tk': w[3],
        'category': w[4],
        'difficulty': w[5],
        'image_path': null,
        'audio_path': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ══════════════════════════════════════════════════════════
  // 4. SÖZ DÜZÜMLERI — category='phrases'
  //    Sözleriň sözlem içindäki ulanylyşy
  // ══════════════════════════════════════════════════════════
  static Future<void> _seedWordPhrases(Transaction txn) async {
    final phrases = [
      // Hoşniýetlilik
      ['Как дела?', 'Ýagdaý nähili?', 'Тебе плохо? Как дела?', 'Saňa ýaman boldy? Ýagdaý nähili?', 'phrases', 1],
      ['Всё хорошо.', 'Hemme zat gowy.', 'Не беспокойся, всё хорошо.', 'Alada etme, hemme zat gowy.', 'phrases', 1],
      ['Не за что!', 'Gerek däl!', '— Спасибо! — Не за что!', '— Sag bol! — Gerek däl!', 'phrases', 1],
      ['Ничего страшного.', 'Hiç zat däl.', '— Прости. — Ничего страшного.', '— Bagyşla. — Hiç zat däl.', 'phrases', 1],
      // Sorag
      ['Что это такое?', 'Bu nähili zat?', 'Что это такое? Объясни!', 'Bu nähili zat? Düşündir!', 'phrases', 1],
      ['Как вас зовут?', 'Siziň adyňyz näme?', 'Извините, как вас зовут?', 'Bagyşlaň, siziň adyňyz näme?', 'phrases', 1],
      ['Сколько стоит?', 'Bahasy näçe?', 'Сколько стоит этот телефон?', 'Bu telefonyň bahasy näçe?', 'phrases', 1],
      ['Где находится…?', '… nirede ýerleşýär?', 'Где находится аптека?', 'Dermanhana nirede ýerleşýär?', 'phrases', 1],
      ['Как далеко?', 'Näçe uzak?', 'Как далеко до центра?', 'Merkeze näçe uzak?', 'phrases', 1],
      // Haýyş
      ['Можно мне…?', 'Maňa … bolarmı?', 'Можно мне стакан воды?', 'Maňa bir bulgur suw bolarmı?', 'phrases', 1],
      ['Дайте мне…', 'Maňa … beriň.', 'Дайте мне меню.', 'Maňa menýu beriň.', 'phrases', 1],
      ['Помогите, пожалуйста!', 'Kömek ediň, haýyşt!', 'Помогите, пожалуйста, я заблудился.', 'Kömek ediň, haýyşt, ýolumy ýitirdim.', 'phrases', 1],
      // Duýgy
      ['Мне нравится.', 'Maňa ýaraýar.', 'Мне нравится эта песня.', 'Maňa bu aýdym ýaraýar.', 'phrases', 1],
      ['Я рад(а).', 'Şatdyryn.', 'Я рад тебя видеть!', 'Seni görenim üçin şatdyryn!', 'phrases', 1],
      ['Я устал(а).', 'Ýadaw.', 'Я очень устал после работы.', 'Işden soň örän ýadaw.', 'phrases', 1],
      ['Мне всё равно.', 'Parhy ýok.', 'Куда идти? — Мне всё равно.', 'Nirä gitmeli? — Parhy ýok.', 'phrases', 1],
    ];

    for (final p in phrases) {
      await txn.insert(DbConstants.tVocabulary, {
        'lesson_id': null,
        'word_ru': p[0],
        'word_tk': p[1],
        'example_ru': p[2],
        'example_tk': p[3],
        'category': p[4],
        'difficulty': p[5],
        'image_path': null,
        'audio_path': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ══════════════════════════════════════════════════════════
  // 5. ÖZBAŞDAK GÖNÜKMELER — is_standalone=1, lesson_id=null
  //    Sapaga bagly däl, kitaphana bölüminde görünýär
  // ══════════════════════════════════════════════════════════
  static Future<void> _seedStandaloneExercises(Transaction txn) async {
    // ── Gönükme 1: Iň köp ulanylýan sözler — Flash kart ──
    final e1 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': null,
      'is_standalone': 1,
      'exercise_number': 1,
      'title_tk': 'Iň köp ulanylýan 20 söz',
      'instruction_tk': 'Flash kartlar bilen sözleri ýatda saklaň.',
      'exercise_type': DbConstants.exerciseFlashcard,
      'note_tk': 'Günde 5 minut — 1 aýda ähli sözleri öwrenersiň!',
      'order_index': 1,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final flashWords = [
      ['хорошо', 'gowy / bolýar'], ['спасибо', 'sag bol'],
      ['пожалуйста', 'haýyşt / dälde näme'], ['извините', 'bagyşlaň'],
      ['да / нет', 'hawa / ýok'], ['можно', 'bolarmı'],
      ['не знаю', 'bilemok'], ['не понимаю', 'düşünemok'],
      ['хочу', 'isleýärin'], ['иду', 'barýaryn'],
      ['сколько', 'näçe'], ['где', 'nirede'],
      ['когда', 'haçan'], ['почему', 'näme üçin'],
      ['очень', 'örän'], ['уже', 'eýýäm'],
      ['ещё', 'heniz / ýene'], ['только', 'diňe'],
      ['тоже', 'hem'], ['всё', 'hemme zat'],
    ];
    for (int i = 0; i < flashWords.length; i++) {
      await txn.insert(DbConstants.tExerciseQuestions, {
        'exercise_id': e1,
        'question_order': i,
        'question_text': flashWords[i][0],
        'correct_answer': flashWords[i][1],
        'hint_tk': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }

    // ── Gönükme 2: Frazalar — Boşluk doldur ──
    final e2 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': null,
      'is_standalone': 1,
      'exercise_number': 2,
      'title_tk': 'Gündelik frazalar — boşluk doldur',
      'instruction_tk': 'Dogry sözi saýlap sözlemi tamamlaň.',
      'exercise_type': DbConstants.exerciseFillBlank,
      'note_tk': 'Iň köp ulanylýan sözlemler.',
      'order_index': 2,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final fillItems = [
      ['Как ваши _____?', 'дела', 'Как ваши дела?', ['дела', 'слова', 'книга', 'дома']],
      ['Очень _____!', 'приятно', 'Очень приятно!', ['приятно', 'трудно', 'хорошо', 'плохо']],
      ['Я не _____.', 'понимаю', 'Я не понимаю.', ['понимаю', 'знаю', 'читаю', 'иду']],
      ['_____ стоит билет?', 'Сколько', 'Сколько стоит билет?', ['Сколько', 'Какой', 'Где', 'Когда']],
      ['Говорите _____, пожалуйста.', 'медленнее', 'Говорите медленнее, пожалуйста.', ['медленнее', 'быстрее', 'громче', 'тише']],
      ['До _____ !', 'свидания', 'До свидания!', ['свидания', 'завтра', 'утра', 'вечера']],
      ['Мне _____ помощь.', 'нужна', 'Мне нужна помощь.', ['нужна', 'нужен', 'нужно', 'нужны']],
    ];
    for (int i = 0; i < fillItems.length; i++) {
      final q = await txn.insert(DbConstants.tExerciseQuestions, {
        'exercise_id': e2,
        'question_order': i,
        'question_text': fillItems[i][0],
        'correct_answer': fillItems[i][1],
        'hint_tk': fillItems[i][2],
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      final opts = fillItems[i][3] as List;
      for (final o in opts) {
        await txn.insert(DbConstants.tExerciseOptions, {
          'question_id': q,
          'option_text': o,
          'is_correct': o == fillItems[i][1] ? 1 : 0,
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    }

    // ── Gönükme 3: Ýagdaý dialoglar — Köp saýlaw ──
    final e3 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': null,
      'is_standalone': 1,
      'exercise_number': 3,
      'title_tk': 'Haýsy ýagdaýda näme aýtmaly?',
      'instruction_tk': 'Ýagdaýa laýyk dogry jogaby saýlaň.',
      'exercise_type': DbConstants.exerciseMultipleChoice,
      'note_tk': 'Real durmuş ýagdaýlary.',
      'order_index': 3,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final sitItems = [
      ['Tanyş adam bilen duşuşdyňyz, ýagdaýyny soraýarsyňyz:', 'Как дела?',
       ['Как дела?', 'До свидания!', 'Сколько стоит?', 'Помогите!']],
      ['Düşünmedik wagtyňyz näme aýdýarsyňyz?', 'Я не понимаю.',
       ['Я не понимаю.', 'Я иду домой.', 'Спасибо большое!', 'Добрый день!']],
      ['Restorandaky hasaby soraýarsyňyz:', 'Можно счёт, пожалуйста?',
       ['Можно счёт, пожалуйста?', 'Как вас зовут?', 'Где туалет?', 'Это дорого.']],
      ['Kimdir bir zat etdi, minnetdarlyk bildirýärsiňiz:', 'Спасибо большое!',
       ['Спасибо большое!', 'Извините!', 'До свидания!', 'Не за что!']],
      ['Aýdylany gaýtalamasyny haýyş edýärsiňiz:', 'Повторите, пожалуйста!',
       ['Повторите, пожалуйста!', 'Говорите быстрее!', 'Я понимаю.', 'Всё хорошо.']],
    ];
    for (int i = 0; i < sitItems.length; i++) {
      final q = await txn.insert(DbConstants.tExerciseQuestions, {
        'exercise_id': e3,
        'question_order': i,
        'question_text': sitItems[i][0],
        'correct_answer': sitItems[i][1],
        'hint_tk': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      final opts = sitItems[i][2] as List;
      for (final o in opts) {
        await txn.insert(DbConstants.tExerciseOptions, {
          'question_id': q,
          'option_text': o,
          'is_correct': o == sitItems[i][1] ? 1 : 0,
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    }

    // ── Gönükme 4: Sözleri eşletmek (Matching) ──
    final e4 = await txn.insert(DbConstants.tExercises, {
      'lesson_id': null,
      'is_standalone': 1,
      'exercise_number': 4,
      'title_tk': 'Sözleri terjimesi bilen eşlet',
      'instruction_tk': 'Rusça sözi türkmen terjiması bilen birleşdir.',
      'exercise_type': DbConstants.exerciseMatching,
      'note_tk': 'Gündelik söz goruňy güýçlendir.',
      'order_index': 4,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    final matchPairs = [
      ['утро', 'irden'], ['вечер', 'agşam'], ['ночь', 'gije'],
      ['сегодня', 'bu gün'], ['завтра', 'ertir'], ['вчера', 'düýn'],
      ['здесь', 'şu ýerde'], ['там', 'şol ýerde'], ['всегда', 'hemişe'],
      ['никогда', 'hiç haçan'],
    ];
    for (int i = 0; i < matchPairs.length; i++) {
      await txn.insert(DbConstants.tExerciseQuestions, {
        'exercise_id': e4,
        'question_order': i,
        'question_text': matchPairs[i][0],
        'correct_answer': matchPairs[i][1],
        'hint_tk': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ── Ýardamçy funksiýa ──────────────────────────────────
  static Future<void> _insertLines(
      Transaction txn, int dialogId, List lines) async {
    for (int i = 0; i < lines.length; i++) {
      await txn.insert(DbConstants.tDialogLines, {
        'dialog_id': dialogId,
        'line_order': i,
        'speaker': lines[i][0],
        'text_ru': lines[i][1],
        'text_tk': lines[i][2],
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }
}
