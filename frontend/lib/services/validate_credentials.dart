import 'package:flutter/material.dart';

class ValidateCredentials extends StatelessWidget {
  const ValidateCredentials({super.key});

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
              Text('Credentials successfully validated!',
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
