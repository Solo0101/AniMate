import 'package:flutter/cupertino.dart';
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => widget));
                },
                child: Card(
                  elevation: 3.0,
                  child: Column(children: [
                    Container(
                      width: 125,
                      height: 125,
                      child: AspectRatio(
                        aspectRatio: 4.0/3.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(petIconImage, fit: BoxFit.cover, width: 10, height: 10,),
                        ),
                      )
                    ),

                  ]),
                ),
              ),
              Text(
                petName,
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
              )
            ],
          ),
        );
  }
}
