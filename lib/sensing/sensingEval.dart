import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_backend/carp_backend.dart';
import 'package:flutter/material.dart';
import 'package:movisens_flutter/movisens_flutter.dart';
import 'package:movisens_package/movisens.dart';
import 'package:path/path.dart';
import 'package:reafel_app/blocs/sensing_qualitycheck_bloc.dart';
import 'package:reafel_app/data/data_dtos.dart';
import 'package:reafel_app/models/user_model.dart';

class SensingEval {
  //final sensingQualityCheckBloc = SensingQualityCheckBloc();

  Study study;
  final String testStudyId = "10";


  StudyController controller;
  StudyManager studyExample = new StudyExample();

  SensingEval() : super() {
    // register data endpoints
    DataManagerRegistry.register(
        DataEndPointType.PRINT, new ConsoleDataManager());
    DataManagerRegistry.register(DataEndPointType.CARP, new CarpDataManager());

    SamplingPackageRegistry.register(MovisensSamplingPackage());
  }

  Future<void> start() async {
    // Create a study using a CARP Backend
    study = await studyExample.getStudy(testStudyId);
    print(study.toString());

    // Create a Study Controller that can manage this study, initialize it, and start it.
    controller = StudyController(study);
    await controller.initialize();
    controller.start();
    print("Sensing started ...");

    // listening on all data events from the study and print it (for debugging purpose).
    controller.events.forEach(print);
    controller.events
        /* .where((datum) => datum.runtimeType == MovisensConnectionStatusDatum)*/
        .listen(onData);

    print('PROBE REGISTRY:');
    ProbeRegistry.probes
        .forEach((key, probe) => print('  [$key] : ${probe.runtimeType}'));
  }

  ///Data and connection quality check

  onData(Datum datum) {
    print("Datum " + datum.toString());

    switch (datum.runtimeType) {
      case MovisensConnectionStatusDatum:
        {
          MovisensConnectionStatusDatum movisensConnectionStatusDatum =
              datum as MovisensConnectionStatusDatum;

          print("inside connection status check : " +
              movisensConnectionStatusDatum.connectionStatus);

          if (movisensConnectionStatusDatum.connectionStatus ==
              "sensor_connected") {
            sensingQualityCheckBloc.connectionStatus.add(true);

            //print("inside connection status check");
          } else if (movisensConnectionStatusDatum.connectionStatus ==
              "sensor_disconnected") {
            sensingQualityCheckBloc.connectionStatus.add(false);
          }
          break;
        }

      case MovisensTapMarkerDatum:
        {
          MovisensTapMarkerDatum movisensTapMarkerDatum =
              datum as MovisensTapMarkerDatum;
          print(
              'TapMarked send notification or reminder for filling  up the discription.' +
                  movisensTapMarkerDatum.movisensTimestamp);

          sensingQualityCheckBloc.tapMarkerStatus.add(true);

          break;
        }

        /* case MovisensBodyPositionDatum:
        {
          MovisensBodyPositionDatum movisensBodyPositionDatum =
            datum as MovisensBodyPositionDatum;

          if(movisensBodyPositionDatum.bodyPosition=="unknown" && movisensBodyPositionDatum.movisensTimestamp)

            // Do somthing

            print('body position is unknown please wear the device in right orientation');

            break;
          }
*/

        break;
    }
  }

  /// Stop sensing.
  void stop() async {
    controller.stop();
    study = null;
    print("Sensing stopped ...");
  }
}

Task _movisenTask;

Task get movisenTask {
  if (_movisenTask == null) {
    _movisenTask = Task("Movisens Task")
      ..addMeasure(MovisensMeasure(
          MeasureType(NameSpace.CARP, MovisensSamplingPackage.MOVISENS),
          name: "movisens",
          enabled: true,
          address: "",
          deviceName: "",
          height: 170,
          weight: 60));

    print(" movisens  init");
  }
  return _movisenTask;
}

class StudyExample implements StudyManager {
  final String username = "researcher@example.com";
  final String password = "password";
  final String uri = "http://staging.carp.cachet.dk:8080";
  final String clientID = "carp";
  final String clientSecret = "carp";
  String studyId;
  Study _study;

  final UserModel user = new UserModel(User());

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    return null;
  }

  @override
  Future<Study> getStudy(String studyId) async {
    if (_study == null) {
      _study = Study(studyId, username)
        ..name = 'REAFEL Test Study'
        ..description =
            'This is a long description of a Study which can run forever and take up a lot of space and drain you battery and you have to agree to an informed consent which - by all standards - do not comply to any legal framework....'
        ..dataEndPoint = getDataEndpoint(DataEndPointType.PRINT)

        // add sensor collection from pedometer, location, activity, weather, screen and bluetooth

        ..addTask(Task("Movisens Task")
          ..addMeasure(MovisensMeasure(
              MeasureType(NameSpace.CARP, MovisensSamplingPackage.MOVISENS),
              name: "movisens",
              enabled: true,
              address: "88:6B:0F:CD:E7:F2",
              deviceName: "Movisens ECG",
              height: int.parse(user.height),
              weight: int.parse(user.weight),
              age: 25,
              gender: Gender.female,
              sensorLocation: SensorLocation.chest)));

      /*..addTask(Task('Sensor Task')
          ..addMeasure(
              PeriodicMeasure(MeasureType(NameSpace.CARP, DataType.PEDOMETER),
                  frequency: 600 * 1000, // sample every 10 min)
                  duration: 100 // for 100 ms
                  ))
          ..addMeasure(
              PeriodicMeasure(MeasureType(NameSpace.CARP, DataType.LOCATION),
                  frequency: 60 * 1000, // sample every 60 secs
                  duration: 100 // for 100 ms
                  ))
          ..addMeasure(
              PeriodicMeasure(MeasureType(NameSpace.CARP, DataType.ACTIVITY),
                  frequency: 300 * 1000, // sample every 5 min
                  duration: 100 // for 100 ms
                  ))
          ..addMeasure(
              PeriodicMeasure(MeasureType(NameSpace.CARP, DataType.WEATHER),
                  frequency: 3600 * 1000, // sample every 1 hour
                  duration: 100 // for 100 ms
                  ))
          ..addMeasure(
              PeriodicMeasure(MeasureType(NameSpace.CARP, DataType.SCREEN),
                  frequency: 30 * 1000, // sample every 30 secs
                  duration: 100 // for 100 ms
                  ))
          ..addMeasure(
              PeriodicMeasure(MeasureType(NameSpace.CARP, DataType.BLUETOOTH),
                  frequency: 30 * 1000, // sample every 30 secs
                  duration: 100 // for 100 ms
                  )));*/

      //_study.addTask(_movisenTask);
    }
    return _study;
  }

  DataEndPoint getDataEndpoint(String fileType) {
    assert(fileType != null);
    switch (fileType) {
      case DataEndPointType.PRINT:
        return new DataEndPoint(DataEndPointType.PRINT);
      case DataEndPointType.FILE:
        return FileDataEndPoint(
            bufferSize: 500 * 1000, zip: true, encrypt: false);
      case DataEndPointType.CARP:
        return CarpDataEndPoint(CarpUploadMethod.DATA_POINT,
            name: 'CARP Staging Server',
            uri: uri,
            clientId: clientID,
            clientSecret: clientSecret,
            email: username,
            password: password);

      default:
        return new DataEndPoint(DataEndPointType.PRINT);
    }
  }
}
