import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub/provider/hub_provider.dart';

import '../models/wallpaper_model.dart';
import '../widgets/widget.dart';
class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
late WallpaperProvider provider;

@override
  void initState() {
  provider = context.read<WallpaperProvider>();
  provider.getFavoriteWallpapers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text(
            'Your Favorites',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer<WallpaperProvider>(
          builder: (BuildContext context, value, Widget? child) {
            var favorites = value.favorites;
            if (favorites.isNotEmpty) {
              return wallpaperList(
                  wallpapers: favorites, context: context,
                  favorite: (WallpaperModel item) {
                    provider.selectFavorite(item);
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
    );
  }
}
