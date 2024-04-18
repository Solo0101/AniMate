import 'package:flutter/material.dart';

class PetIcon extends StatelessWidget {
  final String petIconImage;
  final String petName;
  final Widget widget;

  const PetIcon({
    super.key,
    required this.petIconImage,
    required this.petName,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(children: [
            Image(image: Image.asset(petIconImage).image, width: 100, height: 100),
            Text(
              petName,
              style: const TextStyle(fontSize: 10.0, color: Colors.black),
            )
          ]),
        );
  }
}
