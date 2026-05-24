import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../../core/constants/db_constants.dart';
import '../../core/utils/db_helper.dart';
import 'database_seeder.dart';
import 'database_seeder_a2.dart';
import 'database_seeder_b1.dart';
import 'database_seeder_library.dart';
import 'database_seeder_core_vocab.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService instance = DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<void> init() async {
    try {
      await database;
    } catch (e, st) {
      debugPrint('DB init failed, recreating database: $e\n$st');
      await _recreateDatabase();
      await database;
    }
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, DbConstants.dbName);

    return openDatabase(
      path,
      version: DbConstants.dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen, // <-- CHANGED: Use onOpen instead of onConfigure
    );
  }

  // REMOVED: _onConfigure - PRAGMAs moved to _onOpen

  Future<void> _onOpen(Database db) async {
    await _ensureSchema(db);
    // Apply PRAGMA settings AFTER database is fully opened
    await _safePragma(db, 'PRAGMA journal_mode = WAL');
    await _safePragma(db, 'PRAGMA cache_size = -8000');
    await _safePragma(db, 'PRAGMA synchronous = NORMAL');
    await _safePragma(db, 'PRAGMA temp_store = MEMORY');
    await _safePragma(db, 'PRAGMA foreign_keys = ON');
  }

  /// Safely execute PRAGMA — hemişe doly PRAGMA SQL ulanylýar.
  /// DÜZEDIŞ #1: Öňki kod 'PRAGMA ' sözüni aýryp nädogry SQL döredýärdi:
  ///   execute('journal_mode = WAL') → SQLite düşünenok, hiç iş etmeýärdi!
  /// Dogry: execute('PRAGMA journal_mode = WAL')
  Future<void> _safePragma(Database db, String pragmaSql) async {
    try {
      await db.execute(pragmaSql);
    } catch (e) {
      debugPrint('PRAGMA warning (non-critical): $pragmaSql -> $e');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    for (final sql in DbConstants.allCreateStatements) {
      await db.execute(sql);
    }
    await DatabaseSeeder.seed(db);           // A1 Kurs kitaby (Sapak 01–10)
    await DatabaseSeederA2.seed(db);         // A2 Sapak 11–20
    await DatabaseSeederB1.seed(db);         // B1 УРОК 21–28
    await DatabaseSeederLibrary.seed(db);    // Kitaphana
    await DatabaseSeederCoreVocab.seed(db);  // Işlikler, frazalar, baglaýjylar
    await DbHelper.seedAllImages();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Schema first — seeders use category / is_standalone columns.
    await _ensureSchema(db);

    if (oldVersion < 3) {
      await DatabaseSeederA2.seed(db);
    }
    if (oldVersion < 4) {
      await DatabaseSeederLibrary.seed(db);
    }
    if (oldVersion < 5) {
      await DatabaseSeederA2.seed(db);
    }
    if (oldVersion < 6) {
      await DatabaseSeederCoreVocab.seed(db);
    }
    if (oldVersion < 7) {
      await DatabaseSeederB1.seed(db);
    }
  }

  /// Adds columns/tables missing from older DB files (also runs before seeding).
  Future<void> _ensureSchema(Database db) async {
    await _addColumnIfMissing(
      db,
      DbConstants.tDialogs,
      DbConstants.colCategory,
      "TEXT DEFAULT 'lesson'",
    );
    await _addColumnIfMissing(
      db,
      DbConstants.tExercises,
      'is_standalone',
      'INTEGER DEFAULT 0',
    );
    await db.execute(DbConstants.createFavoritesTable);
    for (final sql in [
      'CREATE INDEX IF NOT EXISTS idx_favorites ON favorites(item_type, item_id)',
      'CREATE INDEX IF NOT EXISTS idx_dialogs_category ON dialogs(category)',
      'CREATE INDEX IF NOT EXISTS idx_vocab_category ON vocabulary(category)',
      'CREATE INDEX IF NOT EXISTS idx_exercises_standalone ON exercises(is_standalone)',
    ]) {
      try {
        await db.execute(sql);
      } catch (e) {
        debugPrint('Index warning (non-critical): $sql -> $e');
      }
    }
  }

  Future<bool> _columnExists(Database db, String table, String column) async {
    final rows = await db.rawQuery('PRAGMA table_info($table)');
    return rows.any((r) => r['name'] == column);
  }

  Future<void> _addColumnIfMissing(
    Database db,
    String table,
    String column,
    String definition,
  ) async {
    if (await _columnExists(db, table, column)) return;
    await db.execute('ALTER TABLE $table ADD COLUMN $column $definition');
  }

  Future<void> _recreateDatabase() async {
    await close();
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, DbConstants.dbName);
    await deleteDatabase(path);
  }

  // ── Generic CRUD ────────────────────────────────────────

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data,
    String where,
    List<dynamic> whereArgs,
  ) async {
    final db = await database;
    return db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table,
    String where,
    List<dynamic> whereArgs,
  ) async {
    final db = await database;
    return db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool distinct = false,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? args,
  ]) async {
    final db = await database;
    return db.rawQuery(sql, args);
  }

  Future<int> rawInsert(String sql, [List<dynamic>? args]) async {
    final db = await database;
    return db.rawInsert(sql, args);
  }

  Future<void> transaction(
    Future<void> Function(Transaction txn) action,
  ) async {
    final db = await database;
    await db.transaction(action);
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<bool> isSeeded() async {
    final db = await database;
    final result = await db.query(DbConstants.tLessons, limit: 1);
    return result.isNotEmpty;
  }
}
