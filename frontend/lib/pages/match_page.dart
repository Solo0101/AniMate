import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/hive_service.dart';

import '../components/my_appbar.dart';
import '../components/my_drawer.dart';


class MatchPage extends ConsumerWidget {
  const MatchPage({super.key});

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

    // var currentPet = HiveService().getPets(); ??

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: const MyAppBar(),
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
                      ],),),),

            SizedBox(height: profileHeight / 2 + 20),
          ],
        ),
      ),
    );
  }
}
