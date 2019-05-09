import 'package:flutter/material.dart';
import 'package:reafel_app/data/data_dtos.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DataListModel {
  List<DataModel> _movisensData = [];
  List<DataModel> get movisensData => _movisensData;
}

class DataModel {
  PersonalData movisensDataPoint;
  //MovisensHRV movisensHRV;

  /*DateTime get timeOfToday => DateTime.parse("2019-02-20 00:00:00Z");
  List<MovisensDataPoint> get hrv => [movisensDataPoint];
  double get met => 20.0;
  double get hr => 20.0;*/
  ///Which dateTime did the event occurred.
  DateTime get dateTime => movisensDataPoint.date;

  ///Measure from device at a certain dateTime.
  double get measure => movisensDataPoint.measure;

  ///Importance of measure from device at a certain dateTime.
  double get radius => 10.0;

    ///Type of measure
    String get type => 'hrv';

    ///Type of measure
    void set type(String type) {
      movisensDataPoint.type = type;
    }


    PersonalData toDataModel() => movisensDataPoint;
/*
    List<MovisensHRV> get hrvs => [
      MovisensHRV(20.0),
      MovisensHRV(23.0),
      MovisensHRV(25.0),
      MovisensHRV(17.0)
    ];
    List<MovisensMet> get mets => [
      MovisensMet(17.0),
      MovisensMet(20.0),
      MovisensMet(23.0),
      MovisensMet(25.0)
    ];
    List<MovisensHR> get hrs =>
    [MovisensHR(25.0), MovisensHR(17.0), MovisensHR(20.0), MovisensHR(23.0)];
    List<DateTime> get times => [
      DateTime.parse("2019-02-20 00:00:00Z"),
      DateTime.parse("2019-02-20 03:00:00Z"),
      DateTime.parse("2019-02-20 06:00:00Z"),
      DateTime.parse("2019-02-20 09:00:00Z")
    ];*/

    DataModel(this.movisensDataPoint)
      : assert(movisensDataPoint != null, 'A DataModel.'),
        super();
}
