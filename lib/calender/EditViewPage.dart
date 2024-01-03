import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EventViewPage extends StatefulWidget {
  final List<dynamic>? event;
  List<dynamic> deletedEvents = [];

  EventViewPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  EventViewPageState createState() => EventViewPageState();
}

class EventViewPageState extends State<EventViewPage> {
  late TextEditingController fromController;
  late TextEditingController toController;
  late dynamic eventItem;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    eventItem = widget.event![selectedIndex];
    fromController = TextEditingController(text: eventItem.from.toString());
    toController = TextEditingController(text: eventItem.to.toString());
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  void deleteEvent() {
    setState(() {
      DocumentReference docRef = FirebaseFirestore.instance
          .collection("CalendarAppointmentCollection")
          .doc(eventItem.key);
      docRef.delete();
      widget.deletedEvents.add(eventItem);
      widget.event!.removeAt(selectedIndex);
    });
  }

  void saveChanges() {
    // Update the event object with the new values
    setState(() {
      eventItem.background = eventItem.background;
      eventItem.from = DateTime.parse(fromController.text);
      eventItem.to = DateTime.parse(toController.text);
    });

    // Update the event data in Firestore
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("CalendarAppointmentCollection")
        .doc(eventItem.key);
    docRef.update({
      'Subject': eventItem.eventName,
      'StartTime': DateFormat('dd/MM/yyyy HH:mm:ss').format(eventItem.from),
      'EndTime': DateFormat('dd/MM/yyyy HH:mm:ss').format(eventItem.to),
      // Add other fields you want to update
    }).then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Changes saved successfully.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to save changes: $error'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to delete this event?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
                deleteEvent(); // Gọi hàm xóa sự kiện
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit your task"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(32),
              itemCount: widget.event!.length,
              itemBuilder: (BuildContext context, int index) {
                eventItem = widget.event![index];
                final String background = eventItem.background.toString();
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(widget.event![index].eventName.toString()),
                        TextField(
                          controller:TextEditingController(text: background),
                          onChanged: (newBackground) {
                            // Update the event object with the new background
                            setState(() {
                              eventItem.background = Color(int.parse(newBackground));
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Background',
                          ),
                        ),
                        TextField(
                          controller: fromController,
                          decoration: InputDecoration(
                            labelText: 'From',
                            hintText: eventItem.from.toString(),
                          ),
                        ),
                        TextField(
                          controller: toController,
                          decoration: InputDecoration(
                            labelText: 'To',
                            hintText: eventItem.to.toString(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDeleteConfirmationDialog(context);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: saveChanges,
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}