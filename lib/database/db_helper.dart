import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper_hub/models/wallpaper_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'wallpaper.db');
    var db = await openDatabase(path, version: 1, onCreate: _CreateDatabase);
    return db;
  }

  _CreateDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE wallpaper("
        "id INTEGER "
        "PRIMARY KEY AUTOINCREMENT,"
        "photographer TEXT,"
        "photographer_url TEXT,"
        "src TEXT,"
        "wallpaperId INTEGER,"
        "isFavorite INTEGER DEFAULT 0 ,"
        "isTrending INTEGER DEFAULT 0 ,"
        "photographer_id INTEGER)");
  }

  Future<WallpaperModel> insert(WallpaperModel wallpaperModel) async {
    var dbClient = await db;
    await dbClient?.insert("wallpaper", wallpaperModel.toDbMap());
    return wallpaperModel;
  }

  Future<List<WallpaperModel>> insertAll(List<WallpaperModel> list) async {
    await Future.forEach(list, (element) async {
      await insert(element);
    });
    return getDataList();
  }

  Future<List<WallpaperModel>> getDataList() async {
    await db;
    final List<Map<String, Object?>> queryResult =
        await _db!.rawQuery('SELECT * FROM wallpaper');
    return queryResult.map((e) {
      return WallpaperModel.fromDbMap(e);
    }).toList();
  }

  Future<int> update(WallpaperModel wallpaperModel) async {
    var dbClient = await db;
    return await dbClient!.update('wallpaper', wallpaperModel.toDbMap(),
        where: 'id=?', whereArgs: [wallpaperModel.dbId]);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('wallpaper', where: 'id=?', whereArgs: [id]);
  }

  Future<void> addFavorite(int id) async {
    var dbClient = await db;
    var list =
        await dbClient?.rawQuery('SELECT * FROM wallpaper WHERE?=id', [id]);
    if (list == null || list.isNotEmpty) return;
    var item = list[0];
    item['isFavorite'] = '1';
    await dbClient!.update('wallpaper', item);
  }
  Future <void> removeFavorite(int id)async{
    var dbClient = await db;
    var list =
    await dbClient?.rawQuery('SELECT * FROM wallpaper WHERE?=id', [id]);
    if (list == null || list.isNotEmpty) return;
    var item = list[0];
    item['isFavorite'] = '0';
    await dbClient!.update('wallpaper', item);
  }
}
