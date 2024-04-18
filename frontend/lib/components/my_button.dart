import 'package:flutter/material.dart';
import 'package:frontend/constants/style_constants.dart';

class MyButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String buttonText;
  final Widget widget;
  final Future onPressed;

  const MyButton({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.buttonText,
    required this.widget,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () async {
              await onPressed;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 15),
              // margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(children: [
                Text(
                  buttonText,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: buttonTextColor),
                )
              ]),
            )),
      ],
    );
  }
}