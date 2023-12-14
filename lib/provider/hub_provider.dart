import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub/database/db_helper.dart';
import 'package:wallpaper_hub/models/wallpaper_model.dart';

import '../data/data.dart';

class WallpaperProvider extends ChangeNotifier {
  var dbHelper = DBHelper();
  List<WallpaperModel> wallpapers = [];
  List<WallpaperModel> favorites = [];
  List<WallpaperModel> searchWallpapers = [];

  void getTrendingWallpapers() async {
    try {
      var databaseList = await dbHelper.getDataList();
      if (databaseList.isNotEmpty) {
        wallpapers = databaseList;
        notifyListeners();
      } else {
        var list = <WallpaperModel>[];
        var response = await http.get(
            Uri.parse("https://api.pexels.com/v1/curated?per_page=50"),
            headers: {'Authorization': apiKey});
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        jsonData['photos'].forEach((element) {
          var item = WallpaperModel.fromMap(element);
          list.add(item);
        });
        var data = await dbHelper.insertAll(list);
        wallpapers = data;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
  getSearchingWallpapers(String query) async {
    var list = <WallpaperModel>[];
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"),
        headers: {'Authorization': apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      var wallpaperModel = WallpaperModel.fromMap(element);
      wallpaperModel.isTrending=false;
      list.add(wallpaperModel);
    });
    searchWallpapers=list;
    notifyListeners();
  }

  void getFavoriteWallpapers() async {
    var databaseList = await dbHelper.getDataList();
    var sorted =
        databaseList.where((element) => element.isFavorite == true).toList();
    favorites = sorted;
    notifyListeners();
  }

  void addFavorite(WallpaperModel model) async {
    model.isFavorite = true;
    await dbHelper.update(model);
    getFavoriteWallpapers();
    notifyListeners();
  }
  void removeFavorite (WallpaperModel model) async {
    model.isFavorite = false;
    await dbHelper.update(model);
    getFavoriteWallpapers();
    notifyListeners();
  }

  void selectFavorite(WallpaperModel model)async{
    if(model.isFavorite == true){
       removeFavorite(model);
    }else{
     addFavorite(model);
    }
    getTrendingWallpapers();
    getFavoriteWallpapers();
  }
}
