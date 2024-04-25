import 'package:flutter/material.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/components/pet_icon.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/services/validate_credentials.dart';
import 'package:frontend/components/pet_icon.dart';
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: topContainerHeight,
                      color: primaryGreen,
                      child: Center(
                        child: SafeArea(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    (topContainerHeight - profileHeight / 2) -
                                        profileHeight +
                                        10,
                              ),
                              const Text('Home',
                                  style: TextStyle(
                                      fontSize: 40.0, color: primaryTextColor)),
                            ],
                          ),
                        ),
                      ),
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
              SizedBox(height: profileHeight / 2 + 20),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSizeWidth * 0.1),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        PetIcon(
                            petIconImage: 'lib/src/images/alb.jpeg',
                            petName: 'petName',
                            widget: PetProfilePage()),
                        PetIcon(
                            petIconImage: 'lib/src/images/dobberman.jpeg',
                            petName: 'petName',
                            widget: PetProfilePage()),
                        PetIcon(
                            petIconImage: 'lib/src/images/idk.jpeg',
                            petName: 'petName',
                            widget: PetProfilePage()),
                        PetIcon(
                            petIconImage: 'lib/src/images/labrador.jpeg',
                            petName: 'petName',
                            widget: PetProfilePage()),
                        PetIcon(
                            petIconImage: 'lib/src/images/alb.jpeg',
                            petName: 'petName',
                            widget: PetProfilePage()),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
