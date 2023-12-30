import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/colors.dart';
class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      )

    );
  }
}
