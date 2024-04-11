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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              height:
                  MediaQuery.of(context).size.height * topContainerPercentage,
              color: primaryGreen,
              child: const Center(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Home',
                          style: TextStyle(
                              fontSize: 40.0, color: primaryTextColor)),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  (1 - topContainerPercentage),
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
