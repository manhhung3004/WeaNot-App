import 'package:flutter/material.dart';
import 'package:weather_app/login/my_sign_up_button.dart';
import 'package:weather_app/login/text_fill.dart';
<<<<<<< HEAD
import 'package:weather_app/login/my_button.dart';

=======
>>>>>>> 5c479281b5ad5021fb562688b9df4cfcc7f48c3a

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn(

      ){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),


                Text(
                  'Sign Up!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextFields(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextFields(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),
                My_SU_Button(onTap:
                signUserIn),
                const SizedBox(height: 50),
                  ],
                )

            ),
          ),
        );
  }
}

