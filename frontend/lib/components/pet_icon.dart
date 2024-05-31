import 'package:flutter/material.dart';
import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/models/pet.dart';
import 'package:frontend/pages/add_pet_page.dart';
import 'package:frontend/pages/pet_profile_page.dart';

class PetIcon extends StatelessWidget {
  final Pet pet;
  final bool isAddPet;

  const PetIcon({
    super.key,
    required this.pet,
    this.isAddPet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => !isAddPet ? PetProfilePage(pet: pet) : const AddPetPage()));
            },
            child: Card(
              elevation: 3.0,
              child: Column(children: [
                SizedBox(
                    width: 125,
                    height: 125,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: !isAddPet ? Image.network(
                          '${ApiConstants.petResources}${pet.imageLink}',
                          fit: BoxFit.cover,
                          width: 10,
                          height: 10,
                        )
                            : Image.network(
                          '${ApiConstants.otherResources}new_pet.jpg',
                          fit: BoxFit.cover,
                          width: 10,
                          height: 10,
                        )
                        ,
                      ),
                    )),
              ]),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            !isAddPet ? pet.name : 'Add New Pet',
            style: const TextStyle(fontSize: 15.0, color: Colors.black),
          )
        ],
      ),
    );
  }
}
