class DbConstants {
  DbConstants._();

  // Database
  static const String dbName = 'rus_dili.db';
  static const int dbVersion = 1;

  // Table names
  static const String tLessons = 'lessons';
  static const String tVocabulary = 'vocabulary';
  static const String tDialogs = 'dialogs';
  static const String tDialogLines = 'dialog_lines';
  static const String tGrammarRules = 'grammar_rules';
  static const String tGrammarTableRows = 'grammar_table_rows';
  static const String tExercises = 'exercises';
  static const String tExerciseQuestions = 'exercise_questions';
  static const String tExerciseOptions = 'exercise_options';
  static const String tUserProgress = 'user_progress';
  static const String tLessonProgress = 'lesson_progress';
  static const String tReadingTexts = 'reading_texts';
  static const String tConversationScenarios = 'conversation_scenarios';
  static const String tAppImages = 'app_images';

  // Column names - Lessons
  static const String colId = 'id';
  static const String colSapakNumber = 'sapak_number';
  static const String colTitleRu = 'title_ru';
  static const String colTitleTk = 'title_tk';
  static const String colSubtitleTk = 'subtitle_tk';
  static const String colDescriptionTk = 'description_tk';
  static const String colImagePath = 'image_path';
  // NOTE: colImageBlob kept for legacy model compat but NOT used in queries
  static const String colImageBlob = 'image_blob';
  static const String colIsCompleted = 'is_completed';
  static const String colOrderIndex = 'order_index';
  static const String colCreatedAt = 'created_at';

  // Column names - Vocabulary
  static const String colLessonId = 'lesson_id';
  static const String colWordRu = 'word_ru';
  static const String colWordTk = 'word_tk';
  static const String colExampleRu = 'example_ru';
  static const String colExampleTk = 'example_tk';
  static const String colCategory = 'category';
  static const String colDifficulty = 'difficulty';
  static const String colAudioPath = 'audio_path';

  // Column names - Dialogs
  static const String colDialogNumber = 'dialog_number';
  static const String colDialogName = 'dialog_name';
  static const String colContextTk = 'context_tk';
  static const String colDialogId = 'dialog_id';
  static const String colLineOrder = 'line_order';
  static const String colSpeaker = 'speaker';
  static const String colTextRu = 'text_ru';
  static const String colTextTk = 'text_tk';

  // Column names - Grammar
  static const String colTableNumber = 'table_number';
  static const String colNote = 'note_tk';
  static const String colExplanation = 'explanation_tk';
  static const String colRuleType = 'rule_type';
  static const String colGrammarId = 'grammar_id';
  static const String colRowOrder = 'row_order';
  static const String colIsHeader = 'is_header';
  static const String colRedCells = 'red_cells'; // JSON: [1,3,5] index list
  static const String colCell1 = 'cell_1';
  static const String colCell2 = 'cell_2';
  static const String colCell3 = 'cell_3';
  static const String colCell4 = 'cell_4';
  static const String colCell5 = 'cell_5';
  static const String colCell6 = 'cell_6';
  static const String colCell7 = 'cell_7';

  // Column names - Exercises
  static const String colExerciseNumber = 'exercise_number';
  static const String colExerciseType = 'exercise_type';
  static const String colInstructionTk = 'instruction_tk';
  static const String colExerciseId = 'exercise_id';
  static const String colQuestionOrder = 'question_order';
  static const String colQuestionText = 'question_text';
  static const String colCorrectAnswer = 'correct_answer';
  static const String colHintTk = 'hint_tk';
  static const String colQuestionId = 'question_id';
  static const String colOptionText = 'option_text';
  static const String colIsCorrect = 'is_correct';

  // Column names - Progress
  static const String colAttempts = 'attempts';
  static const String colCompletedAt = 'completed_at';
  static const String colTimeSpentSec = 'time_spent_sec';
  static const String colVocabStudied = 'vocab_studied';
  static const String colDialogsRead = 'dialogs_read';
  static const String colExercisesDone = 'exercises_done';
  static const String colExercisesTotal = 'exercises_total';
  static const String colScorePercent = 'score_percent';
  static const String colLastStudied = 'last_studied';

  // Column names - Images
  static const String colImageKey = 'image_key';
  static const String colWidth = 'width';
  static const String colHeight = 'height';

  // Exercise types
  static const String exerciseFillBlank = 'fill_blank';
  static const String exerciseMultipleChoice = 'multiple_choice';
  static const String exerciseMatching = 'matching';
  static const String exerciseWordOrder = 'word_order';
  static const String exerciseTranslation = 'translation';
  static const String exerciseFlashcard = 'flashcard';
  static const String exerciseTextQuestion = 'text_question';

