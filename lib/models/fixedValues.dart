import 'package:flutter/material.dart';

class EventInfo {

  EventInfo._();

  static List<String> myEvents = [
    "Irregular sinus rhythm",
    "Sinus tachycardia",
    "Sinus bradycardia",
    "AFIB",
    "Atrial flutter",
    "Atrial pause",
    "Atrioventricular block 1",
    "Atrioventricular block 2",
    "Atrioventricular block 3",
    "Nodal rhythm",
    "Idioventricular rhythm",
    "Ventricular tachycardia",
    "Sinus rhythm with supraventricular run",
    "Sinus rhythm with ventricular run",
  ];

  static List<String> mySymptoms = [
    "Palpitation",
    "Dizziness",
    "Shortness of breath",
    "Chest pain",
    "Sweating",
    "Heart burn",
  ];


  static List<String> myActivities = [
    "Running",
    "Walking",
    "Cycling",
    "Commuting",
    "Climbing stairs",
    "Watching TV",
    "Bathing",
    "Reading",
    "Talking",
  ];

  static List<IconData> dayIcons = [
    //Following same row order as models/fixedValues
    Icons.brightness_6, // Morning
    Icons.brightness_5, // Afternoon
    Icons.brightness_4 // Other
  ];


  static var moodCols = <MaterialColor>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
  ];

}



