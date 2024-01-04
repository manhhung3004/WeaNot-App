import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/login/login.dart';
import 'package:weather_app/login/my_sign_up_button.dart';
import 'package:weather_app/login/text_fill.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool validateEmail(String value) {
  // Kiểm tra định dạng email
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  return emailRegex.hasMatch(value);
}

bool validatePhone(String value) {
  // Kiểm tra số điện thoại chỉ chứa số và có độ dài từ 10 đến 15 ký tự
  final phoneRegex = RegExp(r'^[0-9]{10,15}$');
  return phoneRegex.hasMatch(value);
}

void showValidationMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                'Get on board!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 25),
              Text(
                'Create your profile to start',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 25),
              //Name
              MyTextField(
                controller: _nameController,
                hintText: 'Your name',
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // email textfield
              MyTextField(
                controller: _emailController,
                hintText: 'E-Mail',
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _phoneController,
                hintText: 'Phone',
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              //address
              MyTextField(
                controller: _addressController,
                hintText: 'Address',
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // password textfield
              MyTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              button_login(onTap: _signUp),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    if (_nameController.text.isEmpty) {
    showValidationMessage("Please enter your name");
    return;
  }

  if (!validateEmail(email)) {
    showValidationMessage("Please enter a valid email");
    return;
  }

  if (!validatePhone(_phoneController.text)) {
    showValidationMessage("Please enter a valid phone number");
    return;
  }

  if (_addressController.text.isEmpty) {
    showValidationMessage("Please enter your address");
    return;
  }

  if (password.length < 6) {
    showValidationMessage("Password should be at least 6 characters");
    return;
  }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        showValidationMessage("Registration successful");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      });
      await FirebaseFirestore.instance.collection("user").add({
            "address": _addressController.text.trim(),
            "name": _nameController.text.trim(),
            "password": _passwordController.text.trim(),
            "phone": _phoneController.text.trim(),
            "username": _emailController.text.trim(),
          });
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.message}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
