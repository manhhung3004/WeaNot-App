// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Quitapp {
  get context => null;

void quitApp() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Do you want to exit the app?'),
            content: const Text('Please confirm'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
  _dismissDialog() {
    Navigator.pop(context as BuildContext);
  }
}
