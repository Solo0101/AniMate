import 'package:flutter/material.dart';
import 'package:frontend/constants/style_constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;

  const MyAppBar({
    super.key,
    this.title = "AniMate",
    this.hasBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    if (hasBackButton)
      {
        return AppBar(
          title: Text(title),
          // centerTitle: true,
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          actions: const <Widget>[
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      }
    else
      {
        return AppBar(
          title: Text(title),
          // centerTitle: true,
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
        );
      }

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
