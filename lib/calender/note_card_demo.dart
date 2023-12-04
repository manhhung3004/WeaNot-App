import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'dart:math' as math;

Color generateRandomColor() {
  final random = math.Random();
  const int maxBrightness = 250; // Adjust this value for desired brightness

  int generateRandomRGBValue() {
    return random.nextInt(maxBrightness);
  }

  int r = generateRandomRGBValue();
  int g = generateRandomRGBValue();
  int b = generateRandomRGBValue();
  return Color.fromARGB(255, r, g, b);
}

Widget noteCard(
    Function()? onTap, QueryDocumentSnapshot doc, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
    child: Container(
      decoration: BoxDecoration(
          color: generateRandomColor(),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc["note_title"],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    DateFormat('MM/dd/yy HH:mm:ss')
                  .format(DateTime.parse(doc["Creation_Date"])),
                    style: const TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    doc["note_content"],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 96,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      shareNote(doc);
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Color(0xff90B2F8),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await confirmDialog(context);
                      if (result != null && result) {
                        deleteNote(doc);
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Color(0xff90B2F8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void deleteNote(QueryDocumentSnapshot doc) {
  doc.reference.delete();
}

void shareNote(QueryDocumentSnapshot doc) {
  String text = doc["note_title"];
  Share.share(text);
}

Future<dynamic> confirmDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Are you sure you want to delete?'),
          content: const Text('Please confirm'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Yes')),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            )
          ],
        );
      });
}
