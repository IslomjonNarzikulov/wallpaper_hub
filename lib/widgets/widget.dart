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

Widget wallpaperList({required List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: wallpapers.map((WallpaperModel wallpaperModel) {
        return GridTile(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>
                        ImageView(imageUrl: wallpaperModel.src!.portrait!,),),);
              },
              child: Hero(
                tag: wallpaperModel.src!.portrait!,
                child: Container(
                        child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(wallpaperModel.src!.portrait!,fit: BoxFit.cover,)),
                        ),
              ),
            ));
  }
      ).toList(),
    ),
  );
}
