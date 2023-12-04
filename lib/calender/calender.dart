import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather_app/calender/events.dart';
import 'package:weather_app/models/constants.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  Constants myContants = Constants();
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusDay = DateTime.now();

  final TextEditingController _evenController = TextEditingController();

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
                        formatButtonTextStyle: const TextStyle(color: Colors.white),
                        leftChevronIcon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        rightChevronIcon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        )),
                    calendarStyle: const CalendarStyle(outsideDaysVisible: false),
                    calendarBuilders: const CalendarBuilders(),
                  ),
                  ... _getEventsfromDay(selectedDay).map((Event event) => ListTile(title: Text(event.title),))
                ],
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
                          onPressed: () {
                            if (_evenController.text.isEmpty) {
                              Navigator.pop(context);
                              return;
                            } else {
                              if (selectedEvents[selectedDay] != null) {
                                selectedEvents[selectedDay]
                                    ?.add(Event(title: _evenController.text));
                              } else {
                                selectedEvents[selectedDay] = [
                                  Event(title: _evenController.text)
                                ];
                              }
                            }
                            Navigator.pop(context);
                              _evenController.clear();
                              setState(() {
                              });
                              return;
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
