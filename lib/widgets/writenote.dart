import 'package:flutter/material.dart';
import 'package:weather_app/ui/notepage.dart';
import 'package:weather_app/ui/welcome.dart';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    // ...
    home: Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('WriteNote'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Welcome()),
            );
          },
        ),
      ),
    ),
  );
}
