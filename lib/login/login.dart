import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/dashboard/dashboard.dart';
import 'package:weather_app/login/square.dart';
import 'package:weather_app/login/text_fill.dart';
import 'package:weather_app/login/sign_up.dart';
import 'my_button.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // logo
              const Icon(
                Icons.lock,
                size: 50,
              ),
              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              // username textfield
              MyTextField(
                controller: _emailController,
                hintText: 'Username',
                obscureText: false,
              ),
              // password textfield
              MyTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        // GestureDetector(
                        // onTap: (){
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ForgetPassword()), (route) => false);
                        // },
                        // )
                      ],
                    ),
                    // GestureDetector(
                    //   onTap: (){
                    //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ForgetPassword()), (route) => false);
                    //   },
                    //   )
                  ],
                ),
              ),
              // sign in button
              MyButton(
                onTap: _signIn,
              ),
              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              // google + apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'assets/google.png'),
                  SizedBox(width: 20),
                  // apple button
                  SquareTile(imagePath: 'assets/apple.png'),
                ],
              ),
              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => const SignUp()), (
                                route) => false);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    await FirebaseAuth.instance.
    signInWithEmailAndPassword(email: email, password: password).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  const Dashboard()));
    }
  );
}}
