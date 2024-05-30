import 'package:hive/hive.dart';

part 'pet.g.dart';

@HiveType(typeId: 1)
class Pet extends HiveObject{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final String breed;
  @HiveField(4)
  final int age;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final String description;

  Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.gender,
    required this.description
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    id: json['id'],
    name: json['name'],
    type: json['animalType'],
    breed: json['breed'],
    age: json['age'],
    gender: json['gender'],
    description: json['description']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'animalType': type,
    'breed': breed,
    'age': age,
    'gender': gender,
    'description': description
  };
}