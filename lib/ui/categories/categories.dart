import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wallpaper/provider/hub_provider.dart';
import '../../widgets/widget.dart';

class Categories extends StatefulWidget {
  Categories({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late WallpaperProvider provider;


  @override
  void initState() {
    provider = context.read<WallpaperProvider>();
    provider.getSearchingWallpapers(widget.categoryName);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
      ),
      body:
      SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Consumer<WallpaperProvider>(
              builder: (context, value, child) {
                return
                  wallpaperList(wallpapers: provider.searchWallpapers, context: context,
                      favorite: ( item) { provider.addToCategory(item!); });
              },
            ),
            const SizedBox(height: 24),
          ],
          ),
        ),
      ),
    );
  }
}
