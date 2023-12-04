import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/calender/Note_Editor_Demo.dart';
import 'package:weather_app/calender/Note_Reader_Demo.dart';
import 'package:weather_app/calender/note_card_demo.dart';
import 'package:weather_app/models/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> notes = [];
  bool issort = false;
  Constants myContants = Constants();
  String? userMail = FirebaseAuth.instance.currentUser?.email.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: myContants.secondaryColor,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Notes",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                sortNotesByModifiedTime(notes);
              });
            },
            icon: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.sort,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Set children for Row
              children: [
                SizedBox(
                  width: 0,
                )
              ],
            ),
            TextField(
              onChanged: onSearchTextChanged,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search notes...",
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                fillColor: const Color(0xff90B2F8),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("notes")
                    .where("user", isEqualTo: userMail)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final note = snapshot.data!.docs[index];
                        return noteCard(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteReaderScreen(note),
                            ),
                          );
                        }, note, context);
                      },
                    );
                  }
                  return Text(
                    "There's no Notes",
                    style: GoogleFonts.nunito(color: Colors.black),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteEditorScreen()));
        },
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  List<String> sortNotesByModifiedTime(List<String> notes) {
    if (issort) {
      notes.sort((a, b) => a.toString().compareTo(b.toString()));
    } else {
      notes.sort((b, a) => a.toString().compareTo(b.toString()));
    }
    issort = !issort;
    return notes;
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      notes
          .where((note) =>
              note.toLowerCase().contains(searchText.toLowerCase()) ||
              note.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }
}
