import 'package:sqflite/sqflite.dart';
import '../../core/constants/db_constants.dart';

/// Esasy söz goruny — sapaga bagly däl, kitaphana bölüminde görünýär.
///
/// 3 kategoriýa:
///   top_verbs    — iň köp ulanylýan işlikler (häzirki zaman + geçen + geljek)
///   top_phrases  — iň köp gürleşilende aýdylýan sözler / aňlatmalar
///   connectors   — baglaýjy sözler (sebäp, netije, garşylyk, şert...)
///
/// GELJEKDE DATA GOŞMAK ÜÇIN:
///   Her list-e täze setir goş → flutter run → databaza täzelener (dbVersion artdyr)
///   Format: ['word_ru', 'word_tk', 'example_ru', 'example_tk']
class DatabaseSeederCoreVocab {
  static Future<void> seed(Database db) async {
    await db.transaction((txn) async {
      await _seedTopVerbs(txn);
      await _seedTopPhrases(txn);
      await _seedConnectors(txn);
    });
  }

  // ══════════════════════════════════════════════════════════
  // 1. IŇ KÖP ULANYLÝAN İŞLİKLER — category='top_verbs'
  //    Her işlik: infinitif, many, mysal sözlem (rus+türkmen)
  //    Geljekde goşmak üçin: bu liste täze setir goş
  // ══════════════════════════════════════════════════════════
  static Future<void> _seedTopVerbs(Transaction txn) async {
    // Format: [rusça infinitif, türkmençe manysy, mysal (rus), mysal (tk)]
    final verbs = [
      // ── Barlyk / Eýelik ────────────────────────────────
      ['быть', 'bolmak', 'Я хочу быть врачом.', 'Men lukman bolmak isleýärin.'],
      ['иметь', 'eýe bolmak / bar bolmak', 'У меня есть время.', 'Meniň wagtym bar.'],
      ['стать', 'bolmak (geçmişde / geljekde)', 'Он стал учителем.', 'Ol mugallym boldy.'],
      ['существовать', 'ýaşamak / bar bolmak', 'Такая проблема не существует.', 'Beýle mesele ýok.'],

      // ── Hereket ────────────────────────────────────────
      ['идти', 'gitmek (pyýada, ýeke ugur)', 'Я иду в школу.', 'Men mekdebe barýaryn.'],
      ['ходить', 'gitmek (adaty, köp gezek)', 'Я хожу в школу каждый день.', 'Men her gün mekdebe barýaryn.'],
      ['ехать', 'gitmek (ulag, ýeke ugur)', 'Мы едем в Москву.', 'Biz Moskwa barýarys.'],
      ['ездить', 'gitmek (ulag, adaty)', 'Он ездит на работу на машине.', 'Ol işe maşynda barýar.'],
      ['бежать', 'ylgamak (ýeke ugur)', 'Дети бегут домой.', 'Çagalar öýe ylgaýarlar.'],
      ['бегать', 'ylgamak (adaty)', 'Я бегаю каждое утро.', 'Men her irden ylgaýaryn.'],
      ['лететь', 'uçmak (ýeke ugur)', 'Самолёт летит в Дубай.', 'Uçar Dubaýa uçýar.'],
      ['летать', 'uçmak (adaty)', 'Птицы летают высоко.', 'Guşlar belent uçýarlar.'],
      ['приходить', 'gelmek', 'Он приходит в 8 часов.', 'Ol sagat 8-de gelýär.'],
      ['уходить', 'gitmek / aýrylmak', 'Она уходит рано.', 'Ol irden gidýär.'],
      ['приезжать', 'gelmek (ulag bilen)', 'Гости приезжают завтра.', 'Myhmanlар ertir gelýärler.'],
      ['возвращаться', 'gaýdyp gelmek', 'Я возвращаюсь домой в 6.', 'Men öýe sagat 6-da gaýdýaryn.'],

      // ── Pikir / Duýgy ──────────────────────────────────
      ['думать', 'pikir etmek', 'Я думаю, что он прав.', 'Pikir edýärin, ol dogry.'],
      ['знать', 'bilmek', 'Ты знаешь ответ?', 'Sen jogaby bilýärsiňmi?'],
      ['понимать', 'düşünmek', 'Я не понимаю вопрос.', 'Men soraga düşünemok.'],
      ['помнить', 'ýatlamak / ýadynda saklamak', 'Помни об этом!', 'Muny ýatda sakla!'],
      ['забывать', 'unutmak', 'Я часто забываю ключи.', 'Men açarlary köplenç unudýaryn.'],
      ['считать', 'hasaplamak / sanap bilmek', 'Я считаю это ошибкой.', 'Muny ýalňyşlyk hasaplaýaryn.'],
      ['верить', 'ynanmak', 'Я верю тебе.', 'Men saňa ynanýaryn.'],
      ['любить', 'söýmek / gowy görmek', 'Я люблю читать.', 'Men okamany gowy görýärin.'],
      ['хотеть', 'islemek', 'Что ты хочешь?', 'Sen näme isleýärsiň?'],
      ['мочь', 'başarmak / bilmek', 'Я могу помочь.', 'Men kömek edip bilerin.'],
      ['уметь', 'başarmak (öwrenilen)', 'Он умеет готовить.', 'Ol nahar bişirip bilýär.'],
      ['нравиться', 'ýaramak / hoşlamak', 'Мне нравится эта песня.', 'Bu aýdym maňa ýaraýar.'],
      ['чувствовать', 'duýmak', 'Я чувствую усталость.', 'Men ýadawlygy duýýaryn.'],
      ['бояться', 'gorkмak', 'Он боится собак.', 'Ol itlerden gorkýar.'],
      ['надеяться', 'umyt etmek', 'Я надеюсь на лучшее.', 'Men gowulyga umyt edýärin.'],

      // ── Gürleşmek / Habar ──────────────────────────────
      ['говорить', 'gürlemek', 'Говорите медленнее!', 'Haýalrak gürläň!'],
      ['сказать', 'aýtmak (bir gezek)', 'Что он сказал?', 'Ol näme aýtdy?'],
      ['спрашивать', 'soramak', 'Он спрашивает о тебе.', 'Ol seniň barada soraýar.'],
      ['отвечать', 'jogap bermek', 'Пожалуйста, ответьте.', 'Haýyşt, jogap beriň.'],
      ['объяснять', 'düşündirmek', 'Объясни мне это.', 'Muny maňa düşündir.'],
      ['рассказывать', 'gürrüň bermek', 'Расскажи о себе.', 'Özüň barada gürrüň ber.'],
      ['писать', 'ýazmak', 'Пишите аккуратно.', 'Arassa ýazyň.'],
      ['читать', 'okamak', 'Я читаю каждый день.', 'Men her gün okaýaryn.'],
      ['слышать', 'eşitmek (öz-özünden)', 'Ты слышишь музыку?', 'Sen saz eşidýärsiňmi?'],
      ['слушать', 'diňlemek (niýetli)', 'Слушайте внимательно!', 'Ünsli diňläň!'],
      ['смотреть', 'seretmek / tomaşa etmek', 'Смотри на меня!', 'Maňa seret!'],
      ['видеть', 'görmek', 'Я вижу тебя.', 'Men seni görýärin.'],

      // ── Iş / Hereketler ────────────────────────────────
      ['делать', 'etmek / yapmak', 'Что ты делаешь?', 'Sen näme edýärsiň?'],
      ['работать', 'işlemek', 'Он работает в школе.', 'Ol mekdepde işleýär.'],
      ['учиться', 'öwrenmek / okamak', 'Она учится в университете.', 'Ol uniwersitetde okaýar.'],
      ['учить', 'öwretmek / ýatlamak', 'Учи слова каждый день.', 'Her gün sözleri öwren.'],
      ['помогать', 'kömek etmek', 'Помоги мне, пожалуйста.', 'Maňa kömek et, haýyşt.'],
      ['начинать', 'başlamak', 'Начинаем урок!', 'Sapagy başlaýarys!'],
      ['заканчивать', 'gutarmak / tamamlamak', 'Заканчивай работу.', 'Işiňi tamamla.'],
      ['открывать', 'açmak', 'Открой окно.', 'Penjireni aç.'],
      ['закрывать', 'ýapmak', 'Закрой дверь.', 'Gapyny ýap.'],
      ['покупать', 'satyn almak', 'Я покупаю хлеб.', 'Men çörek satyn alýaryn.'],
      ['продавать', 'satmak', 'Они продают машины.', 'Olar maşyn satýarlar.'],
      ['платить', 'tölemek', 'Я плачу картой.', 'Men kart bilen töleýärin.'],
      ['давать', 'bermek', 'Дай мне книгу.', 'Kitaby maňa ber.'],
      ['брать', 'almak', 'Возьми зонт.', 'Güýjegaýy al.'],
      ['жить', 'ýaşamak', 'Где вы живёте?', 'Siz nirede ýaşaýarsyňyz?'],
      ['готовить', 'nahar bişirmek', 'Мама готовит обед.', 'Eje günortan nahar bişirýär.'],
      ['есть', 'iýmek', 'Ешь медленно!', 'Haýal iý!'],
      ['пить', 'içmek', 'Пей воду!', 'Suw iç!'],
      ['спать', 'uklamak', 'Сколько ты спишь?', 'Sen näçe sagat uklаýarsyň?'],
      ['отдыхать', 'dynç almak', 'Мы отдыхаем в выходные.', 'Biz dynç günleri dynç alýarys.'],
      ['ждать', 'garaşmak', 'Жди меня здесь.', 'Meni şu ýerde garaşa.'],
      ['находить', 'tapmak', 'Я не могу найти ключи.', 'Açarlary tapyp bilemok.'],
      ['терять', 'ýitirmek', 'Я потерял телефон.', 'Telefonymy ýitirdim.'],
      ['решать', 'çözmek / karar bermek', 'Реши эту задачу.', 'Bu meseläni çöz.'],
      ['думать', 'pikir etmek', 'Я думаю каждый день.', 'Men her gün pikir edýärin.'],
    ];

    for (final v in verbs) {
      await txn.insert(DbConstants.tVocabulary, {
        'lesson_id': null,
        'word_ru': v[0],
        'word_tk': v[1],
        'example_ru': v[2],
        'example_tk': v[3],
        'category': DbConstants.vocabCategoryTopVerbs,
        'difficulty': 1,
        'image_path': null,
        'audio_path': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ══════════════════════════════════════════════════════════
  // 2. IŇ KÖP AÝDYLÝAN SÖZLER — category='top_phrases'
  //    Gündelik gürleşmede iň köp çykýan sözler we aňlatmalar
  //    Geljekde goşmak üçin: bu liste täze setir goş
  // ══════════════════════════════════════════════════════════
  static Future<void> _seedTopPhrases(Transaction txn) async {
    // Format: [rusça söz/aňlatma, türkmençe manysy, mysal (rus), mysal (tk)]
    final phrases = [
      // ── Ylalaşmak / Ret etmek ──────────────────────────
      ['да', 'hawa', 'Да, я согласен.', 'Hawa, men ylalaşýaryn.'],
      ['нет', 'ýok / ýok bolsun', 'Нет, спасибо.', 'Ýok, sag bol.'],
      ['конечно', 'elbetde', 'Конечно, помогу!', 'Elbetde, kömek ederin!'],
      ['хорошо', 'bolýar / gowy', 'Хорошо, понял.', 'Bolýar, düşündim.'],
      ['ладно', 'bolýar / tamam', 'Ладно, идём.', 'Bolýar, gideli.'],
      ['согласен / согласна', 'ylalaşýaryn', 'Я полностью согласен.', 'Men doly ylalaşýaryn.'],
      ['не согласен', 'ylalaşamok', 'Я не согласен с тобой.', 'Men saňa ylalaşamok.'],
      ['может быть', 'belki / bolup biler', 'Может быть, приду.', 'Belki, geldirin.'],
      ['наверное', 'ähtimal / görünýär', 'Наверное, он устал.', 'Ähtimal, ol ýadawdyr.'],
      ['точно', 'takyk / hawa hawa', 'Точно, ты прав!', 'Takyk, sen dogry!'],
      ['именно', 'hut şeýle / edil şoňa meňzeş', 'Именно это я имел в виду.', 'Hut şuny aýtmak istedim.'],
      ['правда', 'dogry / hakykat', 'Это правда!', 'Bu hakykat!'],
      ['верно', 'dogry', 'Верно, молодец!', 'Dogry, berekella!'],
      ['неправильно', 'nädogry', 'Это неправильно.', 'Bu nädogry.'],
      ['ошибка', 'ýalňyşlyk', 'Это моя ошибка.', 'Bu meniň ýalňyşlygym.'],

      // ── Sora / Haýyş ──────────────────────────────────
      ['пожалуйста', 'haýyşt / dälde näme', 'Скажите, пожалуйста.', 'Aýdyň, haýyşt.'],
      ['помогите', 'kömek ediň', 'Помогите мне, пожалуйста!', 'Maňa kömek ediň, haýyşt!'],
      ['можно', 'bolarmı / mümkinmi', 'Можно войти?', 'Girip bolarmı?'],
      ['нельзя', 'bolmaýar / gadagan', 'Здесь нельзя курить.', 'Bu ýerde çilim çekmek bolmaýar.'],
      ['нужно', 'gerek / zerur', 'Мне нужна помощь.', 'Maňa kömek gerek.'],
      ['надо', 'gerek / etmeli', 'Надо идти.', 'Gitmel.'],
      ['важно', 'möhüm', 'Это очень важно.', 'Bu örän möhüm.'],
      ['срочно', 'derhal / tiz', 'Это срочно!', 'Bu derhal!'],
      ['подождите', 'garaşyň', 'Подождите минуту!', 'Bir minut garaşyň!'],
      ['повторите', 'gaýtalaň', 'Повторите, пожалуйста.', 'Gaýtalaň, haýyşt.'],

      // ── Duýgy / Baha ──────────────────────────────────
      ['отлично', 'ajaýyp / örän gowy', 'Отлично, молодец!', 'Ajaýyp, berekella!'],
      ['замечательно', 'görnüklü gowy / ajaýyp', 'Это замечательно!', 'Bu ajaýyp!'],
      ['прекрасно', 'örän owadan / ajaýyp', 'Всё прекрасно.', 'Hemme zat ajaýyp.'],
      ['ужасно', 'ýaman / gorkunç', 'Погода ужасная.', 'Howa ýaman.'],
      ['плохо', 'ýaramaz / erbet', 'Мне плохо.', 'Maňa ýaman.'],
      ['странно', 'geň / täsin', 'Это странно.', 'Bu geň.'],
      ['интересно', 'gyzykly', 'Это интересно!', 'Bu gyzykly!'],
      ['скучно', 'jany sykylýar / gyzykly däl', 'Мне скучно.', 'Maňa janygyp dur.'],
      ['смешно', 'gülkünç', 'Это очень смешно!', 'Bu gaty gülkünç!'],
      ['жалко', 'gynandyryjy / haýp', 'Жалко, что ты не пришёл.', 'Haýp, gelmedik.'],
      ['к сожалению', 'gynansam-da / gynançly', 'К сожалению, не могу.', 'Gynansam-da, bilemok.'],
      ['ничего', 'hiç zat / parhy ýok', 'Ничего страшного.', 'Hiç zat däl.'],

      // ── Maglumat bermek ────────────────────────────────
      ['например', 'meselem', 'Например, яблоко — фрукт.', 'Meselem, alma — miwedir.'],
      ['то есть', 'ýagny / diýmek', 'То есть ты не придёшь?', 'Ýagny sen gelmejekmi?'],
      ['вообще', 'umuman / asla', 'Вообще не понимаю.', 'Umuman düşünemok.'],
      ['на самом деле', 'aslynda / hakykatda', 'На самом деле он добрый.', 'Aslynda ol gowy adam.'],
      ['по-моему', 'meniň pikirimçe', 'По-моему, это неправильно.', 'Meniň pikirimçe, bu nädogry.'],
      ['скорее всего', 'ähtimal / köpdendir', 'Скорее всего он занят.', 'Ähtimal, ol meşgul.'],
      ['вроде бы', 'öýdýän / görünýär', 'Вроде бы всё хорошо.', 'Öýdýän, hemme zat gowy.'],
      ['кстати', 'arada / ýeri gelende', 'Кстати, ты читал эту книгу?', 'Arada, bu kitaby okadyňmy?'],
      ['между прочим', 'arada / ýeri gelip aýtsam', 'Между прочим, он женился.', 'Arada, ol öýlendi.'],
      ['главное', 'esasy zat / möhüm', 'Главное — не опаздывай.', 'Esasy zat — giç galma.'],

      // ── Wagt / Yzygiderlilik ───────────────────────────
      ['сначала', 'ilki / başda', 'Сначала подумай.', 'Ilki pikir et.'],
      ['потом', 'soňra / ondan soň', 'Сначала поешь, потом иди.', 'Ilki iý, soňra git.'],
      ['наконец', 'ahyrsoňy / iň soňunda', 'Наконец ты пришёл!', 'Ahyrsoňy geldiň!'],
      ['всегда', 'hemişe', 'Я всегда прихожу вовремя.', 'Men hemişe wagtynda gelýärin.'],
      ['обычно', 'adatça / köplenç', 'Обычно я встаю в 7.', 'Adatça men sagat 7-de turýaryn.'],
      ['иногда', 'käwagt', 'Иногда я опаздываю.', 'Käwagt giç galýaryn.'],
      ['редко', 'seýrek', 'Я редко смотрю телевизор.', 'Men seýrek telewizor görýärin.'],
      ['никогда', 'hiç haçan', 'Я никогда не курю.', 'Men hiç haçan çilim çekemok.'],
      ['уже', 'eýýäm', 'Я уже дома.', 'Men eýýäm öýde.'],
      ['ещё', 'heniz / ýene', 'Ещё раз попробуй.', 'Ýene bir gezek synap gör.'],
      ['только что', 'ýaňy / az öň', 'Он только что ушёл.', 'Ol ýaňy gitdi.'],
      ['скоро', 'ýakynda / az saldan', 'Скоро увидимся.', 'Ýakynda görüşeris.'],
      ['давно', 'köp wagt bäri / ozal', 'Я давно тебя не видел.', 'Men seni köp wagt bäri görmedim.'],
      ['вдруг', 'birden / duýdansyz', 'Вдруг пошёл дождь.', 'Birden ýagyş ýağdy.'],
      ['сразу', 'derhal / şol bada', 'Сразу позвони мне.', 'Derhal maňa jaň et.'],
    ];

    for (final p in phrases) {
      await txn.insert(DbConstants.tVocabulary, {
        'lesson_id': null,
        'word_ru': p[0],
        'word_tk': p[1],
        'example_ru': p[2],
        'example_tk': p[3],
        'category': DbConstants.vocabCategoryTopPhrases,
        'difficulty': 1,
        'image_path': null,
        'audio_path': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  // ══════════════════════════════════════════════════════════
  // 3. BAGLAÝJY SÖZLER — category='connectors'
  //    Sözlemleri we pikir bölümlerini birleşdirýän sözler
  //    Geljekde goşmak üçin: bu liste täze setir goş
  // ══════════════════════════════════════════════════════════
  static Future<void> _seedConnectors(Transaction txn) async {
    // Format: [rusça, türkmençe, mysal (rus), mysal (tk)]
    final connectors = [
      // ── Goşmak ─────────────────────────────────────────
      ['и', 'we / hem', 'Я и ты.', 'Men we sen.'],
      ['а также', 'şeýle hem / we hem', 'Я и ты, а также они.', 'Men we sen, şeýle hem olar.'],
      ['тоже', 'hem / -da/-de', 'Я тоже хочу.', 'Men hem isleýärin.'],
      ['также', 'şeýle hem', 'Он также устал.', 'Ol hem ýadaw.'],
      ['к тому же', 'mundan başga / üstesine', 'К тому же он опоздал.', 'Mundan başga, ol giç galdy.'],
      ['кроме того', 'muňa goşmaça', 'Кроме того, он умный.', 'Muňa goşmaça, ol akyllydyr.'],
      ['не только… но и', 'diňe däl… hem', 'Не только умный, но и добрый.', 'Diňe akyl däl, hem gowy.'],
      ['как… так и', 'hem… hem', 'Как он, так и она.', 'Hem ol, hem-de.'],

      // ── Garşylyk ───────────────────────────────────────
      ['но', 'ýöne / emma', 'Хочу, но не могу.', 'Isleýärin, ýöne bilemok.'],
      ['однако', 'ýöne / şeýle-de bolsa', 'Однако он пришёл.', 'Şeýle-de bolsa, ol geldi.'],
      ['зато', 'onuň deregine / ýöne', 'Дорого, зато качественно.', 'Gymmat, ýöne hilli.'],
      ['хотя', 'bolsa-da / garamazdan', 'Хотя устал, работает.', 'Ýadaw bolsa-da, işleýär.'],
      ['несмотря на то что', 'garamazdan / …-a garamazdan', 'Несмотря на дождь, гуляет.', 'Ýagşa garamazdan, gezelenç edýär.'],
      ['тем не менее', 'şeýle-de bolsa / barybir', 'Тем не менее я пришёл.', 'Şeýle-de bolsa, men geldim.'],
      ['в то время как', '…wagty / şol wagt', 'В то время как он спал.', 'Ol ýatyrka.'],
      ['вместо того чтобы', '…etmegiň deregine', 'Вместо того чтобы спать, работает.', 'Ýatmagyň deregine işleýär.'],

      // ── Sebäp / Netije ─────────────────────────────────
      ['потому что', 'sebäbi / …diği üçin', 'Устал, потому что работал.', 'Ýadaw, sebäbi işledi.'],
      ['так как', 'sebäpli / …bolanlygy üçin', 'Так как он болен, не пришёл.', 'Kesellänligi üçin gelmedi.'],
      ['поэтому', 'şonuň üçin / şol sebäpden', 'Опоздал, поэтому извинился.', 'Giç galdy, şonuň üçin ötünç sorady.'],
      ['следовательно', 'netijede / onda', 'Следовательно, он прав.', 'Netijede, ol dogry.'],
      ['в результате', 'netijede / soňunda', 'В результате мы победили.', 'Netijede, biz ýeňdik.'],
      ['из-за того что', '…sebäpli / …zerarly', 'Из-за дождя не вышел.', 'Ýagyş sebäpli çykmady.'],
      ['благодаря тому что', '…sаýasynda / …kömegi bilen', 'Благодаря тебе успел.', 'Seniň kömеgiňde ýetişdim.'],
      ['поскольку', 'sebäpli / …bolansoň', 'Поскольку он устал, отдыхает.', 'Ýadaw bolansoň, dynç alýar.'],

      // ── Şert ───────────────────────────────────────────
      ['если', 'eger', 'Если хочешь, иди.', 'Eger isleseň, git.'],
      ['если бы', 'eger-de bolsady', 'Если бы я знал…', 'Eger bilsedim…'],
      ['при условии что', '…şertinde', 'При условии что придёшь.', 'Geljek şertiňde.'],
      ['в случае если', 'eger…bolsa', 'В случае если опоздаешь, позвони.', 'Giç galсаň, jaň et.'],
      ['лишь бы', 'bolmasa bolupdyr / diňe', 'Лишь бы не опоздал.', 'Diňe giç galmasa bolupdyr.'],

      // ── Maksat ─────────────────────────────────────────
      ['чтобы', '…üçin / …diý', 'Учусь, чтобы знать.', 'Bilmek üçin okaýaryn.'],
      ['для того чтобы', '…etmek maksady bilen', 'Для того чтобы понять.', 'Düşünmek üçin.'],
      ['с целью', 'maksat bilen', 'С целью обучения.', 'Okuw maksady bilen.'],

      // ── Deňeşdirmek ────────────────────────────────────
      ['как', 'ýaly / kimin', 'Быстрый, как ветер.', 'Ýel ýaly çalt.'],
      ['так же как', '…ýaly hem', 'Так же как и я.', 'Men ýaly hem.'],
      ['чем', '…dan/-den (deňeşdirme)', 'Лучше, чем вчера.', 'Düýnden gowy.'],
      ['по сравнению с', 'bilen deňeşdirilende', 'По сравнению с братом.', 'Dogany bilen deňeşdirilende.'],

      // ── Tertip ─────────────────────────────────────────
      ['во-первых', 'birinjiden', 'Во-первых, подумай.', 'Birinjiden, pikir et.'],
      ['во-вторых', 'ikinjiden', 'Во-вторых, поговори.', 'Ikinjiden, gürleş.'],
      ['в-третьих', 'üçünjiden', 'В-третьих, действуй.', 'Üçünjiden, hereket et.'],
      ['наконец', 'ahyrsoňy / iň soňunda', 'Наконец, решение найдено.', 'Ahyrsoňy, çözgüt tapyldy.'],
      ['с одной стороны', 'bir tarapdan', 'С одной стороны, хорошо.', 'Bir tarapdan, gowy.'],
      ['с другой стороны', 'beýleki tarapdan', 'С другой стороны, сложно.', 'Beýleki tarapdan, kyn.'],

      // ── Umumylaşdyrma ──────────────────────────────────
      ['в общем', 'umuman / jemläp aýtsam', 'В общем, всё хорошо.', 'Umuman, hemme zat gowy.'],
      ['в целом', 'bütewilikde / jemi', 'В целом, согласен.', 'Bütewilikde, ylalaşýaryn.'],
      ['короче говоря', 'gysgaça aýtsam', 'Короче говоря, нет.', 'Gysgaça aýtsam, ýok.'],
      ['иными словами', 'başgaça aýtsam', 'Иными словами, откажи.', 'Başgaça aýtsam, ret et.'],
      ['таким образом', 'şeýlelik bilen', 'Таким образом, всё ясно.', 'Şeýlelik bilen, hemme zat aýdyň.'],
    ];

    for (final c in connectors) {
      await txn.insert(DbConstants.tVocabulary, {
        'lesson_id': null,
        'word_ru': c[0],
        'word_tk': c[1],
        'example_ru': c[2],
        'example_tk': c[3],
        'category': DbConstants.vocabCategoryConnectors,
        'difficulty': 1,
        'image_path': null,
        'audio_path': null,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }
}
