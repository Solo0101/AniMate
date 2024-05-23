import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/pet.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/components/pet_icon.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/pages/add_pet_page.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/hive_service.dart';
import 'package:frontend/services/validate_credentials.dart';
import 'package:frontend/components/pet_icon.dart';
import 'package:frontend/pages/pet_profile_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final double topContainerPercentage = 0.3; //bottom percentage will be the rest of the page
  final double profileHeight = 120;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Text(HiveService().getUser()!.name, style: const TextStyle(fontSize: 20)),
              Wrap(children: [
                FutureBuilder(
                  future: ApiService.fetchPetsByUser(HiveService().getUser()!.id, ref),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if(snapshot.hasData && !snapshot.hasError) {
                      return GridView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Pet pet = snapshot.data![index];
                          return PetIcon(
                            petIconImage: 'lib/src/images/petIcon.jpeg',
                            petName: pet.name,
                            widget: const PetProfilePage(/*pet: snapshot.data![index]*/),
                          );
                        }, gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      );
                    }
                    if (kDebugMode) {
                      print(snapshot.data);
                      print(snapshot.error);
                    }
                    return const Text('No pets found');
                  },
                ),
                const PetIcon(
                  petIconImage: 'lib/src/images/petIcon.jpeg',
                  petName: "Add new pet!",
                  widget: PetProfilePage(/*pet: snapshot.data![index]*/),
                )
              ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Widget>> generatePetIcons(WidgetRef ref) async {
  List<Widget> petIcons = [];
  User? user = HiveService().getUser();
  List<Pet> pets = await ApiService.fetchPetsByUser(user!.id, ref);

  for (var pet in pets) {
    petIcons.add(
        PetIcon(
          petIconImage: 'lib/src/images/petIcon.jpeg',
          petName: pet.name,
          widget: const PetProfilePage(/*pet: snapshot.data![index]*/)
        )
    );
  }
  petIcons.add(const PetIcon(petIconImage: 'lib/src/images/addPetButton.jpeg', petName: 'Add new pet', widget: AddPetPage()));

  return petIcons;
}