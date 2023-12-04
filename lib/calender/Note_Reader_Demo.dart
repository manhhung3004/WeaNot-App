import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/constants.dart';

// ignore: must_be_immutable
class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  Constants myContants = Constants();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  String date = DateTime.now().toString();
  @override
  void initState() {
    super.initState();
    if (widget.doc["note_title"] != "" && widget.doc["note_content"] != "") {
      _titleController =
          TextEditingController(text: widget.doc["note_title"]!.toString());
      _contentController =
          TextEditingController(text: widget.doc["note_content"]!.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: myContants.secondaryColor,
        elevation: 0.1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 28.0,
            ),
            Text(
              DateFormat('MM/dd/yy HH:mm:ss')
                  .format(DateTime.parse(widget.doc["Creation_Date"])),
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
            TextField(
              controller: _contentController,
              style: const TextStyle(
                color: Colors.black87,
              ),
              maxLines: null,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type something here',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 130, 130, 130),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        FirebaseFirestore.instance.collection("notes").doc(widget.doc.id).update({
            "note_title": _titleController.text,
            "creation_title": date,
            "note_content": _contentController.text,
          }).then((value) {
            Navigator.pop(context);
          });
        },
        elevation: 0,
        backgroundColor: const Color(0xff90B2F8),
        child: const Icon(Icons.save),
      ),
    );
  }
}

