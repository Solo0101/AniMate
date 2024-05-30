import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/models/user.dart';
import 'package:frontend/models/pet.dart';

import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/providers/token_provider.dart';



class ApiService {
  ApiService._();

  static Future<List<Pet>> fetchPetsByUser(String ownerId, WidgetRef ref) async {
    var url = Uri.https(ApiConstants.baseUrl, "${ApiConstants.appGetPetByUserIdEndpoint}$ownerId");
    var token = _getDefaultHeader(ref);
    var response = await http.get(url, headers: <String, String>{
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

      var responseMap = jsonDecode(response.body);
      List<Pet> petList = [];

      for(int i = 0; i < responseMap.length; ++i) {

        Pet pet = Pet(
            id: responseMap[i]["id"],
            name: responseMap[i]["name"],
            type: responseMap[i]["animalType"],
            breed: responseMap[i]["breed"],
            age: responseMap[i]["age"],
            gender: responseMap[i]["gender"] == 1 ? "male" : "female",
            description: responseMap[i]["description"]
        );

        petList.add(pet);
      }

      print(petList);
      return petList;
  }

  static Future<User> fetchUser(WidgetRef ref) async {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appGetUserByIdEndpoint);
    var token = await _getDefaultHeader(ref);
    var response = await http.get(url, headers: {
      'accept': '*/*',
      'Content-Type': 'application/json',
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