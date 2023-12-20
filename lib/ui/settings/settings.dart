import 'package:flutter/material.dart';
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Settings'),
      ),
      body: ListView(
       children:  [
       ListTile(
         leading: const Icon(Icons.settings),
         title: const Text('Settings'),
         iconColor: Colors.blue,
         onTap: () {},
       ),
       ListTile(
         leading: Icon(Icons.star_rate_outlined),
         title: Text('Rate the app'),
         iconColor: Colors.blue,
         onTap: (){},
       ),
       ListTile(
         leading: Icon(Icons.feedback_outlined),
         title: Text('Send feedback'),
         iconColor: Colors.blue,
         onTap: (){},
       ),
              ],
            ),
    );
  }
}

