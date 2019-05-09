import 'dart:async';
import 'dart:core';

import 'package:reafel_app/data/backend.dart';
import 'package:reafel_app/data/data_dtos.dart';
import 'package:reafel_app/data/localDB.dart';
import 'package:reafel_app/models/data_model.dart';
import 'package:reafel_app/models/eventDB_model.dart';
import 'package:reafel_app/models/events_model.dart';
import 'package:reafel_app/models/movisens_tutorial_model.dart';
import 'package:reafel_app/models/user_model.dart';
import 'package:reafel_app/sensing/sensingEval.dart';

class ReafelBloc {


  Backend backend = Backend();

  ReafelBloc()
  {
    getEvents();
  }

  ///-----------------For UserModel--------------------------
  ///
  bool authenticate(User user) {
    return backend.authenticate(user);
  }

  bool logout(User user) {
    return backend.logout(user);
  }

  void sendUserDataToCarp(UserModel user)
  {
    /// TODO -- Data (like: id, gender, dob, height, weight and name) needs to be stored in CARP
  }


  ///---------------------------------------------------------
  ///
  ///
  ///
  ///
  /// -------------------PairingModel-------------------------
  ///
  void startPairing() {

  }

  ///
  ///
  ///
  ///-----------------For EventsModel--------------------------

  List<EventModel> receiveAllEvents() {
    return [EventModel(Event()), EventModel(Event()), EventModel(Event())];
  }


  List<DataModel> receiveEventDay(/*DateTime date*/) {

    ///TODO - The type of this list needs to be modified to List<EventModel>, now is List<DataModel> for prototyping purposes
    return [DataModel(PersonalData(DateTime(2019, 2, 25, 2, 0), 0.5, 1.0)),DataModel(PersonalData(DateTime(2019, 2, 25, 3, 0), 0.5, 1.0)),DataModel(PersonalData(DateTime(2019, 2, 25, 5, 0), 0.5, 1.0)),];
  }


  EventModel receiveLastEvent() {
    return EventModel(Event());
  }


  void sendEvent(Event event) {
    //backend.setEvent(event.toEvent());
    //if (backend.eventExists(event.id))
     // backend.updateEvent(event);
    //else
      //backend.createEvent(event);
  }


  final _eventController = StreamController<List<Event>>.broadcast();
  get events => _eventController.stream;

  dispose() {
    _eventController.close();
  }


  getEvents() async {
    _eventController.sink.add(await DBProvider.db.getAllEvents());
  }

  add(Event event) {
    DBProvider.db.newEvent(event);
    getEvents();
  }
///-------------------------------------------------------------


///---------------------For DataModel --------------------------
///
 List<DataModel> receiveDataList(String type){
    //TODO - This function will receive a list of DataModels of HRV, HR or MET (depending on the type sent)
   if(type == 'hrv')
      return [DataModel(PersonalData(DateTime(2019, 2, 25, 0, 0), 0.75, 10.0)),DataModel(PersonalData(DateTime(2019, 2, 25, 3, 0), 0.95, 10.0)),DataModel(PersonalData(DateTime(2019, 2, 25, 6, 0), 0.85, 10.0)),];
   else if(type =='hr')
     return [DataModel(PersonalData(DateTime(2019, 2, 25, 0, 0), 0.25, 10.0)),DataModel(PersonalData(DateTime(2019, 2, 25, 3, 0), 0.45, 10.0)),DataModel(PersonalData(DateTime(2019, 2, 25, 6, 0), 0.15, 10.0)),];
   else
     return [DataModel(PersonalData(DateTime(2019, 2, 25, 0, 0), 0.35, 10.0)),DataModel(PersonalData(DateTime(2019, 2, 25, 3, 0), 0.25, 10.0)),DataModel(PersonalData(DateTime(2019, 2, 25, 6, 0), 0.65, 10.0)),];
 }


  DataModel receiveData(DateTime date, String type) {
    //TODO - This function will receive a DataModel of HRV, HR or MET (depending on the type sent and dateTime)
    return DataModel(PersonalData(DateTime(2019, 2, 25, 0, 0), 0.75, 10.0));
  }

///-------------------------------------------------------------

///
  ///---------------------For DeviceModel --------------------------


  ///
  bool deviceConnected()
  {
    ///TODO - Receive the status of the device (connected = true or disconnected = false)
    /// THIS SHOULD BE A STREAM
    return false;
  }

  /// Returns a tutorial for the specified device type in the correct language specified by the localization file
  MovisensTutorialModel receiveTutorial(/*String deviceType, String languageCode*/)
  {
    return MovisensTutorialModel(Tutorial());
  }
}

final reafelBloc = ReafelBloc();