  // Grammar rule types
  static const String ruleTypeTable = 'table';
  static const String ruleTypeWarning = 'warning_box';
  static const String ruleTypeExample = 'example';
  static const String ruleTypeNote = 'note';

  // CREATE TABLE SQL statements
  static const String createLessonsTable = '''
    CREATE TABLE IF NOT EXISTS lessons (
      id              INTEGER PRIMARY KEY,
      sapak_number    INTEGER NOT NULL,
      title_ru        TEXT NOT NULL,
      title_tk        TEXT NOT NULL,
      subtitle_tk     TEXT,
      description_tk  TEXT,
      image_path      TEXT,
      is_completed    INTEGER DEFAULT 0,
      order_index     INTEGER,
      created_at      TEXT
    )
  ''';

  static const String createVocabularyTable = '''
    CREATE TABLE IF NOT EXISTS vocabulary (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      lesson_id       INTEGER NOT NULL,
      word_ru         TEXT NOT NULL,
      word_tk         TEXT NOT NULL,
      example_ru      TEXT,
      example_tk      TEXT,
      image_path      TEXT,
      audio_path      TEXT,
      category        TEXT,
      difficulty      INTEGER DEFAULT 1,
      FOREIGN KEY (lesson_id) REFERENCES lessons(id)
    )
  ''';

  static const String createDialogsTable = '''
    CREATE TABLE IF NOT EXISTS dialogs (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      lesson_id       INTEGER NOT NULL,
      dialog_number   INTEGER,
      dialog_name     TEXT,
      context_tk      TEXT,
      image_path      TEXT,
      FOREIGN KEY (lesson_id) REFERENCES lessons(id)
    )
  ''';

  static const String createDialogLinesTable = '''
    CREATE TABLE IF NOT EXISTS dialog_lines (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      dialog_id       INTEGER NOT NULL,
      line_order      INTEGER,
      speaker         TEXT,
      text_ru         TEXT NOT NULL,
      text_tk         TEXT,
      FOREIGN KEY (dialog_id) REFERENCES dialogs(id)
    )
  ''';

  static const String createGrammarRulesTable = '''
    CREATE TABLE IF NOT EXISTS grammar_rules (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      lesson_id       INTEGER NOT NULL,
      table_number    INTEGER,
      title_ru        TEXT,
      title_tk        TEXT,
      explanation_tk  TEXT,
      note_tk         TEXT,
      rule_type       TEXT DEFAULT 'table',
      image_path      TEXT,
      order_index     INTEGER,
      FOREIGN KEY (lesson_id) REFERENCES lessons(id)
    )
  ''';

  static const String createGrammarTableRowsTable = '''
    CREATE TABLE IF NOT EXISTS grammar_table_rows (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      grammar_id      INTEGER NOT NULL,
      row_order       INTEGER,
      is_header       INTEGER DEFAULT 0,
      cell_1          TEXT,
      cell_2          TEXT,
      cell_3          TEXT,
      cell_4          TEXT,
      cell_5          TEXT,
      cell_6          TEXT,
      cell_7          TEXT,
      red_cells       TEXT,
      FOREIGN KEY (grammar_id) REFERENCES grammar_rules(id)
    )
  ''';

  static const String createExercisesTable = '''
    CREATE TABLE IF NOT EXISTS exercises (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      lesson_id       INTEGER NOT NULL,
      exercise_number INTEGER,
      title_tk        TEXT,
      instruction_tk  TEXT,
      exercise_type   TEXT NOT NULL,
      note_tk         TEXT,
      order_index     INTEGER,
      FOREIGN KEY (lesson_id) REFERENCES lessons(id)
    )
  ''';

  static const String createExerciseQuestionsTable = '''
    CREATE TABLE IF NOT EXISTS exercise_questions (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      exercise_id     INTEGER NOT NULL,
      question_order  INTEGER,
      question_text   TEXT NOT NULL,
      correct_answer  TEXT NOT NULL,
      hint_tk         TEXT,
      image_path      TEXT,
      FOREIGN KEY (exercise_id) REFERENCES exercises(id)
    )
  ''';

  static const String createExerciseOptionsTable = '''
    CREATE TABLE IF NOT EXISTS exercise_options (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      question_id     INTEGER NOT NULL,
      option_text     TEXT NOT NULL,
      is_correct      INTEGER DEFAULT 0,
      FOREIGN KEY (question_id) REFERENCES exercise_questions(id)
    )
  ''';

