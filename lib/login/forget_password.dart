
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
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
      showDialog(
          context: context,
          builder:  (context) {
            return const AlertDialog(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0  ,
      ),
      body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text("Enter your E-mail for password reset !"),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
    ),
    hintText: 'Email',
    fillColor: Colors.grey[200],
    filled: true,
              )
            )
          ),
        const SizedBox(height: 10),
        MaterialButton(
          onPressed: passwordReset,
          color: Colors.grey[200],
          child: const Text('Reset Password'),
        )
        ]
      )
    );
  }
}
