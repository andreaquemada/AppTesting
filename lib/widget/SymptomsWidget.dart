import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reafel_app/util/String2DateTime.dart';
import 'package:reafel_app/util/String2Time.dart';
import 'package:reafel_app/models/fixedValues.dart';
import 'package:reafel_app/translations.dart';

typedef void ListCallback(List<String> val);

class SymptomsWidget extends StatefulWidget {
  final ListCallback callbackSymptoms;

  const SymptomsWidget({Key key, this.callbackSymptoms}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new SymptomsWidgetState(callbackSymptoms: this.callbackSymptoms);
}

class SymptomsWidgetState extends State<SymptomsWidget> {
  List<String> symptoms;
  ListCallback callbackSymptoms;
  dynamic color = new Color.fromRGBO(0, 0, 0, 0.3);

  static List<bool> mySymp = List<bool>.filled(6, false);

  SymptomsWidgetState({this.callbackSymptoms});

  @override
  void initState() {
    symptoms = [];
    super.initState();
  }

  List<Widget> listmyCircles() {
    List<Widget> list = List();
    for (int i = 0; i < EventInfo.mySymptoms.length; i++) {
      list.add(new CircleButton(
        onTap: () {
          setState(() {
            if (mySymp[i] == false)
              {
                mySymp[i] = true;
                if(symptoms == [])
                  symptoms[0] = EventInfo.mySymptoms[i];
                else
                  symptoms.add(EventInfo.mySymptoms[i]);
              }
            else
              mySymp[i] = false;
          });
        },
        sympIndex: i,
        symptom: EventInfo.mySymptoms[i],
        mySymp: mySymp,
      ));
    }
    return list;
  }



  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    callbackSymptoms(symptoms);

    return Container(
      padding: new EdgeInsets.only(top: 5.0, left: 8.0, bottom: 5.0),
      child: Column(
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
                child: new Text(Translations.of(context).text('addSymptoms'),
                    style:
                    new TextStyle(color: CupertinoColors.inactiveGray)),
              ),
          ],),
         /* new Container(
              padding: EdgeInsets.only(left: 8.0, top:5.0, bottom:5.0, right:16.0),
              height: 70.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listmyCircles().length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: listmyCircles()[i],
                    );
                  }
              )),*/
          Container(
            padding: EdgeInsets.only(left: 8.0, top:5.0, bottom:5.0, right:16.0),
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
                    ],
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      listmyCircles()[3],
                      listmyCircles()[4],
                      listmyCircles()[5],
                    ],
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 5.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      listmyCircles()[2],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            width: size.width - 20.0,
            color:  color,
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String symptom;
  final int sympIndex;
  final List<bool> mySymp;

  const CircleButton(
      {Key key, this.onTap, this.symptom, this.sympIndex, this.mySymp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('The boolean of the symptom is: ${mySymp[sympIndex]}');

    return new InkResponse(
        onTap: onTap,
        child: new Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color: mySymp[sympIndex] ? Colors.black54 : Colors.transparent,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: mySymp[sympIndex] ? Colors.transparent : Colors.black54,
              ),

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(Translations.of(context).text(symptom),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color:
                          mySymp[sympIndex] ? Colors.white : Colors.black54)),
            )));
  }
}
