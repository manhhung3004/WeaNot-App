import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/calender/meeting.dart';

class MeetingProvider extends ChangeNotifier {
  final TextEditingController _eventNameController = TextEditingController();
  List<Meeting> meeting = [];
  void addMeeting(BuildContext context) async {
    Future openDialog(BuildContext context) async {
      DateTime selectedStart = DateTime.now();
      DateTime selectedEnd = DateTime.now();
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            padding:const EdgeInsets.all(20),
            height: 220,
            child: Column(
              children: [
                TextField(
                  controller: _eventNameController,
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                  ),
                ),
                //Start time
                CupertinoButton(
                  child: Text(
                      '${selectedStart.hour}:${selectedStart.minute}'), // Hiển thị giờ và phút
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => SizedBox(
                        height: 250,
                        child: CupertinoDatePicker(
                          backgroundColor: Colors.white,
                          initialDateTime: selectedStart,
                          onDateTimeChanged: (DateTime newtime) {
                            selectedStart = newtime;
                          },
                          use24hFormat: true,
                          mode: CupertinoDatePickerMode
                          .dateAndTime, // Hiển thị cả ngày và giờ
                        ),
                      ),
                    );
                  },
                ),
                // End time
                CupertinoButton(
                  child: Text(
                      '${selectedEnd.hour}:${selectedEnd.minute}'), // Hiển thị giờ và phút
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => SizedBox(
                        height: 250,
                        child: CupertinoDatePicker(
                          backgroundColor: Colors.white,
                          initialDateTime: selectedEnd,
                          onDateTimeChanged: (DateTime newtime) {
                            selectedEnd = newtime;
                          },
                          use24hFormat: true,
                          mode: CupertinoDatePickerMode
                          .dateAndTime, // Hiển thị cả ngày và giờ
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add meeting logic here
                // ignore: avoid_print
                print(selectedStart);
                // ignore: avoid_print
                print(selectedEnd);
                meeting.add(
                  Meeting(
                    _eventNameController.text,
                    selectedStart,
                    selectedEnd,
                    const Color(0xFF0F8644),
                    false,
                  ),
                );
                notifyListeners();
                Navigator.pop(context, true); // Close dialog and return true
              },
              child: const Text('Add'),
            ),
          ],
        ),
      );
    }
    // Call the `openDialog` function
    await openDialog(context);
  }
  void editMeeting(int index) {
    meeting[index].eventName = 'Con $index $index';
    notifyListeners();
  }
}
