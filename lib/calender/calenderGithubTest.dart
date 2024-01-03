import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class LoadDataFromFireStore extends StatefulWidget {
  const LoadDataFromFireStore({super.key});
  @override
  State<LoadDataFromFireStore> createState() => _LoadDataFromFireStoreState();
}

class _LoadDataFromFireStoreState extends State<LoadDataFromFireStore> {
  CalendarView calendarView = CalendarView.month;
  CalendarController calendarController = CalendarController();
  final TextEditingController _eventNameController = TextEditingController();
  final List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  final List<String> options = <String>['Add', 'Delete', 'Update'];
  final fireStoreReference = FirebaseFirestore.instance;
  bool isInitialLoaded = false;

  Future addtask(BuildContext context) async {
    DateTime selectedStart = DateTime.now();
    DateTime selectedEnd = DateTime.now();
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(20),
          height: 210,
          child: Column(
            children: [
              TextField(
                controller: _eventNameController,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                ),
                // style: heigt,
              ),
              // Start time
              CupertinoButton(
                child: Text('${selectedStart.hour}:${selectedStart.minute}'),
                onPressed: () async {
                  // Sử dụng await cho showCupertinoModalPopup
                  final newTime = await showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.white,
                        initialDateTime: selectedStart,
                        onDateTimeChanged: (DateTime newDateTime) {
                          selectedStart = newDateTime;
                        },
                        use24hFormat: true,
                        mode: CupertinoDatePickerMode.dateAndTime,
                      ),
                    ),
                  );
                  if (newTime != null) {
                    selectedStart = newTime;
                  }
                },
              ),
              // End time
              CupertinoButton(
                child: Text('${selectedEnd.hour}:${selectedEnd.minute}'),
                onPressed: () async {
                  // Sử dụng await cho showCupertinoModalPopup
                  final newTime = await showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.white,
                        initialDateTime: selectedEnd,
                        onDateTimeChanged: (DateTime newDateTime) {
                          selectedEnd = newDateTime;
                        },
                        use24hFormat: true,
                        mode: CupertinoDatePickerMode.dateAndTime,
                      ),
                    ),
                  );
                  if (newTime != null) {
                    selectedEnd = newTime;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // DateFormat('dd/MM/yyyy HH:mm:ss').parse(selectedEnd.toString());
              // DateFormat('dd/MM/yyyy HH:mm:ss').parse(selectedStart.toString());
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
                'StartTime':
                    formattedDateStart, // Sử dụng selectedStart trực tiếp
                'EndTime': formattedDateEnd, // Sử dụng selectedEnd trực tiếp
              });
              Navigator.pop(context, false);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

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
            events!.appointments!.add(app);
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
          icon: const Icon(Icons.settings),
          itemBuilder: (BuildContext context) => options.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList(),
          onSelected: (String value) {
            if (value == 'Add') {
              addtask(context);
            } else if (value == "Delete") {
              try {
                fireStoreReference
                    .collection('CalendarAppointmentCollection')
                    .doc('')
                    .delete();
              } catch (e) {}
            } else if (value == "Update") {
              try {
                fireStoreReference
                    .collection('CalendarAppointmentCollection')
                    .doc('1')
                    .update({'Subject': 'Meeting'});
              } catch (e) {}
            }
          },
        )),
        body: Column(
          children: [
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        calendarView = CalendarView.month;
                        calendarController.view = calendarView;
                      });
                    },
                    child: const Text("Month View")),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        calendarView = CalendarView.week;
                        calendarController.view = calendarView;
                      });
                    },
                    child: const Text("Week View")),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        calendarView = CalendarView.day;
                        calendarController.view = calendarView;
                      });
                    },
                    child: const Text("Day View")),
              ],
            ),
            Expanded(
              child: SfCalendar(
                view: CalendarView.month,
                controller: calendarController,
                initialDisplayDate: DateTime.now(),
                dataSource: events,
                monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  showAgenda: true,
                ),
                blackoutDates: [
                  DateTime.now().subtract(const Duration(hours: 48)),
                  DateTime.now().subtract(const Duration(hours: 24)),
                ],
              ),
            ),
          ],
        ));
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

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  String? key;

  Meeting(
      {this.eventName,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.key});

  static Meeting fromFireBaseSnapShotData(dynamic element, Color color) {
    return Meeting(
        eventName: element.doc.data()!['Subject'],
        from: DateFormat('dd/MM/yyyy HH:mm:ss')
            .parse(element.doc.data()!['StartTime']),
        to: DateFormat('dd/MM/yyyy HH:mm:ss')
            .parse(element.doc.data()!['EndTime']),
        background: color,
        isAllDay: false,
        key: element.doc.id);
  }
}
