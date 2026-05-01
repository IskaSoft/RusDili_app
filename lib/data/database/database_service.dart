import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../../core/constants/db_constants.dart';
import 'database_seeder.dart';

class DatabaseService {
  DatabaseService._internal();
  static final DatabaseService instance = DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<void> init() async {
    await database;
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
    // Apply PRAGMA settings AFTER database is fully opened
    // Use rawQuery for PRAGMAs to avoid SqfliteDatabaseException
    await _safePragma(db, 'PRAGMA journal_mode = WAL');
    await _safePragma(db, 'PRAGMA cache_size = -8000');
    await _safePragma(db, 'PRAGMA synchronous = NORMAL');
    await _safePragma(db, 'PRAGMA temp_store = MEMORY');
    await _safePragma(db, 'PRAGMA foreign_keys = ON');
  }

  /// Safely execute PRAGMA using rawQuery (handles platform differences)
  Future<void> _safePragma(Database db, String pragmaSql) async {
    try {
      // PRAGMAs that return values use rawQuery
      if (pragmaSql.contains('= WAL') ||
          pragmaSql.contains('= MEMORY') ||
          pragmaSql.contains('= NORMAL') ||
          pragmaSql.contains('= OFF')) {
        // These are SET operations - use execute, not query
        await db.execute(pragmaSql.replaceFirst('PRAGMA ', ''));
      } else {
        await db.rawQuery(pragmaSql);
      }
    } catch (e) {
      // Silently ignore PRAGMA errors on platforms that don't support them
      // (e.g., some Android emulators, iOS simulators)
      debugPrint('PRAGMA warning (non-critical): $pragmaSql -> $e');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create all tables
    for (final sql in DbConstants.allCreateStatements) {
      await db.execute(sql);
    }

    // Seed initial data
    await DatabaseSeeder.seed(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Migration to version 2 (future)
    }
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
