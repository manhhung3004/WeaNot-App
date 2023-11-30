import 'package:flutter/material.dart';
class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Image.asset(
          imagePath,
          height: 30,
          width: 30,
      ),
    );
  }
}
