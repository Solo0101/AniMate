import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:frontend/models/user.dart';
import 'package:frontend/models/pet.dart';
import 'package:frontend/services/api_service.dart';

class HiveService {
  late final Box<User> userBox;
  late final Box<Pet> petBox;
  static final HiveService _instance = HiveService._internal();


  factory HiveService() => _instance;

  HiveService._internal();

  Future<void> initHive() async{
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(PetAdapter());
    userBox = await Hive.openBox('user');
    petBox = await Hive.openBox('pet');
    // userBox = Hive.box<User>('user');
    // petBox = Hive.box<Pet>('pet');
  }

  User? getUser(){
    User? currentUser = userBox.get('user');
    return currentUser?.getValue();

  }

  Future upsertUserInBox(User newUser) async {
    return await _instance.userBox.put('user', newUser.getValue());
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

  Future<List<Pet>> fetchPetsAndSaveThemLocally(String ownerId, WidgetRef ref) async {
    List<Pet>? pets = await ApiService.fetchPetsByUser(ownerId , ref);
    for (var pet in pets ?? []) {
      upsertPetInBox(pet);
    }
    return pets ?? [];
  }

  Future clearBoxes() async {
    userBox.clear();
    petBox.clear();
  }

  Future<void> logoutUser() async {
    await clearBoxes();
    // Perform any additional cleanup if needed
    // For example, you might want to reset any in-memory user data or state
  }

}