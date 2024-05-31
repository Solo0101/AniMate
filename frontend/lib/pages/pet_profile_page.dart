import 'package:flutter/material.dart';
import 'package:frontend/classes/pet_class.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/components/my_scrollbar.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/style_constants.dart';

class PetProfilePage extends StatelessWidget {
  final Pet pet;

  PetProfilePage({
    super.key,
    required this.pet,
  });

  final petNameController = TextEditingController();
  final petTypeController = TextEditingController();
  final petAgeController = TextEditingController();
  final petSexController = TextEditingController();
  final petRaceController = TextEditingController();
  final petDescriptionController = TextEditingController();

  final double topContainerPercentage =
      0.25; //bottom percentage will be the rest of the page
  final double profileHeight = 120;

  @override
  Widget build(BuildContext context) {
    final double topContainerHeight =
        MediaQuery.of(context).size.height * topContainerPercentage;
    final double bottomContainerHeight =
        MediaQuery.of(context).size.height * (1 - topContainerPercentage);
    // final double screenSizeWidth = MediaQuery.of(context).size.width;

    final top = topContainerHeight - profileHeight / 2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                                    fontSize: 40.0, color: primaryTextColor)),
                          ],
                        ),
                        Positioned(
                          top: top,
                          child: CircleAvatar(
                            radius: profileHeight / 2,
                            backgroundColor: Colors.grey,
                            backgroundImage: AssetImage(pet.imageLink),
                          ),
                        )
                      ]),
                ],
              )),
            ),
            const SizedBox(height: 60),
            Text(pet.name,
                style:
                const TextStyle(fontSize: 30, color: primaryGreen)),
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
                              hintText: pet.name,
                              obscureText: false),
                          MyTextField(
                              controller: petTypeController,
                              hintText: pet.type,
                              obscureText: false),
                          MyTextField(
                              controller: petAgeController,
                              hintText: pet.age.toString(),
                              obscureText: false),
                          MyTextField(
                              controller: petSexController,
                              hintText: pet.gender,
                              obscureText: false),
                          MyTextField(
                              controller: petRaceController,
                              hintText: pet.race,
                              obscureText: false),
                          MyTextField(
                              controller: petDescriptionController,
                              hintText: pet.description,
                              obscureText: false),

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
                )))
          ],
        ),
      ),
    );
  }
}
