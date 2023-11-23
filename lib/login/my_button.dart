import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';

class MyButton extends StatelessWidget {
  final Function() onTap;
  const MyButton({super.key, required this.onTap, required Text child});
  @override
  Widget build(BuildContext context) {
    Constants myConstans = Constants();
    return GestureDetector(
      onTap: (){
        onTap();
    },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: myConstans.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
            child: Text("Sign in",
              style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
        ),
      ),
    );
  }
}