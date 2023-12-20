import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/data/Database/db_helper.dart';
import 'package:wallpaper/data/network/network_client.dart';
import 'package:wallpaper/provider/hub_provider.dart';
import 'package:wallpaper/ui/navigation_page/navigation_page.dart';
import 'data/repository/wallpaper_repository.dart';


void main()async {
  var networkClient=NetworkClient();
  var dbHelper=DBHelper();
  var repository=Repository(dbHelper: dbHelper, networkClient: networkClient);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WallpaperProvider(repository))],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpapers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavigationPage(),
    );
  }
}
