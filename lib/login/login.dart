import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Clipper/clipper.dart';
import 'package:weather_app/dashboard/dashboard.dart';
import 'package:weather_app/login/text_fill.dart';
import 'package:weather_app/login/logup.dart';
import 'forget_password.dart';
import 'my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 200),
                      painter: RPSCustomPainter(),
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 200),
                        painter: RPSCustomPainter(),
                      ),
                    ),
                    Positioned(
                      top: 140,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          // const SizedBox(height: 10,),
                          Text(
                            'Welcome back you\'ve been missed!',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                // welcome back, you've been missed!
                // username textfield
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Username',
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                // password textfield
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                // forgot password?
                const SizedBox(
                  height:20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPassword()),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                // sign in button
                MyButton(
                  onTap: _signIn,
                  child: const Text("sign in"),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
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
                const SizedBox(
                  height: 40,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    try {
      String email = _emailController.text;
      String password = _passwordController.text;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Dashboard()),
            (Route<dynamic> route) => false);
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          wrongAccount();
          _emailController.clear();
          _passwordController.clear();
          break;
        case 'wrong-password':
          wrongAccount();
          _emailController.clear();
          _passwordController.clear();
          break;
        default:
          wrongAccount();
          _emailController.clear();
          _passwordController.clear();
          break;
      }
    } catch (e) {
      // Handle any other general exceptions
      _emailController.clear();
      _passwordController.clear();
      wrongAccount();
    }
  }

  // hiển thị khi không nhập mật khẩu tài khoảng
  void showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Emtple your email or password!!!'),
            content: const Text('Please try again!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  // Hiển thị thông báo khi sai mật khẩu tài khoản
  void wrongAccount() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Wrong your email or password!!!'),
            content: const Text('Please try again!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }
}
