import 'dart:convert';

import 'package:frontend/Models/user.dart';
import 'package:frontend/services/hive_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/providers/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthResponse { success, invalidCredentials, badRequest, randomError }

class AuthService {
  static Future<AuthResponse> login(String email, String password, WidgetRef ref) async {
    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appLoginEndpoint);
    var body = jsonEncode(requestBody);
    var response = await http.post(url, body: body, headers: {
      'accept': '*/*',
      'Content-Type': 'application/json'
    });

    var responseMap = jsonDecode(response.body);

    if (response.statusCode == 200) {
      String applicationToken = responseMap["token"];
      var user = User.fromJson(responseMap);
      HiveService().upsertUserInBox(user);
      ref
          .read(secureStorageProvider.notifier)
          .upsertApplicationToken(applicationToken);

      return AuthResponse.success;
    } else if (response.statusCode == 400) {
      return AuthResponse.invalidCredentials;
    } else {
      return AuthResponse.badRequest;
    }
  }

  static Widget initialRouting(WidgetRef ref) {
    var user = HiveService().getUser();
    if (user == null) {
      return LoginPage();
    } else {
      return const HomePage();
      //}
    }
  }

  static Future<AuthResponse> register({required String email, required String name, required String country, required String countyOrState, required String city, required String phoneNumber, required String password, required String confirmPassword, required WidgetRef context}) async {
    Map<String, String> requestBody = {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'country': country,
      'countyOrState': countyOrState,
      'city': city,
      'phoneNumber': phoneNumber
    };

    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appRegisterEndpoint);
    var body = jsonEncode(requestBody);
    var response = await http.post(url, body: body, headers: {
      'accept': '*/*',
      'Content-Type': 'application/json'
    });
    if(response.statusCode == 201) {
      return Future.value(AuthResponse.success);
    } else {
      return Future.value(AuthResponse.randomError);
    }

  }

  static Future<AuthResponse> forgotPassword(String text, WidgetRef context) {
    return Future.value(AuthResponse.success);
  }
}