import '../database/database_service.dart';
import '../../core/constants/db_constants.dart';

class FavoritesRepository {
  final DatabaseService _db;
  FavoritesRepository(this._db);

  // Saýlananlara goş — UNIQUE constraint sebäpli iki gezek goşulmaýar
  Future<void> add(String itemType, int itemId) async {
    await _db.insert(DbConstants.tFavorites, {
      'item_type': itemType,
      'item_id': itemId,
      'added_at': DateTime.now().toIso8601String(),
    });
  }

  // Saýlananlardan aýyr
  Future<void> remove(String itemType, int itemId) async {
    final db = await _db.database;
    await db.delete(
      DbConstants.tFavorites,
      where: 'item_type = ? AND item_id = ?',
      whereArgs: [itemType, itemId],
    );
  }

  // Toggle — bar bolsa aýyr, ýok bolsa goş
  Future<bool> toggle(String itemType, int itemId) async {
    final exists = await isFavorite(itemType, itemId);
    if (exists) {
      await remove(itemType, itemId);
      return false;
    } else {
      await add(itemType, itemId);
      return true;
    }
  }

  // Saýlananmy barla
  Future<bool> isFavorite(String itemType, int itemId) async {
    final db = await _db.database;
    final result = await db.query(
      DbConstants.tFavorites,
      columns: ['id'],
      where: 'item_type = ? AND item_id = ?',
      whereArgs: [itemType, itemId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  // Bir görnüşdäki ähli saýlanan ID-leri getir
  Future<Set<int>> getFavoriteIds(String itemType) async {
    final db = await _db.database;
    final rows = await db.query(
      DbConstants.tFavorites,
      columns: ['item_id'],
      where: 'item_type = ?',
      whereArgs: [itemType],
      orderBy: 'added_at DESC',
    );
    return rows.map((r) => r['item_id'] as int).toSet();
  }

  // Ähli saýlananlary aýyr
  Future<void> clearAll() async {
    final db = await _db.database;
    await db.delete(DbConstants.tFavorites);
  }
}
