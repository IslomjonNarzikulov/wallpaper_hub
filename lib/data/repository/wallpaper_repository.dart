import 'dart:core';
import 'package:wallpaper/data/Database/db_helper.dart';
import 'package:wallpaper/data/network/network_client.dart';
import 'package:wallpaper/domain/models/wallpaper_model.dart';


class Repository {
  NetworkClient networkClient;
  DBHelper dbHelper;
  List<WallpaperModel> favorites = [];
  Repository({required this.dbHelper, required this.networkClient});

  Future<List<WallpaperModel>> getTrendingWallpapers() async {
    var databaseList = await dbHelper.getDataList();
    if (databaseList.isNotEmpty) {
      return databaseList;
    } else {
      var list =
          await networkClient.getTrendingWallpaper() as List<WallpaperModel>;
      var data = await dbHelper.insertAll(list);
      return data;
    }
  }

  Future<List<WallpaperModel>> getSearchingWallpapers(String query) async {
    var list = await networkClient.getSearchingWallpapers(query)as List<WallpaperModel>;
    return list;
  }

  Future<List<WallpaperModel>> getFavoriteWallpapers() async {
    var databaseList = await dbHelper.getDataList();
    var sorted =
    databaseList.where((element) => element.isFavorite == true).toList();
    favorites = sorted;
    return sorted;
  }

  Future<void> addFavorite(WallpaperModel model)async{
    model.isFavorite = true;
    model.isTrending = false;
    await dbHelper.update(model);
  }

  Future<void> removeFavorite(WallpaperModel model) async{
    model.isFavorite = false;
    model.isTrending = true;
    await dbHelper.update(model);
    getFavoriteWallpapers();
  }

  Future<void> selectFavorite(WallpaperModel model) async {
    if (model.isFavorite == true) {
      removeFavorite(model);
    } else {
      addFavorite(model);
    }
    getTrendingWallpapers();
    getFavoriteWallpapers();
  }

  Future<void> addToCategory(WallpaperModel model)async{
    dbHelper.addCategory(model);
    getTrendingWallpapers();
    getFavoriteWallpapers();
  }
}

