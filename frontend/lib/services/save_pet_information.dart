import 'package:flutter/material.dart';

class SavePetInformation extends StatelessWidget {
  const SavePetInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.80,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Information successfully saved!',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 17.0
                ),),
            ],
          )
        ],
      ),
    );
  }
}
