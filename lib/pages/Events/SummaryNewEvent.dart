import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reafel_app/blocs/reafel_bloc.dart';
import 'package:reafel_app/models/events_model.dart';
import 'package:reafel_app/widget/ActivitiesWidget.dart';
import 'package:reafel_app/widget/SymptomsWidget.dart';
import 'package:reafel_app/widget/TimeWidget.dart';
import 'package:reafel_app/widget/eventField.dart';

class SummaryNewEvent extends StatefulWidget {
  const SummaryNewEvent({Key key}) : super(key: key);

  @override
  SummaryNewEventState createState() => SummaryNewEventState(reafelBloc.receiveLastEvent());
}

class SummaryNewEventState extends State<SummaryNewEvent>
    with TickerProviderStateMixin {

  final EventModel event;

  SummaryNewEventState(this.event) : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('Selected date: ${event.date}');
    print('Selected time: ${event.time}');
    print('Selected duration: ${event.duration}');
    print('Selected symptoms: ${event.symptoms}');
    print('Selected activity: ${event.activity}');

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Summary new event',
              style: new TextStyle(color: Colors.white)),
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: size.width,
          padding: EdgeInsets.all(8.0),
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new EventField(
                icon: Icons.date_range,
                measure: 'Date',
                value: event.date,
              ),
              new EventField(
                icon: Icons.watch_later,
                measure: 'Time',
                value: event.time,
              ),
              new EventField(
                icon: Icons.hourglass_empty,
                measure: 'Duration',
                value: '${event.duration.round()} min',
              ),
              new EventField(
                icon: Icons.airline_seat_flat_angled,
                measure: 'Symptoms',
                value:
                    '${event.symptoms.toString().substring(1, event.symptoms.toString().length - 1)}',
              ),
              new EventField(
                icon: Icons.directions_bike,
                measure: 'Activities',
                value: event.activity,
              ),
              new EventField(
                icon: Icons.border_color,
                measure: 'Notes',
                value: event.notes,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: new RaisedButton(
                      child: new Text(
                        'OK',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.teal,
                      highlightColor: Colors.teal[900],
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
