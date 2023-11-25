import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/calender/Note_Editor_Demo.dart';
import 'package:weather_app/calender/Note_Reader_Demo.dart';
import 'package:weather_app/calender/note_card_demo.dart';
import 'package:weather_app/models/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Your Notes"),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your recent Notes", style: GoogleFonts.roboto(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 22,),
          ),
          const SizedBox(height: 20.0,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("notes").where("user",isEqualTo:"hungphung842003@gmail.com").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                child: CircularProgressIndicator(),
                );
              }
              if(snapshot.hasData){
              return GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                children: snapshot.data!.docs.map((note)=>noteCard((){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReaderScreen(note),));
                    },note)).toList(),
              );
              }
              return Text("There's no Notes", style: GoogleFonts.nunito(color: Colors.white),);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:
          (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const NoteEditorScreen()));
          }, label: const Text("Add Note"),
      icon: const Icon(Icons.add),
      ),
    );
}
}
