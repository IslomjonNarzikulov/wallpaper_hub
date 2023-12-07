import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wallpaper_hub/models/wallpaper_model.dart';

class DBHelper {
static Database? _db;
Future <Database?> get db async{
  if(_db != null){
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
      "id INTEGER"
      "PRIMARY KEY AUTOINCREMENT,"
      "photographer TEXT,"
      "photographer_url TEXT,"
      "src TEXT"
      "photographer_id INTEGER)");

}

Future<WallpaperModel> insert (WallpaperModel wallpaperModel) async{
  var dbClient = await db;
  await dbClient?.insert("wallpaper", wallpaperModel.toMap());
  return wallpaperModel;
}

Future<List<WallpaperModel>> insertAll(List<WallpaperModel> list) async {
  await deleteAll();
  await Future.forEach(list, (element) async {
    await insert(element);
  });
  return getDataList();
}
Future<void> deleteAll() async {
  await db;
  // ignore: non_constant_identifier_names
  final List<Map<String, dynamic>> queryResult =
  await _db!.rawQuery('SELECT * FROM habit');
  await Future.forEach(queryResult, (element) async {
    await delete(element['id']!);
  });
}

Future<List<WallpaperModel>> getDataList() async {
  await db;
  final List<Map<String, Object?>> queryResult =
  await _db!.rawQuery('SELECT * FROM habit');
  return queryResult.map((e) {
    return WallpaperModel.fromMap(e);
  }).toList();
}


Future<int> update (WallpaperModel wallpaperModel) async{
  var dbClient = await db;
  return await dbClient!.update('wallpaper', wallpaperModel.toMap(),
      where: 'id=?', whereArgs:[wallpaperModel.photographer_id]);
}
Future<int> delete (int photographer_id) async{
  var dbClient = await db;
  return await dbClient!.delete('wallpaper',where: 'id=?', whereArgs: [photographer_id]);
}
}