import 'package:flutter/material.dart';
import 'package:frontend/components/my_textfield.dart';
import 'package:frontend/constants/router_constants.dart';
import 'package:flutter/gestures.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: const Color(0xFF626353),
              child: const Center(
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text('AniMATE',
                          style:
                              TextStyle(fontSize: 40.0, color: Colors.white)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Welcome!',
                          style: TextStyle(fontSize: 25.0, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Scrollbar(
                thickness: 5.0,
                thumbVisibility: true,
                radius: const Radius.circular(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.fromLTRB(35.0, 30.0, 0.0, 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Sign in',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Color(0xFF626353),
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
                            const EdgeInsets.fromLTRB(35.0, 15.0, 35.0, 20.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF626353),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Login ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF626353),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'here',
                                          style: const TextStyle(
                                            fontFamily: 'HappyMonkey',
                                            color: Colors.blue,
                                            fontSize: 20.0
                                          ),
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                              Navigator.of(context).pushNamed(loginPageRoute);
                                                      },
                                            ),
                                    ),
                                    const Text(
                                      '!',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF626353),
                                      ),
                                    ),

                                  ],
                                )
                              ],
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
