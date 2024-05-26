import 'package:flutter/material.dart';
import 'package:frontend/classes/pet_class.dart';
import 'package:frontend/components/my_scrollbar.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/components/pet_icon.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/services/validate_credentials.dart';
import 'package:frontend/pages/pet_profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final double topContainerPercentage =
      0.3; //bottom percentage will be the rest of the page
  final double profileHeight = 120;

  @override
  Widget build(BuildContext context) {
    final double topContainerHeight =
        MediaQuery.of(context).size.height * topContainerPercentage;
    final double bottomContainerHeight =
        MediaQuery.of(context).size.height * (1 - topContainerPercentage);
    final double screenSizeWidth = MediaQuery.of(context).size.width;

    final top = topContainerHeight - profileHeight / 2;

    Pet p1 = Pet(
        name: 'Mufasa1',
        age: 14,
        imageLink: 'lib/src/images/alb.jpeg',
        description: 'pet1 - description');
    Pet p2 = Pet(
        name: 'Georgica2',
        age: 14,
        imageLink: 'lib/src/images/dobberman.jpeg',
        description: 'pet2 - description');
    Pet p3 = Pet(
        name: 'Maesto3',
        age: 14,
        imageLink: 'lib/src/images/idk.jpeg',
        description: 'pet3 - description');
    Pet p4 = Pet(
        name: 'Chubby4',
        age: 14,
        imageLink: 'lib/src/images/labrador.jpeg',
        description: 'pet4 - description');

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
                                  height:
                                      (topContainerHeight - profileHeight - profileHeight / 5)
                                ),
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
                                child: Icon(
                                  Icons.person,
                                  size: profileHeight,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ]),
                    ],
                  )),
            ),
            SizedBox(height: profileHeight / 2 + 20),
            SizedBox(
              height: bottomContainerHeight - (profileHeight / 2 + 20),
              child: MyScrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSizeWidth * 0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                PetIcon(pet: p1),
                                PetIcon(pet: p2),
                                PetIcon(pet: p3),
                                PetIcon(pet: p4),
                                PetIcon(pet: p4),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                              ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
