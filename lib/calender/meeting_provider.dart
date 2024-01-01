import 'package:flutter/cupertino.dart';
import 'package:weather_app/calender/meeting.dart';

class MeetingProvider extends ChangeNotifier{

  List<Meeting> meeting = [
    Meeting( "Conference 1", DateTime.now(), DateTime.now().add(const Duration(hours: 2)), const Color(0xFF0F8644), false),
    Meeting( "Conference 2", DateTime.now(), DateTime.now().add(const Duration(hours: 2)), const Color(0xFF0F8644), false),
    Meeting( "Conference 3", DateTime.now(), DateTime.now().add(const Duration(hours: 2)), const Color(0xFF0F8644), false),
  ];
  void addMeeting(){
    meeting.add(
      Meeting( "Conference 4", DateTime.now(), DateTime.now().add(const Duration(hours: 2)), const Color(0xFF0F8644), false),
    );
    notifyListeners();
  }
  void editMeeting(int index){
      meeting[index].eventName = 'Con $index $index';
      notifyListeners();
  }
}