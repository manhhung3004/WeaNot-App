import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Profile/button_editProfile.dart';
import 'package:weather_app/login/text_fill.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  State<EditProfile> createState() => _SignUpState();
}

class _SignUpState extends State<EditProfile> {
  String? userMail = FirebaseAuth.instance.currentUser?.email.toString();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              'Edit your profile',
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
            button_editprofile(onTap: _editprofile),
            const SizedBox(height: 50),
          ],
        )),
      ),
    );
  }

  void _editprofile() async {
    // Do not have any thing
  }
}
