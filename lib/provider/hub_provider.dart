import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wallpaper_hub/database/db_helper.dart';
import 'package:wallpaper_hub/models/wallpaper_model.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
class WallpaperProvider extends ChangeNotifier{
  var dbHelper = DBHelper();
  List <WallpaperModel> wallpapers = [];

  getTrendingWallpapers() async {
    var list = <WallpaperModel>[];

    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=50"),
        headers: {'Authorization': apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      list.add(wallpaperModel);

    });
    var data = await dbHelper.insertAll(list);
    wallpapers = data;
notifyListeners();
  }

}