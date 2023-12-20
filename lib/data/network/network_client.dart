import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/wallpaper_model.dart';
import '../Database/data.dart';

class NetworkClient{
  Future<List> getTrendingWallpaper()async {
    var list = <WallpaperModel>[];
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=50"),
        headers: {'Authorization': apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      var item = WallpaperModel.fromMap(element);
      item.isTrending==true;
      list.add(item);
    });
    return list;
}
 Future<List> getSearchingWallpapers(String query) async{
     var list = <WallpaperModel>[];
     var response = await http.get(
         Uri.parse(
             "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"),
         headers: {'Authorization': apiKey});
     Map<String, dynamic> jsonData = jsonDecode(response.body);
     jsonData['photos'].forEach((element) {
       var wallpaperModel = WallpaperModel.fromMap(element);
       wallpaperModel.isTrending==false;
       list.add(wallpaperModel);
     });
     return list;
 }
}