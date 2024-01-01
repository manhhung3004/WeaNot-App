import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:weather_app/calender/meeting.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
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

  // @override
  // String getStartTimeZone(int index) {
  //   return appointments![index].startTimeZone;
  // }

  // @override
  // String getEndTimeZone(int index) {
  //   return appointments![index].endTimeZone;
  // }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}