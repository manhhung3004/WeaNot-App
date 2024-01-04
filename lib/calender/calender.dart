// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_element

import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/calender/editViewPage.dart';
import 'package:weather_app/models/MeetingDataSource.dart';
import 'package:weather_app/models/Meetings.dart';

class LoadDataFromFireStore extends StatefulWidget {
  const LoadDataFromFireStore({super.key});
  @override
  State<LoadDataFromFireStore> createState() => _LoadDataFromFireStoreState();
}

class _LoadDataFromFireStoreState extends State<LoadDataFromFireStore> {
  String? userMail = FirebaseAuth.instance.currentUser?.email.toString();
  final fireStoreReference = FirebaseFirestore.instance;
  int _tapCount = 0;
  CalendarView calendarView = CalendarView.month;
  CalendarController calendarController = CalendarController();
  final List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  final List<String> options = <String>['Add'];
  bool isInitialLoaded = false;

  @override
  void initState() {
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    fireStoreReference
        .collection("CalendarAppointmentCollection")
        .snapshots()
        .listen((event) {
      for (var element in event.docChanges) {
        if (element.type == DocumentChangeType.added) {
          if (!isInitialLoaded) {
            continue;
          }
          final Random random = Random();
          Meeting app = Meeting.fromFireBaseSnapShotData(
              element, _colorCollection[random.nextInt(9)]);
          setState(() {
            events!.appointments?.add(app);
            events!.notifyListeners(CalendarDataSourceAction.add, [app]);
          });
        } else if (element.type == DocumentChangeType.modified) {
          if (!isInitialLoaded) {
            continue;
          }
          final Random random = Random();
          Meeting app = Meeting.fromFireBaseSnapShotData(
              element, _colorCollection[random.nextInt(9)]);
          setState(() {
            int index = events!.appointments!
                .indexWhere((app) => app.key == element.doc.id);
            Meeting meeting = events!.appointments![index];
            events!.appointments!.remove(meeting);
            events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
            events!.appointments!.add(app);
            events!.notifyListeners(CalendarDataSourceAction.add, [app]);
          });
        } else if (element.type == DocumentChangeType.removed) {
          if (!isInitialLoaded) {
            continue;
          }
          setState(() {
            int index = events!.appointments!
                .indexWhere((app) => app.key == element.doc.id);
            Meeting meeting = events!.appointments![index];
            events!.appointments!.remove(meeting);
            events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
          });
        }
      }
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await fireStoreReference
        .collection("CalendarAppointmentCollection")
        .where("user", isEqualTo: userMail)
        .get();
    final Random random = Random();
    List<Meeting> list = snapShotsValue.docs
        .map((e) => Meeting(
            eventName: e.data()['Subject'],
            from:
                DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
            to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
            background: _colorCollection[random.nextInt(9)],
            isAllDay: false,
            key: e.id))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    isInitialLoaded = true;
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.add),
          itemBuilder: (BuildContext context) => options.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList(),
          onSelected: (String value) {
            if (value == 'Add') {
              addTask(context);
            }
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      calendarView = CalendarView.month;
                      calendarController.view = calendarView;
                    });
                  },
                  child: const Text("Month View"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      calendarView = CalendarView.week;
                      calendarController.view = calendarView;
                    });
                  },
                  child: const Text("Week View"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      calendarView = CalendarView.day;
                      calendarController.view = calendarView;
                    });
                  },
                  child: const Text("Day View"),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              controller: calendarController,
              initialDisplayDate: DateTime.now(),
              selectionDecoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 133, 166, 194)),
                borderRadius: BorderRadius.circular(4),
                shape: BoxShape.rectangle,
              ),
              dataSource: events,
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true,
              ),
              blackoutDates: [
                DateTime.now().subtract(const Duration(hours: 48)),
                DateTime.now().subtract(const Duration(hours: 24)),
              ],
              appointmentBuilder: appointmentBuilder,
              onTap: (details) {
                setState(() {
                  _tapCount++;
                  if (_tapCount == 2) {
                    if (details.appointments == null) return;
                    final event = details.appointments!;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventViewPage(event: event),
                    ));
                    _tapCount = 0;
                  } else {
                    Timer(const Duration(milliseconds: 150),
                        () => setState(() => _tapCount = 0));
                  }
                });
              },
              backgroundColor: Colors.white,
              cellBorderColor: Colors.grey,
              todayHighlightColor: Colors.blue,
              headerStyle: const CalendarHeaderStyle(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appointmentBuilder(BuildContext context,CalendarAppointmentDetails details,)
  {
    final event = details.appointments.first;
    final random = Random();
    final color = _colorCollection[random.nextInt(_colorCollection.length)];
    return Container(
      padding: const EdgeInsets.all(5),
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              event.eventName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            event.from.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            event.to.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

List<Color> _colorCollection = [
  const Color(0xFF0F8644),
  const Color(0xFF8B1FA9),
  const Color(0xFFD20100),
  const Color(0xFFFC571D),
  const Color(0xFF36B37B),
  const Color(0xFF01A1EF),
  const Color(0xFF3D4FB5),
  const Color(0xFFE47C73),
  const Color(0xFF636363),
  const Color(0xFF0A8043),
];

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String? userMail = FirebaseAuth.instance.currentUser?.email.toString();
  final fireStoreReference = FirebaseFirestore.instance;
  DateTime selectedStart = DateTime.now();
  DateTime selectedEnd = DateTime.now();
  TextEditingController _eventNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                'Task Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _eventNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter task name',
                ),
              ),
              const Text(
                'Start Time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoButton(
                child: Text(
                  '${selectedStart.day}/${selectedStart.month}/${selectedStart.year} - ${selectedStart.hour}:${selectedStart.minute}:${selectedStart.second}',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () async {
                  final newTime = await showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.white,
                        initialDateTime: selectedStart,
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState(() {
                            selectedStart = newDateTime;
                          });
                        },
                        use24hFormat: true,
                        mode: CupertinoDatePickerMode.dateAndTime,
                      ),
                    ),
                  );
                  if (newTime != null) {
                    setState(() {
                      selectedStart = newTime;
                    });
                  }
                },
              ),
              const Text(
                'End Time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoButton(
                child: Text(
                  '${selectedEnd.day}/${selectedEnd.month}/${selectedEnd.year} - ${selectedEnd.hour}:${selectedEnd.minute}:${selectedEnd.second}',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () async {
                  final newTime = await showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.white,
                        initialDateTime: selectedEnd,
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState(() {
                            selectedEnd = newDateTime;
                          });
                        },
                        use24hFormat: true,
                        mode: CupertinoDatePickerMode.dateAndTime,
                      ),
                    ),
                  );
                  if (newTime != null) {
                    setState(() {
                      selectedEnd = newTime;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
            String formattedDateEnd =
                formatter.format(DateTime.parse(selectedEnd.toString()));
            String formattedDateStart =
                formatter.format(DateTime.parse(selectedStart.toString()));
            await fireStoreReference
                .collection("CalendarAppointmentCollection")
                .doc()
                .set({
              'Subject': _eventNameController.text,
              'StartTime': formattedDateStart,
              'EndTime': formattedDateEnd,
              'user': userMail,
            });
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

Future addTask(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AddTaskDialog(),
  );
}
