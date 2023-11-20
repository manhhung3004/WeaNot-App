import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(backgroundColor: AppStyle.cardsColor[color_id],
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
          Text(date, style: AppStyle.dateTitle,),
          const SizedBox(height: 28.0,),

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
            "creation_title": date,
            "note_content": _mainController.text,
            "color_id": color_id
          }).then((value) {
            Navigator.pop(context);
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
