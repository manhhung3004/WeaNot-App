import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather_app/Note/notecard.dart';
import 'package:weather_app/Note/notereader.dart';
import 'package:weather_app/calender/events.dart';
import 'package:weather_app/models/constants.dart';
class Calender extends StatefulWidget {
  const Calender({super.key});
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  String? userMail = FirebaseAuth.instance.currentUser?.email;
  Constants myContants = Constants();
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusDay = DateTime.now();
  final TextEditingController _evenController = TextEditingController();
  String date = DateTime.now().toString();
  final bool check = false;

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _evenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constants myContants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myContants.primaryColor,
        title: const Text("Calender"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2030),
                    focusedDay: DateTime.now(),
                    weekendDays: const [6],
                    calendarFormat: format,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (DateTime selectDay, DateTime date) {
                      setState(() {
                        selectedDay = selectDay;
                        focusDay = focusDay;
                      });
                    },
                    onFormatChanged: (CalendarFormat format) {
                      setState(() {
                        format = format;
                      });
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    eventLoader: _getEventsfromDay,
                    headerStyle: HeaderStyle(
                        decoration: BoxDecoration(
                          color: myContants.primaryColor,
                        ),
                        headerMargin: const EdgeInsets.only(bottom: 8.0),
                        titleTextStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        formatButtonDecoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0)),
                        formatButtonTextStyle:
                            const TextStyle(color: Colors.white),
                        leftChevronIcon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        rightChevronIcon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        )),
                    calendarStyle:
                        const CalendarStyle(outsideDaysVisible: false),
                    calendarBuilders: const CalendarBuilders(),
                  ),
                  ..._getEventsfromDay(selectedDay).map((Event event) =>
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 20, right: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: size.height * .08,
                        width: size.width,
                        decoration: BoxDecoration(
                            border: event.checkEvent == true
                                ? Border.all(
                                    color: myContants.secondaryColor
                                        .withOpacity(0.6),
                                    width: 2,
                                  )
                                : Border.all(color: Colors.white),
                            color: event.checkEvent == true
                                ? myContants.primaryColor.withOpacity(0.5)
                                : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      myContants.primaryColor.withOpacity(.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                      event.checkEvent = !event.checkEvent;
                                  });
                                },
                                child: Image.asset(
                                  event.checkEvent == true
                                      ? 'assets/checked.png'
                                      : 'assets/unchecked.png',
                                  width: 30,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              event.title,
                              style: TextStyle(
                                fontSize: 16,
                                color: event.checkEvent == true
                                    ? Colors.black
                                    : Colors.black54,
                              ),
                            ),
                            Text(
                              DateFormat('HH:mm:ss').format(
                                  DateTime.parse(event.dateEvent.toString())),
                              style: TextStyle(
                                fontSize: 16,
                                color: event.checkEvent == true
                                    ? Colors.black
                                    : Colors.black54,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final result = await confirmDialog(context);
                                if (result != null && result) {}
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xff90B2F8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expanded(
                      //     child: StreamBuilder<QuerySnapshot>(
                      //         stream: FirebaseFirestore.instance
                      //             .collection("events")
                      //             .where("user", isEqualTo: userMail)
                      //             .snapshots(),
                      //         builder: (context,
                      //             AsyncSnapshot<QuerySnapshot> snapshot) {
                      //           if (snapshot.connectionState ==
                      //               ConnectionState.waiting) {
                      //             return const Center(
                      //               child: CircularProgressIndicator(),
                      //             );
                      //           }
                      //           print(
                      //               "tới đây rồiaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa233229999");
                      //           if (snapshot.hasData) {
                      //             return ListView.builder(
                      //               padding: const EdgeInsets.only(top: 0),
                      //               itemCount: snapshot.data!.docs.length,
                      //               itemBuilder: (context, index) {
                      //                 final note = snapshot.data!.docs[index];
                      //                 return cardcalender(() {
                      //                   Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                       builder: (context) =>
                      //                           NoteReaderScreen(note),
                      //                     ),
                      //                   );
                      //                 }, note, context);
                      //               },
                      //             );
                      //           }
                      //           return Text(
                      //             "There's no Notes",
                      //             style:
                      //                 GoogleFonts.nunito(color: Colors.black),
                      //           );
                      //         }))),
              )],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_alert),
          onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Add Event"),
                    content: TextFormField(
                      controller: _evenController,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            if (_evenController.text.isEmpty) {
                              Navigator.pop(context);
                              return;
                            } else {
                              if (selectedEvents[selectedDay] != null) {
                                selectedEvents[selectedDay]?.add(Event(
                                    title: _evenController.text,
                                    checkEvent: check,
                                    dateEvent: selectedDay,
                                    ));
                              } else {
                                selectedEvents[selectedDay] = [
                                  Event(
                                      title: _evenController.text,
                                      checkEvent: check,
                                      dateEvent: selectedDay,
                      )];
                              }
                            }
                            Navigator.pop(context);
                            _evenController.clear();
                          },
                          child: const Text("Ok")),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ],
                  ))),
    );
  }
}

Future<dynamic> confirmDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Are you sure you want to delete?'),
          content: const Text('Please confirm'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Yes')),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            )
          ],
        );
      });
}
