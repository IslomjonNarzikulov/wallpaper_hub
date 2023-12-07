import 'dart:convert';

class WallpaperModel {
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  SrcModel? src;

  WallpaperModel(
      {this.photographer,
      this.photographer_id,
      this.photographer_url,
      this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      photographer: jsonData['photographer'],
      photographer_id: jsonData['photographer_id'],
      photographer_url: jsonData['photographer_url'],
      src: SrcModel.fromMap(jsonData['src']),
    );
  }

  WallpaperModel.fromDbMap(Map<String, dynamic> jsonData)
      : photographer_id = jsonData['photographer'],
        photographer = jsonData['photographer'],
        photographer_url = jsonData['photographer_url'];


  Map<String, dynamic> toMap() {
    final Map<String, dynamic> jsonData = Map<String, dynamic>();
    jsonData['photographer'] = photographer;
    jsonData['photographer_id'] = photographer_id;
    jsonData['photographer_url'] = photographer_url;
    jsonData['src'] = src;
    return jsonData;
  }

  Map<String, dynamic> toDbMap() {
    return {
      'photographer_id': photographer_id,
      'photographer_url': photographer_url,
      'photographer': photographer,
      'src': src,
    };
  }
}


class SrcModel {
  String? original;
  String? small;
  String? portrait;

  SrcModel({this.original, this.portrait, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
        portrait: jsonData['portrait'],
        original: jsonData['original'],
        small: jsonData['small']);
  }
}
