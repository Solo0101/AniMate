import 'package:flutter/material.dart';

class DeletePet extends StatelessWidget {
  const DeletePet({super.key});

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
              Text('Pet successfully deleted!',
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
