import 'package:flutter/material.dart';

class CenteredHouse extends StatelessWidget {
 const CenteredHouse({super.key});
 @override
 Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        // padding: const EdgeInsets.all(30.0),
        // margin: const EdgeInsets.all(30.0),
        width: 360,
        height: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/House.png"),
            fit: BoxFit.cover),
        ),
      ),
    );
 }
}