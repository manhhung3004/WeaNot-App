
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  Future PasswordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
      showDialog(
          context: context,
          builder:  (context) {
            return AlertDialog(
              content: Text('Password reset link sent ! Please check your E-mail'),
            );
          });
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(
          context: context,
          builder:  (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
      });
    }
    }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0  ,
      ),
      body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text("Enter your E-mail for password reset !"),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
    ),
    hintText: 'Email',
    fillColor: Colors.grey[200],
    filled: true,
              )
            )
          ),
        SizedBox(height: 10),
        MaterialButton(
          onPressed: PasswordReset,
          child: Text('Reset Password'),
          color: Colors.grey[200],
        )
        ]
      )
    );
  }
}
