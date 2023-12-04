import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/app_style.dart';
import 'package:weather_app/models/constants.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  Constants myContants = Constants();
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  String? user = FirebaseAuth.instance.currentUser?.email;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  @override
  void initState() {
    if (_titleController.text != "" && _mainController.text != "") {
      _titleController = TextEditingController();
      _mainController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: myContants.secondaryColor,
      elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Add a new Note", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Note Title',
            ),
            style: AppStyle.mainTitle,
          ),
          const SizedBox(height: 8.0,),
          TextField(
            controller: _mainController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Note Content',
            ),
            style: AppStyle.mainContent,
          ),
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async{
            FirebaseFirestore.instance.collection("notes").add({
            "note_title": _titleController.text,
            "Creation_Date": date,
            "note_content": _mainController.text,
            "color_id": color_id,
              "user": user,
          }).then((value) {
            Navigator.pop(context);
          // ignore: invalid_return_type_for_catch_error
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
