import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reafel_app/blocs/reafel_bloc.dart';
import 'package:reafel_app/data/data_dtos.dart';
import 'package:reafel_app/models/eventDB_model.dart';
import 'package:reafel_app/models/events_model.dart';
import 'package:reafel_app/pages/Events/Events.dart';
import 'package:reafel_app/pages/Events/SummaryNewEvent.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/ActivitiesWidget.dart';
import 'package:reafel_app/widget/DurationWidget.dart';
import 'package:reafel_app/widget/SymptomsWidget.dart';
import 'package:intl/intl.dart';
import 'package:reafel_app/widget/TimeWidget.dart';
import 'package:uuid/uuid.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({
    Key key,
  }) : super(key: key);

  @override
  NewEventState createState() => new NewEventState();
}

class NewEventState extends State<NewEvent> with TickerProviderStateMixin {
  int current_step = 0;
  EventModel event = new EventModel(Event());
  final reafelBloc = ReafelBloc();
  final Uuid uuid = Uuid();

  NewEventState() : super();

  @override
  void initState() {
    event.date = new DateFormat.yMEd().format(new DateTime.now()).toString();
    event.time = new DateFormat.Hm().format(new DateTime.now()).toString();
    event.duration = 10.0;
    event.symptoms = [];
    event.activity = '';
    super.initState();
  }

  @override
  void dispose() {
    reafelBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text(Translations.of(context).text("AddNew"),
              style: new TextStyle(color: Colors.white)),
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TimeWidget(
                callbackDate: (val) => event.date = val,
                callbackTime: (val) => event.time = val,
              ),
              SymptomsWidget(callbackSymptoms: (val) => event.symptoms = val),
              DurationWidget(
                callbackDuration: (val) => event.duration = val,
              ),
              ActivitiesWidget(
                callbackActivity: (val) => event.activity = val,
                callbackNotes: (val) => event.notes = val,
              ),
              IconButton(
                padding: EdgeInsets.only(right: 48.0, bottom: 10.0),
                alignment: Alignment.bottomRight,
                icon: Icon(Icons.send, size: 40.0, color: Colors.teal,),
                onPressed: () {
                  print('Going into Summary...');

                  // Generate a v1 (time-based) id
                  event.id = uuid.v1();

                  print(event.id);
                  print(event.date);
                  print(event.time);
                  print(event.duration);
                  print(event.symptoms);
                  print(event.activity);
                  print(event.notes);

                  //reafelBloc.sendEvent(event.event);


                  reafelBloc.add(event.event);

                  Navigator.of(context).pop();
                  /*Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Events()));*/
                },
              ),
            ],
          ),
        ));
  }
}
