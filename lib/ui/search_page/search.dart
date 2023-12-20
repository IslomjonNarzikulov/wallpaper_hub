import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wallpaper/provider/hub_provider.dart';
import '../../data/database/data.dart';
import '../../domain/models/wallpaper_model.dart';
import '../../widgets/widget.dart';

class Search extends StatefulWidget {
  Search({super.key, required this.searchQuery});
  String searchQuery;
  @override
  State<Search> createState() => _SearchState();
}
class _SearchState extends State<Search> {
  late WallpaperProvider provider;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    provider = context.read<WallpaperProvider>();
    provider.getSearchingWallpapers(widget.searchQuery);
    searchController.text = widget.searchQuery;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BrandName(),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(38)),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                              hintText: 'search wallpaper',
                              border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.getSearchingWallpapers(searchController.text);
                        },
                        child: Container(
                          child: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<WallpaperProvider>(
                  builder: (context, value, child) {
                    return
                      wallpaperList(
                          wallpapers: provider.searchWallpapers, context: context,
                          favorite: ( item) {
                            provider.addToCategory(item!);
                          });
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
