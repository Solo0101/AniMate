import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/hive_service.dart';
import 'package:frontend/shared/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/style_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveService().initHive();

  runApp(const ProviderScope(child: AniMATEApp()));
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
      home: AuthService.initialRouting()
    );
  }

}