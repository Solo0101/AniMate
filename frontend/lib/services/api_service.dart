import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/Models/user.dart';
import 'package:frontend/Models/pet.dart';

import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/providers/token_provider.dart';
import 'package:frontend/services/hive_service.dart';


class ApiService {
  ApiService._();

  static fetchPetsByUser(String ownerId, WidgetRef ref) {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appGetPetByUserIdEndpoint, "ownerId=$ownerId" as Map<String, dynamic>?);
    var token = _getDefaultHeader(ref);
    return http.get(url, headers: <String, String>{
      'accept': '*/*',
      'Content-Type': 'application/json-patch+json',
      'Authorization': 'Bearer $token'
    }).then((response) {
      var responseMap = jsonDecode(response.body);
      var data = responseMap["data"];
      return data.map<Pet>((pet) => Pet.fromJson(pet)).toList();
    });
  }

  static Future<User> fetchUser(WidgetRef ref) async {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appGetUserByIdEndpoint);
    var token = await _getDefaultHeader(ref);
    var response = await http.get(url, headers: {
      'accept': '*/*',
      'Content-Type': 'application/json-patch+json',
      'Authorization': 'Bearer $token'
    });

    var responseMap = jsonDecode(response.body);
    var data = responseMap["data"];
    return User.fromJson(data);
  }

  static Future<Map<String, String>> _getDefaultHeader(WidgetRef ref) async {
    var token = await ref.read(secureStorageProvider.notifier).getApplicationToken();
    return {'Authorization': 'Bearer $token', 'accept': '*/*'};
  }
}