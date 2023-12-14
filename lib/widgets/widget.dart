import 'package:flutter/material.dart';

import '../models/wallpaper_model.dart';
import '../views/image_view.dart';

Widget BrandName() {
  return const Row(
    children: <Widget>[
      Text(
        'Wallpaper',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Text(
        'Hub',
        style: TextStyle(fontSize: 24, color: Colors.blue),
      )
    ],
  );
}

Widget wallpaperList(
    {required List<WallpaperModel> wallpapers,
    context,
    required void Function(WallpaperModel item)? favorite}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      padding:const EdgeInsets.only(top: 16),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: wallpapers.map(
        (WallpaperModel wallpaperModel) {
          bool isFavorite = false;
          return GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageView(
                      imageUrl: wallpaperModel.src!.portrait!,
                    ),
                  ),
                );
              },
              child: Hero(
                //rasm kattalashtirish
                tag: wallpaperModel.src!.portrait!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        wallpaperModel.src!.portrait!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 35,
                        right: 5,
                        child: InkWell(
                            onTap: () {
                              favorite!(wallpaperModel);
                              print('tapped');
                            },
                            child: wallpaperModel.isFavorite == true
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    ),
  );
}
