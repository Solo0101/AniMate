import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:frontend/models/pet.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/components/my_scrollbar.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/style_constants.dart';

import '../components/my_appbar.dart';
import '../components/my_drawer.dart';

class PetProfilePage extends ConsumerStatefulWidget {
  final Pet pet;

  const PetProfilePage({
    super.key,
    required this.pet,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PetProfilePageState();
}

class _PetProfilePageState extends ConsumerState<PetProfilePage> {

  @override
  Widget build(BuildContext context) {
    const double topContainerPercentage = 0.25;
    //bottom percentage will be the rest of the page
    const double profileHeight = 120;

    late TextEditingController petNameController = TextEditingController(text: widget.pet.name);
    late TextEditingController petTypeController;
    late TextEditingController petAgeController;
    late TextEditingController petGenderController;
    late TextEditingController petBreedController;
    late TextEditingController petDescriptionController;

    final double topContainerHeight = MediaQuery.of(context).size.height * topContainerPercentage;
    final double bottomContainerHeight = MediaQuery.of(context).size.height * (1 - topContainerPercentage);
    // final double screenSizeWidth = MediaQuery.of(context).size.width;

    final top = topContainerHeight - profileHeight / 2;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const MyAppBar(hasBackButton: true,),
      endDrawer: const MyDrawer(),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyButton(buttonColor: utilityButtonColor, textColor: primaryTextColor, buttonText: "History", onPressed: (){  }),
                                      MyButton(buttonColor: matchGreenButtonColor, textColor: primaryTextColor, buttonText: "Match", onPressed: (){ Navigator.of(context)
                                          .pushNamed(matchPageRoute); }),

                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                top: top,
                                child: CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: Image.network('${ApiConstants.petResources}${widget.pet.imageLink}').image,
                                ),
                              )
                            ]),
                      ],
                    )),
              ),
              const SizedBox(height: 60),
              Text(widget.pet.name,
                  style: const TextStyle(fontSize: 30, color: primaryGreen)),
              SizedBox(
                  height: bottomContainerHeight - (profileHeight / 2 + 43),
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
                                controller: petTypeController = TextEditingController(text: widget.pet.type),
                                hintText: "Animal Type"),
                            MyTextField(
                                controller: petAgeController = TextEditingController(text: widget.pet.age.toString()),
                                hintText: "Age"),
                            MyTextField(
                                controller: petGenderController = TextEditingController(text: widget.pet.gender),
                                hintText: "Gender"),
                            MyTextField(
                                controller: petBreedController = TextEditingController(text: widget.pet.breed),
                                hintText: "Breed"),
                            MyTextField(
                                controller: petDescriptionController = TextEditingController(text: widget.pet.description),
                                hintText: "Description"),
        
                            MyButton(
                                buttonColor: utilityButtonColor,
                                textColor: buttonTextColor,
                                buttonText: 'Save',
                                onPressed: () {}),
                            MyButton(
                                buttonColor: importantUtilityButtonColor,
                                textColor: buttonTextColor,
                                buttonText: 'Delete Pet',
                                onPressed: () {}),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
