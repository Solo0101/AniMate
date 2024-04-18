import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/shared/router.dart';

import 'constants/style_constants.dart';

void main() {
  runApp(const AniMATEApp());
}

class AniMATEApp extends StatelessWidget {
  const AniMATEApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      title: 'AniMATE',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: fontFamily
      ),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}