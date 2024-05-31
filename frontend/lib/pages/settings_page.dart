import 'package:flutter/material.dart';
import 'package:frontend/components/my_appbar.dart';
import 'package:frontend/components/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(hasBackButton: true),
      endDrawer: const MyDrawer(),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.80,
        width: MediaQuery.of(context).size.width * 0.80,
        child: const Column(
          children: [
            SizedBox(height: 30,),
            Row(
              children: [
                SizedBox(width: 30,),
                Text('Settings',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0
                  ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
