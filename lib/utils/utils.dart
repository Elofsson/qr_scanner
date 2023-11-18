import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'globals.dart';

void showErrorSnackbarWithContext(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some action to take when the user presses the "OK" button
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorSnackbar(String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some action to take when the user presses the "OK" button
      },
    ),
  );

  snackbarKey.currentState?.showSnackBar(snackBar);
}

String getTimestamp() {
  String timeStamp;

  DateTime now = DateTime.now();
  int year = now.year;
  int month = now.month;
  int day = now.day;
  int hour = now.hour;
  int minute = now.minute;

  timeStamp = "$year-$month-$day $hour:$minute";
  return timeStamp;
}
