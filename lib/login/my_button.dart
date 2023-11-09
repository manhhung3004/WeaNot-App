import 'package:flutter/material.dart';
import 'package:weather_app/ui/welcome.dart';

class MyButton extends StatelessWidget {
  final Function() onTap;
  const MyButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
    },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
            child: Text("Sign In",
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