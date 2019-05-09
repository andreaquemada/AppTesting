import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reafel_app/blocs/reafel_bloc.dart';
import 'package:reafel_app/data/data_dtos.dart';
import 'package:reafel_app/models/eventDB_model.dart';
import 'package:reafel_app/models/events_model.dart';
import 'package:reafel_app/models/fixedValues.dart';
import 'package:reafel_app/pages/Events/NewEvent.dart';
import 'package:intl/intl.dart';
import 'package:reafel_app/translations.dart';

class Events extends StatefulWidget {
  const Events({Key key}) : super(key: key);

  @override
  EventsState createState() => new EventsState(reafelBloc.receiveAllEvents());
}

class EventsState extends State<Events> with TickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  bool eventCompleted;
  EventModel event;

  final List<EventModel> events;

  EventsState(this.events) : super();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    //event.completed = true;

    //events.forEach(complete);

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  /*void complete(EventModel event)
  {
    event.completed = true;
  }*/

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Events', style: new TextStyle(color: Colors.white)),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      /* floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: new FloatingActionButton(
              backgroundColor: Colors.pinkAccent[700],
              child: AnimatedIcon(
                  icon: AnimatedIcons.add_event, progress: _animateIcon),
              onPressed: () {
                Navigator.of(context).push(new PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new NewEvent()));

              }),
        ),*/
      body: SafeArea(
        bottom: true,
        child: StreamBuilder<List<Event>>(
            stream: reafelBloc.events,
            builder: /**/
                (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
              if (snapshot.hasError) {
                print('DATA HAS ERROR');
              } if(snapshot.hasData) {
                final myData = snapshot.data;

                return new ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: myData.length, //EventInfo.myEvents.length,
                    itemBuilder: (context, index) {
                      DateTime day =
                          DateTime.now().add(new Duration(hours: index));
                      DateFormat formatting = DateFormat('kk:mm:ss\nEEE d MMM');
                      String formattedDate = formatting.format(day);

                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                          padding: EdgeInsets.only(right: 16.0),
                          child: new Text('Delete event.',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0)),
                          alignment: Alignment.centerRight,
                        ),
                        key: Key(events[index].location), //item
                        onDismissed: (direction) {
                          setState(() {
                            events.removeAt(index);
                          });
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "${events[index].location} dismissed"))); //EventInfo.myEvents[index]
                        },
                        child: new Container(
                          width: screenSize.width,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new ListTile(
                                  leading: new Icon(
                                    events[index].completed
                                        ? Icons.check_circle
                                        : Icons.panorama_fish_eye,
                                    color: Colors.black54,
                                  ),
                                  //event.completed
                                  title: new Text(myData[index]
                                      .symptoms
                                      .toString() /*events[index].location*/),
                                  //EventInfo.myEvents[index]

                                  subtitle: new Text(
                                      'I was ${myData[index].activity}'
                                      /*Translations.of(context).text("Tap")*/),
                                  trailing: new Text(myData[index].date),
                                  //formattedDate
                                  onTap: () {
                                    //Navigator.of(context).pushNamed('/edit');
                                  }),
                              new Divider(
                                height: 2.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
