import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/components/my_scrollbar.dart';
import 'package:frontend/constants/api_constants.dart';
import 'package:frontend/models/pet.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/components/pet_icon.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/pages/add_pet_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/match_splashart_page.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/hive_service.dart';

import '../components/my_appbar.dart';
import '../components/my_drawer.dart';

class MatchPage extends ConsumerWidget {
  const MatchPage(
      {required this.petId, required this.wantedPets, required int this.index, super.key});

  final double topContainerPercentage =
      0; //bottom percentage will be the rest of the page
  final double profileHeight = 120;

  final List<Pet> wantedPets;
  final int index;
  final String petId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double topContainerHeight =
        MediaQuery.of(context).size.height * topContainerPercentage;
    final double bottomContainerHeight =
        MediaQuery.of(context).size.height * (1 - topContainerPercentage);
    final double screenSizeWidth = MediaQuery.of(context).size.width;

    final top = topContainerHeight - profileHeight / 2;

    // var currentPet = HiveService().getPets(); ??
    const double fontSize = 30;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const MyAppBar(),
      endDrawer: const MyDrawer(),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Expanded(
                child: Hero(
                  tag: 'dada',
                  child: Container(
                    margin: const EdgeInsets.only(top: 0, right: 0, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      image: DecorationImage(
                        image: Image.network('${ApiConstants.petResources}${wantedPets[index].imageLink}').image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  wantedPets[index].name,
                  style: const TextStyle(fontSize: fontSize),
                ),
                Text(
                  wantedPets[index].age.toString(),
                  style: const TextStyle(fontSize: fontSize),
                ),
                Text(
                  wantedPets[index].type,
                  style: const TextStyle(fontSize: fontSize),
                ),
                Text(
                  wantedPets[index].breed,
                  style: const TextStyle(fontSize: fontSize),
                ),
                Text(
                  wantedPets[index].description,
                  style: const TextStyle(fontSize: fontSize - 20),
                ),
                //found image
                //name
                //type
                //breed
                //age
                //description
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                    buttonColor: Colors.deepOrangeAccent,
                    textColor: primaryTextColor,
                    buttonText: "<",
                    onPressed: () {

                      if(index == wantedPets.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MatchSplashPage()),
                        );
                        return;
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MatchPage(
                                petId: petId, wantedPets: wantedPets, index: index + 1)),
                      );
                    }), //decline
                MyButton(
                    buttonColor: primaryOverlayBackgroundColor,
                    textColor: primaryTextColor,
                    buttonText: "Filters",
                    onPressed: () {}), //fiters
                MyButton(
                    buttonColor: matchGreenButtonColor,
                    textColor: primaryTextColor,
                    buttonText: ">",
                    onPressed: () async {
                      var response = await ApiService.createMatch(
                          petId, wantedPets[index].id, ref);

                      if(index == wantedPets.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MatchSplashPage()),
                        );
                        return;
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MatchPage(
                                petId: petId, wantedPets: wantedPets, index: index + 1)),
                      );
                    }), //approve
              ],
            )
          ],
        ),
      ),
    );
  }
}
