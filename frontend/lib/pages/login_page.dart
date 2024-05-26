import 'package:flutter/material.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/components/my_scrollbar.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/constants/style_constants.dart';
import 'package:frontend/services/validate_credentials.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              child: MyScrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 30.0, 0.0, 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Log in',
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
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(40.0, 15.0, 35.0, 20.0),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: primaryGreen,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Register ',
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
                                              .pushNamed(registerPageRoute);
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
                              const SizedBox(height: 15),
                              const MyButton(
                                  buttonColor: utilityButtonColor,
                                  textColor: buttonTextColor,
                                  buttonText: 'Log in',
                                  widget: ValidateCredentials()),
                              const MyButton(
                                  buttonColor: importantUtilityButtonColor,
                                  textColor: buttonTextColor,
                                  buttonText: 'Forgot Password',
                                  widget: ValidateCredentials())
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
