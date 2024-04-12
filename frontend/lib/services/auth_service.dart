import 'dart:convert';

import 'package:frontend/services/hive_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/providers/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthResponse { success, invalidCredentials, randomError }

class AuthService {
  static Future<AuthResponse> login(String email, String password,
      WidgetRef ref) async {
    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appLoginEndpoint);
    var body = jsonEncode(requestBody);
    var response = await http.post(url, body: body, headers: {
      'accept': '*/*',
      'Content-Type': 'application/json-patch+json'
    });

    var responseMap = jsonDecode(response.body);
    var data = responseMap["data"];

    if (response.statusCode == 200) {
      String applicationToken = data["token"];

      ref
          .read(secureStorageProvider.notifier)
          .upsertApplicationToken(applicationToken);

      return AuthResponse.success;
    } else if (response.statusCode == 400) {
      if (data[0]["code"] == "InvalidCredentials") {
        return AuthResponse.invalidCredentials;
      } else {
        return AuthResponse.randomError;
      }
    } else {
      return AuthResponse.randomError;
    }
  }

  static Widget initialRouting() {
    var user = HiveService().getUser();
    if (user == null) {
      return const LoginPage();
    } else {
      return const HomePage();
      //}
    }
  }
}