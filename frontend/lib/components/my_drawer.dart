import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/services/hive_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: popUpBackgroundColor,
      child: ListView(
        children: [
          const SizedBox(height: 100),
          ListTile(
              title: const Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 10,),
                  Text("Home"),
                ],
              ),
              onTap: () { Navigator.of(context)
                  .pushReplacementNamed(homePageRoute);}
          ),
          ListTile(
              title: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10,),
                  Text("My Profile"),
                ],
              ),
              onTap: () { Navigator.of(context)
                  .pushNamed(myProfilePageRoute);}
          ),
          ListTile(
              title: const Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 10,),
                  Text("Settings"),
                ],
              ),
              onTap: () { Navigator.of(context)
                  .pushNamed(settingsPageRoute); }
          ),
          const SizedBox(height: 100),
          ListTile(
              title: const Row(
                children: [
                  Icon(Icons.output),
                  SizedBox(width: 10,),
                  Text("Sign Out"),
                ],
              ),
              onTap: () { HiveService().logoutUser(); }
          ),
        ],
      ),
    );
  }
}