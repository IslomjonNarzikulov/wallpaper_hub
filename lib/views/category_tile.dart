import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub/models/categories_model.dart';
import 'package:wallpaper_hub/models/wallpaper_model.dart';
import 'package:wallpaper_hub/provider/hub_provider.dart';
import 'package:wallpaper_hub/views/home.dart';
import 'package:wallpaper_hub/widgets/widget.dart';
import '../data/data.dart';

class Categorie extends StatefulWidget {
  const Categorie({super.key});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  late WallpaperProvider provider;
  List<CategoriesModel> categories = [];
  List<WallpaperModel> favorites = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    categories = getCategories()!;
    provider.getFavoriteWallpapers();
    provider = context.read<WallpaperProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Consumer<WallpaperProvider>(
              builder: (context, value, child) {
                var wallpapers = value.wallpapers;
                wallpaperList(
                    wallpapers: wallpapers, context: context,
                    favorite: (WallpaperModel item) { });
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 700,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CategorieTile(
                              title: categories[index].categorieName.toString(),
                              imgUrl: categories[index].imgUrl.toString(),
                            ),
                            if (index < categories.length - 1)
                              const SizedBox(height: 16),
                          ],
                        );
                      }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
