import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

=======
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather_app/Note/notecard.dart';
import 'package:weather_app/Note/notereader.dart';
import 'package:weather_app/calender/add_task_bar.dart';
import 'package:weather_app/calender/events.dart';
import 'package:weather_app/models/constants.dart';
>>>>>>> Stashed changes
class Calender extends StatefulWidget {
  const Calender({super.key});
  @override
  State<Calender> createState() => _CalenderState();
}
<<<<<<< Updated upstream

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
  @override
  void initState() {
    super.initState();
  }

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
=======
class _CalenderState extends State<Calender> {
  late DateTime initialSelectedDay;
  String? userMail = FirebaseAuth.instance.currentUser?.email;
  Constants myContants = Constants();
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final TextEditingController _evenController = TextEditingController();
  String date = DateTime.now().toString();
  final bool check = false;

  final CollectionReference eventsCollection =
  FirebaseFirestore.instance.collection('events');


  void _deleteEvent(Event event) {
    setState(() {
      selectedEvents[selectedDay]?.remove(event);
    });
  }
  @override
  void initState() {
    selectedEvents = {};
    initialSelectedDay = DateTime.now(); //
    _loadEventsFromFirebase();
    super.initState();
  }
  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }
  Future<void> _loadEventsFromFirebase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userMail = user.email;
        if (userMail != null) {
          final snapshot = await eventsCollection
              .doc(userMail)
              .collection('events')
              .get();

          final events = snapshot.docs.map((doc) {
            final eventData = doc.data();
            return Event(
              title: eventData['title'],
              dateEvent: eventData['dateEvent'].toDate(),
              checkEvent: eventData['checkEvent'],
            );
          }).toList();

          for (final event in events) {
            selectedEvents[event.dateEvent] ??= [];
            selectedEvents[event.dateEvent]?.add(event);
          }
        }
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error loading events from Firestore: $e');
    }
  }
  Future<void> _addEventToFirebase(Event event) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userMail = user.email;
        if (userMail != null) {
          await eventsCollection.doc(userMail).collection('events').add({
            'title': event.title,
            'dateEvent': event.dateEvent,
            'checkEvent': event.checkEvent,
          });
        }
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error adding event to Firestore: $e');
    }
  }


  Future<bool?> confirmDialog(BuildContext context, Event event) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete?'),
          content: const Text('Please confirm'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _deleteEvent(event); // Thêm dòng này để xóa sự kiện
                Navigator.pop(context, true);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
    });
  }


  @override
  void dispose() {
    _evenController.dispose();
    super.dispose();
>>>>>>> Stashed changes
  }
  @override
  Widget build(BuildContext context) {
    // Constants myContants = Constants();
    // Get the screen size
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Calender"),
      ),
      body: content(),
    );
  }

  Widget content() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
<<<<<<< Updated upstream
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
=======
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
                    onDaySelected: onDaySelected,
                    onFormatChanged: (CalendarFormat format) {
                      setState(() {
                        this.format = format;
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
                                final result = await confirmDialog(context, event);
                                if (result != null && result) {
                                  _deleteEvent(event);
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xff90B2F8),
                              ),
                            ),
                          ],
                        ),
                      ),
                   //    Expanded(
                   //        child: StreamBuilder<QuerySnapshot>(
                   //            stream: FirebaseFirestore.instance
                   //               .collection("events")
                   //             .where("user", isEqualTo: userMail)
                  //                .snapshots(),
                  //          builder: (context,
                  //                 AsyncSnapshot<QuerySnapshot> snapshot) {
                  //              if (snapshot.connectionState ==
                    //                ConnectionState.waiting) {
                    //               return const Center(
                   //                 child: CircularProgressIndicator(),
                       //          );
                       //         }
                       //         if (snapshot.hasData) {
  //  List<Event> snapData = snapshot.data;

  //  }})),
              )],
>>>>>>> Stashed changes
              ),
            )
          ],
        ),
      ),
<<<<<<< Updated upstream
=======
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_alert),
          onPressed: () => Get.to(const AddTaskPage()))
          //showDialog(
         //     context: context,
          //    builder: (context) => AlertDialog(
                   // title: const Text("Add Event"),
            //        content: TextFormField(
                    //  controller: _evenController,
                  //  ),
                  //  actions: [
                   //   TextButton(
                    //      onPressed: () async {
                          //  if (_evenController.text.isEmpty) {
                           //   Navigator.pop(context);
                         //     return;
                       //     } else {
                        //      final newEvent = Event(
                        //        title: _evenController.text,
                         //       dateEvent: initialSelectedDay,
                         //       checkEvent: check,
                        //      );
                         //     await _addEventToFirebase(newEvent);
                         //     if (selectedEvents[selectedDay] != null) {
                         //       selectedEvents[selectedDay]?.add(newEvent);
                          //    } else {
                          //      selectedEvents[selectedDay] = [newEvent];
                         //     }
                          //  }
                          //  Navigator.pop(context);
                          //  _evenController.clear();
                       //   },
                      //    child: const Text("Ok")),
                   //   TextButton(
                  //      onPressed: () => Navigator.pop(context),
                   //     child: const Text("Cancel"),
                   //   ),
                  //  ],
              //    )
   // )
    //),
>>>>>>> Stashed changes
    );

  }

}
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
