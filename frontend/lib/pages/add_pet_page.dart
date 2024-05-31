import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/components/my_scrollbar.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/models/pet.dart';
import 'package:frontend/services/api_service.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();

}
class _AddPetPageState extends State<AddPetPage> {
  @override
  Widget build(BuildContext context) {
    const double topContainerPercentage = 0.3;
    //bottom percentage will be the rest of the page
    const double profileHeight = 120;

    final TextEditingController petNameController = TextEditingController();
    final TextEditingController petTypeController = TextEditingController();
    final TextEditingController petAgeController = TextEditingController();
    final TextEditingController petGenderController = TextEditingController();
    final TextEditingController petBreedController = TextEditingController();
    final TextEditingController petDescriptionController = TextEditingController();

    final double topContainerHeight = MediaQuery.of(context).size.height * topContainerPercentage;
    final double bottomContainerHeight = MediaQuery.of(context).size.height * (1 - topContainerPercentage);
    // final double screenSizeWidth = MediaQuery.of(context).size.width;

    final top = topContainerHeight - profileHeight / 2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: <Widget>[
              Container(
                height: topContainerHeight,
                color: primaryGreen,
                child: Center(
                    child: Column(
                      children: [
                        Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: (topContainerHeight -
                                          profileHeight -
                                          profileHeight / 5)),
                                  const Text('Home',
                                      style: TextStyle(
                                          fontSize: 40.0,
                                          color: primaryTextColor)),
                                ],
                              ),
                              Positioned(
                                top: top,
                                child: CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: Image.network('${ApiConstants.otherResources}new_pet.jpg').image,
                                ),
                              )
                            ]),
                      ],
                    )),
              ),
              const SizedBox(height: 60),
              const Text("Add new Pet!",
                  style: TextStyle(fontSize: 30, color: primaryGreen)),
              SizedBox(
                  height: bottomContainerHeight - (profileHeight / 2 + 43),
                  child: MyScrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyTextField(
                                    controller: petNameController,
                                    hintText: "Name"),
                                MyTextField(
                                    controller: petTypeController,
                                    hintText: "Animal Type"),
                                MyTextField(
                                    controller: petAgeController,
                                    hintText: "Age"),
                                MyTextField(
                                    controller: petGenderController,
                                    hintText: "Gender"),
                                MyTextField(
                                    controller: petBreedController,
                                    hintText: "Breed"),
                                MyTextField(
                                    controller: petDescriptionController,
                                    hintText: "Description"),

                                FloatingActionButton(
                                  onPressed: () => { ApiService.getImage() },
                                  tooltip: 'Pick Image',
                                  child: const Icon(Icons.add_a_photo),
                                ),

                                MyButton(
                                    buttonColor: utilityButtonColor,
                                    textColor: buttonTextColor,
                                    buttonText: 'Add new Pet!',
                                    onPressed: () async {
                                      Pet pet = Pet(
                                          id: '',
                                          name: petNameController.text.trim(),
                                          type: petTypeController.text.trim(),
                                          age: int.parse(petAgeController.text.trim()),
                                          gender: petGenderController.text.trim(),
                                          breed: petBreedController.text.trim(),
                                          description: petDescriptionController.text.trim(),
                                          imageLink: ''
                                      );
                                      int responseCode = await ApiService.addPet(pet, ref);
                                      if (kDebugMode) {
                                        print(responseCode);
                                      }

                                      if(responseCode == 204) {
                                        setState(() {});
                                      }

                                    }),
                                MyButton(
                                    buttonColor: importantUtilityButtonColor,
                                    textColor: buttonTextColor,
                                    buttonText: 'Cancel',
                                    onPressed: () {}),
                              ],
                            )
                          ],
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }


}
