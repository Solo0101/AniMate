import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/services/validate_credentials.dart';

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

    final top = topContainerHeight - profileHeight / 2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            Stack(alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: topContainerHeight,
                    color: primaryGreen,
                    child: const Center(
                      child: SafeArea(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Home',
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
            SizedBox(
              height: bottomContainerHeight,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(35.0, 30.0, 0.0, 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
