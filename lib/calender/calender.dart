import 'package:flutter/material.dart';
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
  // CalendarController calendarController;

  CalendarController calendarController = CalendarController();
  CalendarView calendarView = CalendarView.month;

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
                provider.addMeeting(context);
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
}
