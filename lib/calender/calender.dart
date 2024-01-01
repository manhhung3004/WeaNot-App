import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:weather_app/calender/meeting_data_source.dart';
import 'package:weather_app/calender/meeting_provider.dart';
import 'package:weather_app/models/constants.dart';

// ignore: must_be_immutable
class Calender extends StatefulWidget {
  const Calender({super.key});
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  late CalendarController calendarController;
  String _text = '';
  CalendarView calendarView = CalendarView.month;
  @override
  // void initState() {
  //   super.initState();
  //   CalendarController calendarController = CalendarController();
  //   String _text = '';
  //   CalendarView calendarView = CalendarView.month;
  // }
  @override
  Widget build(BuildContext context) {
    Constants myContants = Constants();
    final provider = Provider.of<MeetingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myContants.primaryColor,
        title: const Text("Calendar"),
        actions: [
          IconButton(
              onPressed: () {
                provider.addMeeting();
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                provider.editMeeting(2);
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
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
              view: calendarView,
              controller: calendarController,
              initialSelectedDate: DateTime.now(),
              onSelectionChanged: selectionChanged,
              cellBorderColor: Colors.transparent,
              dataSource: MeetingDataSource(provider.meeting),
              monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  showAgenda: true),
              blackoutDates: [
                DateTime.now().subtract(const Duration(hours: 48)),
                DateTime.now().subtract(const Duration(hours: 24)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void selectionChanged(CalendarSelectionDetails details) {
    if (calendarController.view == CalendarView.month ||
        calendarController.view == CalendarView.timelineMonth) {
      _text = DateFormat('dd, MMMM yyyy').format(details.date!).toString();

    } else {
      _text =
          DateFormat('dd, MMMM yyyy hh:mm a').format(details.date!).toString();
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // ignore: avoid_unnecessary_containers
            title: Container(
                child:
                    const Text("Details shown by selection changed callback")),
            content:
                // ignore: avoid_unnecessary_containers
                Container(child: Text("You have selected " '$_text')),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('close'))
            ],
          );
        });
  }
}
