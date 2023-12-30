import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather_app/calender/events.dart';
import 'package:weather_app/models/constants.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});
  @override
  State<Calender> createState() => _CalenderState();
}

Container taskList(
    String title, String desscription, IconData iconImg, Color iconColor) {
  return Container(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        Icon(
          iconImg,
          color: const Color(0xff00cf8d),
          size: 30,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                desscription,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
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

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                child: Text(
              "Today ${DateFormat('dd/MM/yyyy').format(today)}",
            )),
            Container(
              // height: MediaQuery.of(context).size.height * 0.30,
              padding: const EdgeInsets.only(bottom: 0),
              child: TableCalendar(
                locale: "en_US",
                rowHeight: 43,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                onDaySelected: _onDaySelected,
              ),
            ),
            // Task list
            Container(
              padding: const EdgeInsets.only(left: 30),
              width: MediaQuery.of(context ).size.width,
              height: MediaQuery.of(context ).size.height * 0.37,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: const Color.fromARGB(255, 0, 135, 245).withOpacity(0.76),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          "Today",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      taskList("Task 1", "Desscription", CupertinoIcons.check_mark_circled_solid,const Color(0xff00cf8c)),
                      taskList("Task 2", "Desscription", CupertinoIcons.checkmark_circle_fill, const  Color.fromARGB(255, 83, 207, 0)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
