import 'package:frontend/Models/pet.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String phoneNumber;
  @HiveField(4)
  final String country;
  @HiveField(5)
  final String countyOrState;
  @HiveField(6)
  final String city;
  @HiveField(7)
  List<Pet>? pets;


  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.city,
    required this.countyOrState,
    this.pets,
  });

  // receive data from the server and convert it to a User object
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      country: json['country'],
      city: json['city'],
      countyOrState: json['countyOrState'],
      pets: json['pets'] != null ? List<Pet>.from(json['pets'].map((pet) => Pet.fromJson(pet))) : null,
    );

  // convert the User object to a JSON object to send to the server
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'country': country,
    'city': city,
    'countyOrState': countyOrState,
    'pets': pets != null ? List<dynamic>.from(pets!.map((pet) => pet.toJson())) : null,
  };

  User getValue() {
    return User(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      country: country,
      city: city,
      countyOrState: countyOrState,
      pets: pets,
    );
  }
}