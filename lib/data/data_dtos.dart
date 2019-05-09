import 'dart:ui';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

/*class Event {
  int id;
  String date;
  String time;
  String location;
  double duration;
  List<String> symptoms;
  String activity;
  String notes;
  bool completed;
}*/

class HRV {
  String date;
  double value;
}

class User {
  int idUser;
  String address;
  String name;
  String email;
  String password;
  DateTime dob;
  String weight;
  String height;
  String gender;
}

class Device {
  String name;
  String deviceName;
  bool enabled;
  String address;
  String sensorLocation;
  //bool batteryLevel;
  //ring bodyPosition;
}


class PersonalData{
  DateTime date;
  double measure;
  double radius;
  String type;

  PersonalData(this.date, this.measure, this.radius);
}

class Tutorial{
  List<IconData> iconList;
  List<String> titleList;
  List<String> descriptionList;
}
/*
abstract class MovisensDataPoint {
  DateTime _timeStamp;

  MovisensDataPoint() {
    /// Log timestamp of data point creation
    _timeStamp = DateTime.now();
  }

  DateTime get timeStamp => _timeStamp;
}

class MovisensMet extends MovisensDataPoint {
  double _met;

  MovisensMet(double value) {
    _met = value;
  }

  double get met => _met;
}

class MovisensHRV extends MovisensDataPoint {
  double _hrv;

  MovisensHRV(double value) {
    _hrv = value;
  }

  double get hrv => _hrv;
}

class MovisensHR extends MovisensDataPoint {
  double _hr;

  MovisensHR(double value) {
    _hr = value;
  }

  double get hr => _hr;
}*/




