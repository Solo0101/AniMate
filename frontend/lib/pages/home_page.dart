import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/api_constants.dart';
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

import '../components/my_appbar.dart';
import '../components/my_drawer.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final double topContainerPercentage = 0.25; //bottom percentage will be the rest of the page
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


      appBar: const MyAppBar(),
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
                                  //   height:
                                  //       (topContainerHeight - profileHeight - profileHeight / 5)
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Home',
                                        style: TextStyle(
                                            fontSize: 40.0, color: primaryTextColor)),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: top,
                                child: HiveService().getUser()!.imageLink == '' || HiveService().getUser()!.imageLink == null ?
                                CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.person,
                                    size: profileHeight,
                                    color: Colors.black,
                                  ),
                                ) :
                                CircleAvatar(
                                  radius: profileHeight / 2,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: Image.network('${ApiConstants.userResources}${HiveService().getUser()!.imageLink}').image,
                                ),
                              )
                            ]),
                      ],
                    )),
              ),
        
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
                        itemCount: snapshot.data!.length + 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if(index == snapshot.data!.length) {
                            return PetIcon(
                              pet: Pet(
                                id: '',
                                name: '',
                                type: '',
                                breed: '',
                                age: 0,
                                gender: '',
                                description: '',
                                imageLink: '',
                              ),
                              isAddPet: true,
                            );
                          } else {
                            Pet pet = snapshot.data![index];
                            return PetIcon(
                                pet: pet
                            );
                          }
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                        ),
                      );
                    }
                    if (kDebugMode) {
                      print(snapshot.data);
                      print(snapshot.error);
                    }
                    return PetIcon(
                      pet: Pet(
                        id: '',
                        name: '',
                        type: '',
                        breed: '',
                        age: 0,
                        gender: '',
                        description: '',
                        imageLink: '',
                      ),
                      isAddPet: true,
                    );
                  },
                ),
              ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
