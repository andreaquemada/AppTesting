import 'package:reafel_app/data/data_dtos.dart';
import 'package:reafel_app/models/events_model.dart';

class Backend {


  ///-----------------For LoginModel--------------------------
  bool authenticate(User user)
  {
    /// TODO - authenticate a user in the system
    return true;
  }

  bool logout(User user)
  {
    /// TODO - logout the user from the system
    return true;
  }

  ///---------------------------------------------------------
  ///
  ///-----------------For EventsModel--------------------------

  /*List<Event> getEvents() {
    Event event1 = Event();
    Event event2 = Event();
    Event event3 = Event();


    return [event1,event2,event3];
    /// TODO - get the list of events from CARP
  }

  Event getEvent(DateTime date) {
    return null;
  }

  void createEvent(Event event)
  {
    /// TODO -  Create an event
  }

  void updateEvent(Event event)
  {
    /// TODO -  Update an event
  }*/

  bool eventExists(int id)
  {
    /// TODO -  Check if an event exists
    return true;
  }

  ///---------------------------------------------------------






}