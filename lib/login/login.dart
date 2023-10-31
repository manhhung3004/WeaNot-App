import 'package:flutter/material.dart';
import 'package:weather_app/login/text_fill.dart';
import 'package:weather_app/login/my_button.dart';
import 'package:weather_app/login/square.dart';
import 'package:weather_app/ui/sign_up.dart';

abstract class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void signUserIn( ){
  }
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
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
                // welcome back, you've been missed!
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
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
                //forget password
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forget Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                //Sign in Button
                MyButton(
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
                //or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ) ,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                //google sign in
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(imagePath: 'assets/google.png'),
                    SizedBox(width: 10),
                  ],
                ),
                const SizedBox(width: 50),
                //Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Do not have an account?',
                    style: TextStyle(color: Colors.grey),),
                    const SizedBox(width: 4),
                    const Text('Register now',
                      style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)
                    ),
                    GestureDetector(
                      onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const SignUp()));
                      },
                    ),
                  ],
                )
            ],
          ),
        ),
      )
    );
  }
}