  static const String createUserProgressTable = '''
    CREATE TABLE IF NOT EXISTS user_progress (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      lesson_id       INTEGER,
      exercise_id     INTEGER,
      question_id     INTEGER,
      is_correct      INTEGER,
      attempts        INTEGER DEFAULT 0,
      completed_at    TEXT,
      time_spent_sec  INTEGER
    )
  ''';

  static const String createLessonProgressTable = '''
    CREATE TABLE IF NOT EXISTS lesson_progress (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      lesson_id       INTEGER UNIQUE,
      vocab_studied   INTEGER DEFAULT 0,
      dialogs_read    INTEGER DEFAULT 0,
      exercises_done  INTEGER DEFAULT 0,
      exercises_total INTEGER DEFAULT 0,
      score_percent   REAL DEFAULT 0,
      is_completed    INTEGER DEFAULT 0,
      last_studied    TEXT,
      FOREIGN KEY (lesson_id) REFERENCES lessons(id)
    )
  ''';

  static const String createReadingTextsTable = '''
    CREATE TABLE IF NOT EXISTS reading_texts (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      lesson_id       INTEGER NOT NULL,
      title_ru        TEXT,
      content_ru      TEXT NOT NULL,
      image_path      TEXT,
      FOREIGN KEY (lesson_id) REFERENCES lessons(id)
    )
  ''';

  static const String createAppImagesTable = '''
    CREATE TABLE IF NOT EXISTS app_images (
      id              INTEGER PRIMARY KEY AUTOINCREMENT,
      image_key       TEXT UNIQUE NOT NULL,
      image_path      TEXT,
      width           INTEGER,
      height          INTEGER,
      description_tk  TEXT
    )
  ''';

  // ── Performance indexes (FK sütünleri üçin) ─────────────
  // lesson_id boýunça gözleg edýän tablalaryň hemmesine index.
  // Bu bolmasa Flutter A2/B1 goşulanda full table scan bolýar.
  static const String createIndexVocabLesson =
      'CREATE INDEX IF NOT EXISTS idx_vocab_lesson ON vocabulary(lesson_id)';
  static const String createIndexDialogsLesson =
      'CREATE INDEX IF NOT EXISTS idx_dialogs_lesson ON dialogs(lesson_id)';
  static const String createIndexDialogLines =
      'CREATE INDEX IF NOT EXISTS idx_dialog_lines ON dialog_lines(dialog_id)';
  static const String createIndexGrammarLesson =
      'CREATE INDEX IF NOT EXISTS idx_grammar_lesson ON grammar_rules(lesson_id)';
  static const String createIndexGrammarRows =
      'CREATE INDEX IF NOT EXISTS idx_grammar_rows ON grammar_table_rows(grammar_id)';
  static const String createIndexExercisesLesson =
      'CREATE INDEX IF NOT EXISTS idx_exercises_lesson ON exercises(lesson_id)';
  static const String createIndexExerciseQuestions =
      'CREATE INDEX IF NOT EXISTS idx_ex_questions ON exercise_questions(exercise_id)';
  static const String createIndexExerciseOptions =
      'CREATE INDEX IF NOT EXISTS idx_ex_options ON exercise_options(question_id)';
  static const String createIndexLessonProgress =
      'CREATE INDEX IF NOT EXISTS idx_lesson_progress ON lesson_progress(lesson_id)';
  static const String createIndexReadingTexts =
      'CREATE INDEX IF NOT EXISTS idx_reading_texts ON reading_texts(lesson_id)';

  // All create statements in order
  static const List<String> allCreateStatements = [
    createLessonsTable,
    createVocabularyTable,
    createDialogsTable,
    createDialogLinesTable,
    createGrammarRulesTable,
    createGrammarTableRowsTable,
    createExercisesTable,
    createExerciseQuestionsTable,
    createExerciseOptionsTable,
    createUserProgressTable,
    createLessonProgressTable,
    createReadingTextsTable,
    createAppImagesTable,
    // Indexes — tablalardan soň döredilmeli
    createIndexVocabLesson,
    createIndexDialogsLesson,
    createIndexDialogLines,
    createIndexGrammarLesson,
    createIndexGrammarRows,
    createIndexExercisesLesson,
    createIndexExerciseQuestions,
    createIndexExerciseOptions,
    createIndexLessonProgress,
    createIndexReadingTexts,
  ];
}
