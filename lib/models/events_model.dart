import 'package:reafel_app/data/data_dtos.dart';
import 'package:reafel_app/models/eventDB_model.dart';

class EventsModel {
  List<EventModel> _events = [];
  List<EventModel> get events => _events;
}

class EventModel {
  Event event;

  //Stream<Event> get getEvent => ;

  String get id => '28645';

  ///Which day did the event occurred.
  String get date => 'Tue, 11 April';//event.date;

  ///At what time did the event occurred.
  String get time => 'my time';//event.time;

  ///How long did the event last.
  double get duration => 1.0;//event.duration;

  ///Where were you at that time.
  String get location => 'Lyngby Sø';//event.location;

  ///A list of symptoms when an event occurred.
  List<String> get symptoms => ['mysymptom1, mysymptom2'];//event.symptoms;

  ///What activity was the user doing when an event occurred.
  String get activity => 'coding';//event.activity;

  ///User's notes for this event.
  String get notes => 'these are notes';//event.notes;


  ///Is all the data included?
  bool get completed => true;


  void set id(String id) {
    event.id = id;
  }

  void set date(String date) {
    event.date = date;
  }

  void set time(String time) {
    event.time = time;
  }

  void set location(String location) {
    event.location = location;
  }

  void set duration(double duration) {
    event.duration = duration;
  }


  void set symptoms(List<String> symptoms) {
    event.symptoms = symptoms;
  }

  void set activity(String activity) {
    event.activity = activity;
  }

  void set notes(String notes) {
    event.notes = notes;
  }


  void set completed(bool completed) {
    event.completed = completed;
  }

  Event toEvent() => event;



  EventModel(this.event)
      : assert(event != null, 'A EventModel must be initialized with a real Event.'),
        super() {
    //TODO - initialize
    event.id = this.id;
    event.date = this.date;
    event.time = this.time;
    event.location = this.location;
    event.duration = this.duration;
    event.symptoms = this.symptoms;
    event.activity = this.activity;
    event.notes = this.notes;
    event.completed = this.completed;
  }
}


