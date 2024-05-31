import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/api_constants.dart';
import '../models/user.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/components/my_scrollbar.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/style_constants.dart';

import '../components/my_appbar.dart';
import '../components/my_drawer.dart';


class UserProfilePage extends ConsumerStatefulWidget {
  final User user;

  const UserProfilePage({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {

  @override
  Widget build(BuildContext context) {
    const double topContainerPercentage = 0.25;
    //bottom percentage will be the rest of the page
    const double profileHeight = 120;

    late TextEditingController userNameController = TextEditingController(text: widget.user.name);
    late TextEditingController userEmailController;
    late TextEditingController userPhoneNumberController;
    late TextEditingController userCountryController;
    late TextEditingController userCountyOrStateController;
    late TextEditingController userCityController;

    final double topContainerHeight = MediaQuery.of(context).size.height * topContainerPercentage;
    final double bottomContainerHeight = MediaQuery.of(context).size.height * (1 - topContainerPercentage);
    // final double screenSizeWidth = MediaQuery.of(context).size.width;

    final top = topContainerHeight - profileHeight / 2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(hasBackButton: true,),
      endDrawer: const MyDrawer(),
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
                                        fontSize: 40.0,
                                        color: primaryTextColor)),
                              ],
                            ),
                            Positioned(
                              top: top,
                              child: CircleAvatar(
                                radius: profileHeight / 2,
                                backgroundColor: Colors.grey,
                                backgroundImage: Image.network('${ApiConstants.petResources}${widget.user.imageLink}').image,
                              ),
                            )
                          ]),
                    ],
                  )),
            ),
            const SizedBox(height: 60),
            Text(widget.user.name,
                style: const TextStyle(fontSize: 30, color: primaryGreen)),
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
                                  controller: userNameController,
                                  hintText: "Name"),
                              MyTextField(
                                  controller: userEmailController = TextEditingController(text: widget.user.email),
                                  hintText: "Email"),
                              MyTextField(
                                  controller: userPhoneNumberController = TextEditingController(text: widget.user.phoneNumber.toString()),
                                  hintText: "Phone number"),
                              MyTextField(
                                  controller: userCountryController = TextEditingController(text: widget.user.country),
                                  hintText: "Country"),
                              MyTextField(
                                  controller: userCountyOrStateController = TextEditingController(text: widget.user.countyOrState),
                                  hintText: "County or state"),
                              MyTextField(
                                  controller: userCityController = TextEditingController(text: widget.user.city),
                                  hintText: "City"),

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
