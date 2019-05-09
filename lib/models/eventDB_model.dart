/// EventModel.dart
import 'dart:convert';

Event eventFromJson(String str) {
  final jsonData = json.decode(str);
  return Event.fromJson(jsonData);
}

String eventToJson(Event data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Event {
  String id;
  String date;
  String time;
  String location;
  double duration;
  List<String> symptoms;
  String activity;
  String notes;
  String source;
  bool completed;

  Event({
    this.id,
    this.date,
    this.time,
    this.location,
    this.duration,
    this.symptoms,
    this.activity,
    this.notes,
    this.source,
    this.completed

  });

  factory Event.fromJson(Map<String, dynamic> json) => new Event(
    id: json["id"],
    date: json["date"],
    time: json["time"],
    location: json["location"],
    duration: json["duration"],
    symptoms: json["symptoms"],
    activity: json["activity"],
    notes: json["notes"],
    source: json["source"],
    completed: json["completed"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "time": time,
    "location": location,
    "duration": duration,
    "symptoms": symptoms,
    "activity": activity,
    "notes": notes,
    "source": source,
    "completed": completed
  };


}