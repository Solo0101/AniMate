import 'package:flutter/material.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/services/validate_credentials.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                      Text('AniMATE',
                          style: TextStyle(
                              fontSize: 40.0, color: primaryTextColor)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Welcome!',
                          style: TextStyle(
                              fontSize: 25.0, color: primaryTextColor))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  (1 - topContainerPercentage),
              child: Scrollbar(
                thickness: 5.0,
                thumbVisibility: true,
                radius: const Radius.circular(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(35.0, 30.0, 0.0, 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Sign in',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: primaryGreen,
                                )),
                          ],
                        ),
                      ),
                      MyTextField(
                        controller: emailController,
                        hintText: 'E-mail',
                        obscureText: false,
                      ),
                      MyTextField(
                        controller: fullNameController,
                        hintText: 'Full Name',
                        obscureText: false,
                      ),
                      MyTextField(
                        controller: phoneNumberController,
                        hintText: 'Phone Number',
                        obscureText: false,
                      ),
                      MyTextField(
                        controller: locationController,
                        hintText: 'Location',
                        obscureText: false,
                      ),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 15.0, 35.0, 20.0),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Login ',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: primaryGreen,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'here',
                                    style: const TextStyle(
                                        fontFamily: 'HappyMonkey',
                                        color: Colors.blue,
                                        fontSize: 15.0),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .pushNamed(loginPageRoute);
                                      },
                                  ),
                                ),
                                const Text(
                                  '!',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ValidateCredentials()));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        // margin: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: utilityButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: const Row(children: [
                                          Text(
                                            'Sign in',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: buttonTextColor),
                                          )
                                        ]),
                                      )),
                                ],
                              ),
                            )
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
