
import 'package:flutter/material.dart';
// import 'package:weather_app/homepage/widget_images.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: BackgroundImage(),
      ),
    );
 }
}

class BackgroundImage extends StatelessWidget {
 const BackgroundImage({super.key});
 @override
 Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/photo-1436891620584-47fd0e565afb1.png"),
          fit: BoxFit.cover),
      ),
       child: const Stack(
        children: [
          CenteredHouse(),
          temple()
        ],
       )
    );
 }
}

class CenteredHouse extends StatelessWidget {
 const CenteredHouse({super.key});
 @override
 Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("images/House.png"), fit: BoxFit.cover)
      ),
    );
 }
}

// ignore: camel_case_types
class temple extends StatelessWidget {
  const temple ({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return Container(

    );
  }
}
  