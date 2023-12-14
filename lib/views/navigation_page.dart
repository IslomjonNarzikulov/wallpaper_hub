import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub/provider/hub_provider.dart';
import 'package:wallpaper_hub/views/favorites.dart';
import 'package:wallpaper_hub/views/settings.dart';

import '../data/data.dart';
import '../models/categories_model.dart';
import 'category_tile.dart';
import 'home.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyHome(),
    Categorie(),
    Favorites(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar:  BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.line_weight_sharp), label: 'Home',backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_week_outlined), label: 'Categories',backgroundColor: Colors.black),
            BottomNavigationBarItem(
                 icon: Icon(Icons.favorite_border), label: 'Favorite',backgroundColor: Colors.black),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings',backgroundColor: Colors.black),
          ],

          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow,
          onTap: _onItemTapped),
    );
  }
}
