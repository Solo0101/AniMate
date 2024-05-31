import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:frontend/pages/user_profile_page.dart';

import '../pages/match_page.dart';
import '../pages/settings_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPageRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerPageRoute:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case homePageRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case splashScreenPageRoute:
      // return MaterialPageRoute(builder: (_) => const SplashScreen());
      case settingsPageRoute:
      return MaterialPageRoute(builder: (_) => const SettingsPage());
      case myProfilePageRoute:
      return MaterialPageRoute(builder: (_) => const UserProfilePage());
      case matchPageRoute:
        // return MaterialPageRoute(builder: (_) => const MatchPage());
      ///Add new cases with routes HERE!!!!!!!

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error 404!'),
        ),
      );
    });
  }
}
