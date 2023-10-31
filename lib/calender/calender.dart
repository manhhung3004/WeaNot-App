import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class Calender extends StatefulWidget {
  const Calender ({super.key});
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calender")),
      body: content(),
    );
  }
  Widget content(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text("Selected Day = ${today.toString().split("")[0]}"),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: const HeaderStyle(formatButtonVisible: false,titleCentered: true),
              availableGestures: AvailableGestures.all ,
              selectedDayPredicate: (day)=>isSameDay(day,today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          )
        ],
      ),
    );
  }
}
