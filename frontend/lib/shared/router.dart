

import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/constants/router_constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPageRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registerPageRoute:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case mainPageRoute:
        // return MaterialPageRoute(builder: (_) => const MainPage());
      case splashScreenPageRoute:
        // return MaterialPageRoute(builder: (_) => const SplashScreen());
      case settingsPageRoute:
        // return MaterialPageRoute(builder: (_) => const SettingsPage());
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