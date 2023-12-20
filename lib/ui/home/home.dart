import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/provider/hub_provider.dart';
import 'package:wallpaper/widgets/widget.dart';

import '../categories/categories.dart';
import '../search_page/search.dart';
import 'package:wallpaper/data/network/network_client.dart';
class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late WallpaperProvider provider;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    provider = context.read<WallpaperProvider>();

    provider.getTrendingWallpapers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(38)),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                            hintText: 'Search wallpaper',
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Consumer<WallpaperProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  var wallpapers = value.wallpapers;
                  if (wallpapers.isNotEmpty) {
                    return wallpaperList(
                        wallpapers: wallpapers,
                        context: context,
                        favorite: (item) {
                          provider.selectFavorite(item!);
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorieTile extends StatelessWidget {
  CategorieTile({super.key, required this.title, required this.imgUrl});

  String imgUrl;
  String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categories(categoryName: title),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  imgUrl,
                  height: 100,
                  width: 300,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.topCenter,
              height: 100,
              width: 100,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
