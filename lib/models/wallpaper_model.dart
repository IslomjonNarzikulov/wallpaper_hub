class WallpaperModel {
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  int? dbId;
  SrcModel? src;
  bool? isFavorite;
  bool? isTrending;
  int? id;

  WallpaperModel({
    this.id,
    this.photographer,
    this.photographer_url,
    this.isFavorite,
    this.isTrending,
    this.photographer_id,
    this.dbId,
    this.src,
  });

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        src: jsonData['src'] != null ? SrcModel.fromMap(jsonData['src']) : null,
        photographer_id: jsonData["photographer_id"],
        dbId: null,
        photographer_url: jsonData["photographer_url"],
        photographer: jsonData["photographer"],
        isFavorite: false,
        isTrending: false,
        id: jsonData['id']);
  }

  WallpaperModel.fromDbMap(Map<String, dynamic> jsonData)
      : photographer_id = jsonData['photographer_id'],
        dbId = jsonData['id'],
        photographer_url = jsonData['photographer_url'],
        photographer = jsonData['photographer'],
        isFavorite = jsonData['isFavorite'] == 1,
        isTrending = jsonData['isTrending'] == 0,
        src = SrcModel(original: null, portrait: jsonData['src'], small: null);

  Map<String, Object?> toMap() {
    return {
      "photographer": photographer,
      "photographer_url": photographer_url,
      "photographer_id": photographer_id,
      "src": src,
      "isFavorite": isFavorite,
      "isTrending": isTrending,
      "id": id
    };
  }

  Map<String, Object?> toDbMap() {
    var favorite = 0;

    if (isFavorite == true) {
      favorite = 1;
    } else {
      favorite = 0;
    }
    return {
      "photographer_id": photographer_id,
      "photographer_url": photographer_url,
      "photographer": photographer,
      "src": src!.portrait!,
      "isFavorite": favorite,
      "wallpaperId": id,
      "isTrending": isTrending == true ? 1 : 0
    };
  }
}

class SrcModel {
  String? portrait;
  String? original;
  String? small;

  SrcModel({
    this.original,
    this.small,
    this.portrait,
  });

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      original: jsonData["original"],
      small: jsonData["small"],
      portrait: jsonData["portrait"],
    );
  }

  Map<String, Object?> toMap() {
    return {
      "original": original,
      "small": small,
      "portrait": portrait,
    };
  }
}
