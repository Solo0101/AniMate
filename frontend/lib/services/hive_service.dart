import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:frontend/Models/user.dart';
import 'package:frontend/Models/pet.dart';
import 'package:frontend/services/api_service.dart';

class HiveService {
  late final Box<User> userBox;
  late final Box<Pet> petBox;
  static final HiveService _instance = HiveService._internal();


  factory HiveService() => _instance;

  HiveService._internal();

  Future<void> init() async{
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(PetAdapter());
    userBox = Hive.box<User>('user');
    petBox = Hive.box<Pet>('pet');
  }

  User? getUser(){
    return userBox.get('user');
  }

  Future upsertUserInBox(User newUser) async{
    await _instance.userBox.put('user', newUser.getValue());
  }

  List<Pet> getPets(){
    return _instance.petBox.values.toList();
  }

  Future upsertPetInBox(Pet newPet) async{
    await _instance.petBox.put(newPet.id, newPet);
  }

  Future<void> deletePetFromBox(String id) async{
    await _instance.petBox.delete(id);
  }

  Future<List<Pet>> fetchPetsAndSaveThemLocally(WidgetRef ref) async {
    List<Pet>? pets = await ApiService.fetchAllPets(ref);
    for (var pet in pets ?? []) {
      upsertPetInBox(pet);
    }
    return pets ?? [];
  }

  Future clearBoxes() async {
    userBox.clear();
    petBox.clear();
  }

}