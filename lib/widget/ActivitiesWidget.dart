import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafel_app/models/fixedValues.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/TimeWidget.dart';

typedef void ListCallback(List<String> val);

class ActivitiesWidget extends StatefulWidget {
  final StringCallback callbackActivity;
  final StringCallback callbackNotes;

  const ActivitiesWidget({Key key, this.callbackActivity, this.callbackNotes})
      : super(key: key);

  @override
  ActivitiesWidgetState createState() => new ActivitiesWidgetState(
      callbackActivity: this.callbackActivity,
      callbackNotes: this.callbackNotes);
}

class ActivitiesWidgetState extends State<ActivitiesWidget> {
  String activity;
  StringCallback callbackActivity;
  StringCallback callbackNotes;
  static List<bool> myAct = List<bool>.filled(9, false);
  final activityController = new TextEditingController();
  dynamic color = new Color.fromRGBO(0, 0, 0, 0.3);

  ActivitiesWidgetState({this.callbackActivity, this.callbackNotes});

  @override
  void initState() {
    activity = '';
    super.initState();
  }

  @override
  void dispose() {
    activityController.dispose();
    super.dispose();
  }

  List<Widget> listmyCircles() {
    List<Widget> list = List();
    for (int i = 0; i < EventInfo.myActivities.length; i++) {
      list.add(new CircleButton(
        onTap: () {
          setState(() {
            if (myAct[i] == false) {
              myAct = List<bool>.filled(myAct.length, false);
              myAct[i] = true;
              activity = EventInfo.myActivities[i];
            } else
              myAct[i] = false;
          });
        },
        actIndex: i,
        activity: EventInfo.myActivities[i],
        myAct: myAct,
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    callbackActivity(activity);
    callbackNotes(activityController.text);

    var size = MediaQuery.of(context).size;

    return Container(
      padding: new EdgeInsets.only(top: 5.0, left: 8.0, bottom: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Icon(
                Icons.scatter_plot,
                color: color,
                size: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                child: new Text(Translations.of(context).text('addActivity'),
                    style: new TextStyle(color: CupertinoColors.inactiveGray)),
              ),
            ],
          ),
          new Container(
            height: 160.0,
            padding: EdgeInsets.only(left: 8.0, bottom: 5.0, right: 16.0),
            //height: 70.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      listmyCircles()[0],
                      listmyCircles()[1],
                      listmyCircles()[2],
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      listmyCircles()[3],
                      listmyCircles()[4],
                      listmyCircles()[6],
                    ],
                  ),
                ),
                new Padding(
                  padding:
                      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      listmyCircles()[5],
                      listmyCircles()[7],
                      listmyCircles()[8],
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1.0,
            width: size.width - 20.0,
            color: color,
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 10.0, left: 10.0),
            child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Icon(
                    Icons.assignment,
                    color: CupertinoColors.inactiveGray,
                    size: 25.0,
                  ),
                  new Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8.0, top: 5.0, bottom: 5.0, right: 32.0),
                      child: TextField(
                        controller: activityController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: Translations.of(context).text("Comments"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        // onChanged: (note){
                        //  activityController.text = note;
                        //},
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String activity;
  final int actIndex;
  final List<bool> myAct;

  const CircleButton(
      {Key key, this.onTap, this.activity, this.actIndex, this.myAct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('The boolean of the symptom is: ${mySymp[sympIndex]}');

    return new InkResponse(
        onTap: onTap,
        child: new Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color: myAct[actIndex] ? Colors.black54 : Colors.transparent,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: myAct[actIndex] ? Colors.transparent : Colors.black54,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(Translations.of(context).text(activity),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: myAct[actIndex] ? Colors.white : Colors.black54)),
            )));
  }
}
