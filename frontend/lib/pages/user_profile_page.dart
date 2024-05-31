import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/providers/token_provider.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/hive_service.dart';
import '../models/user.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/components/my_scrollbar.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/style_constants.dart';

import '../components/my_appbar.dart';
import '../components/my_drawer.dart';

SecureStorageNotifier tokenProvider = SecureStorageNotifier();

class UserProfilePage extends ConsumerStatefulWidget {

  const UserProfilePage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {

  @override
  Widget build(BuildContext context) {
    var user = HiveService().getUser()!;
    const double topContainerPercentage = 0.15;
    //bottom percentage will be the rest of the page
    const double profileHeight = 120;

    late TextEditingController userNameController;
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
                              const Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SizedBox(
                                  //     height: (topContainerHeight -
                                  //         profileHeight -
                                  //         profileHeight / 5)),
                                ],
                              ),
                              Positioned(
                                top: top,
                                child: CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: Image.network('${ApiConstants.userResources}${user.imageLink}').image,
                                ),
                              )
                            ]),
                      ],
                    )),
              ),
              const SizedBox(height: 60),
              Text(user.name,
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
                                    controller: userNameController =  TextEditingController(text: user.name),
                                    hintText: "Name"),
                                MyTextField(
                                    controller: userEmailController = TextEditingController(text: user.email),
                                    hintText: "Email"),
                                MyTextField(
                                    controller: userPhoneNumberController = TextEditingController(text: user.phoneNumber.toString()),
                                    hintText: "Phone number"),
                                MyTextField(
                                    controller: userCountryController = TextEditingController(text: user.country),
                                    hintText: "Country"),
                                MyTextField(
                                    controller: userCountyOrStateController = TextEditingController(text: user.countyOrState),
                                    hintText: "County or state"),
                                MyTextField(
                                    controller: userCityController = TextEditingController(text: user.city),
                                    hintText: "City"),

                                MyButton(
                                    buttonColor: utilityButtonColor,
                                    textColor: buttonTextColor,
                                    buttonText: 'Save',
                                    onPressed: () async {
                                      User updatedUser = User(
                                          id: user.id,
                                          name: userNameController.text.trim(),
                                          email: userEmailController.text.trim(),
                                          phoneNumber: userPhoneNumberController.text.trim(),
                                          country: userCountryController.text.trim(),
                                          countyOrState: userCountyOrStateController.text.trim(),
                                          city: userCityController.text.trim(),
                                          imageLink: user.imageLink
                                      );
                                      int responseCode = await ApiService.updateUser(updatedUser, tokenProvider.getApplicationToken());
                                      if (kDebugMode) {
                                        print(responseCode);
                                      }
                                    }),
                                MyButton(
                                    buttonColor: importantUtilityButtonColor,
                                    textColor: buttonTextColor,
                                    buttonText: 'Delete Account',
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
