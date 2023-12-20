import 'package:flutter/cupertino.dart';
import 'package:wallpaper/data/database/db_helper.dart';
import 'package:wallpaper/domain/models/wallpaper_model.dart';
import '../data/repository/wallpaper_repository.dart';

class WallpaperProvider extends ChangeNotifier {
  var dbHelper = DBHelper();
  List<WallpaperModel> wallpapers = [];
  List<WallpaperModel> favorites = [];
  List<WallpaperModel> searchWallpapers = [];
  Repository repository;

  WallpaperProvider(this.repository);

  void getTrendingWallpapers() async {
    wallpapers = await repository.getTrendingWallpapers();
    notifyListeners();
  }

  getSearchingWallpapers(String query) async {
    searchWallpapers = await repository.getSearchingWallpapers(query);
    notifyListeners();
  }

  void getFavoriteWallpapers() async {
    favorites=await repository.getFavoriteWallpapers();
    notifyListeners();
  }

  void addFavorite(WallpaperModel model) async {
    repository.addFavorite(model);
    getFavoriteWallpapers();
    notifyListeners();
  }

  void removeFavorite(WallpaperModel model) async {
    repository.removeFavorite(model);
    notifyListeners();
  }

  void selectFavorite(WallpaperModel model) {
  repository.selectFavorite(model);
  notifyListeners();
  }

  void addToCategory(WallpaperModel model) async {
   repository.addToCategory(model);
    notifyListeners();
  }
}
