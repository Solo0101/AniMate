import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:frontend/services/hive_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/models/user.dart';
import 'package:frontend/models/pet.dart';

import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/providers/token_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:frontend/providers/token_provider.dart';


class ApiService {
  ApiService._();

  static late XFile? image;


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
            description: responseMap[i]["description"],
            imageLink: responseMap[i]["image"]
        );

        petList.add(pet);
      }

      if (kDebugMode) {
        print(petList);
      }
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

  static Future<int> updateUser(User user, Future<String> applicationToken) async {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appUpdateUserByIdEndpoint);
    var token = await applicationToken;
    var image = await ApiService.getImage();
    var stream = http.ByteStream(Stream.castFrom(image!.openRead()));
    final int length = await image!.length();

    var request = http.MultipartRequest('PUT', url)
      ..headers.addAll({
        'accept': '*/*',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'})
      ..files.add(http.MultipartFile('image', stream, length, filename: image!.path.split('/').last))
      ..fields['email'] = user.email
      ..fields['name'] = user.name
      ..fields['country'] = user.country
      ..fields['countyOrState'] = user.countyOrState
      ..fields['city'] = user.city
      ..fields['phoneNumber'] = user.phoneNumber
      ..fields['id'] = user.id;


    var response = await http.Response.fromStream(await request.send());
    if (kDebugMode) {
      print(response.body);
    }
    return response.statusCode;
  }

  static Future getImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return;
    }
  }

  static Future<int> addPet(Pet pet, Future<String> appToken) async {
      var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appCreatePetEndpoint);
      var token = await appToken;
      var stream = http.ByteStream(Stream.castFrom(image!.openRead()));
      final int length = await image!.length();

      var request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'accept': '*/*',
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token'})
      ..files.add(http.MultipartFile('image', stream, length, filename: image!.path.split('/').last))
      ..fields['name'] = pet.name
      ..fields['animalType'] = pet.type
      ..fields['breed'] = pet.breed
      ..fields['age'] = pet.age.toString as String
      ..fields['description'] = pet.description
      ..fields['gender'] = pet.gender == "female" ? "1" : "0";


      var response = await http.Response.fromStream(await request.send());

      if (kDebugMode) {
        print(response.body);
      }
      return response.statusCode;
    }

  static Future<int> updatePet(Pet pet, Future<String> appToken) async {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appUpdatePetEndpoint + pet.id);
    var token = await appToken;
    var stream = http.ByteStream(Stream.castFrom(image!.openRead()));
    final int length = await image!.length();

    var request = http.MultipartRequest('PUT', url)
      ..headers.addAll({
        'accept': '*/*',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'})
      ..files.add(http.MultipartFile('imageFile', stream, length, filename: image!.path.split('/').last))
      ..fields['name'] = pet.name
      ..fields['animalType'] = pet.type
      ..fields['breed'] = pet.breed
      ..fields['age'] = pet.age.toString()
      ..fields['description'] = pet.description
      ..fields['gender'] = pet.gender == "female" ? "1" : "0";


    var response = await http.Response.fromStream(await request.send());

    if (kDebugMode) {
      print(response.body);
    }
    return response.statusCode;
  }

  static Future<List<Pet>> getPetsByTypeAndGender(String type, String gender, WidgetRef ref) async {
    int genderAsInt = gender == "male" ? 1 : 0;

    var url = Uri.https(ApiConstants.baseUrl,
        "${ApiConstants.appGetPetByTypeEndpoint}$type/gender/$genderAsInt");
    var token = _getDefaultHeader(ref);
    var response = await http.get(url, headers: <String, String>{
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    var responseMap = jsonDecode(response.body);
    List<Pet> petList = [];

    for (int i = 0; i < responseMap.length; ++i) {
      Pet pet = Pet(
          id: responseMap[i]["id"],
          name: responseMap[i]["name"],
          type: responseMap[i]["animalType"],
          breed: responseMap[i]["breed"],
          age: responseMap[i]["age"],
          gender: responseMap[i]["gender"] == 1 ? "male" : "female",
          description: responseMap[i]["description"],
          imageLink: responseMap[i]["image"]
      );

      petList.add(pet);
    }

    if (kDebugMode) {
      print(petList);
    }
    return petList;
  }

  static Future<int> deletePet(String petId, Future<String> appToken) async {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appDeletePetByIdEndpoint + petId);
    var token = await appToken;
    var response = await http.delete(url, headers: <String, String>{
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (kDebugMode) {
      print(response.body);
    }
    return response.statusCode;
  }

  static Future<int> createMatch(String petId, String petId2, WidgetRef ref) async {
    var url = Uri.https(ApiConstants.baseUrl, ApiConstants.appCreateMatchEndpoint);
    var token = _getDefaultHeader(ref);
    var requestBody = {
      'petId': petId,
      'matchedPetId': petId2  
    };

    var body = jsonEncode(requestBody);
    var response = await http.post(url, body: body, headers: {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (kDebugMode) {
      print(response.body);
    }
    return response.statusCode;
  }
}