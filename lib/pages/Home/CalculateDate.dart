import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reafel_app/pages/Home/style.dart';

class CalculateDate extends StatefulWidget {
  CalculateDateState createState() => CalculateDateState();
}

class CalculateDateState extends State<CalculateDate> {
  DateTime todayCal2 = DateTime.now().toUtc();

//Calculate presented Day
  void calculateDateFunction(int op) {
    DateTime savedDate = todayCal2;
    if (op == 1) {
      print(savedDate);
      setState(() {
        todayCal2 = savedDate.add(new Duration(days: -1));
      });
    } else if (op == 2) {
      print(savedDate);
      setState(() {
        todayCal2 = savedDate.add(new Duration(days: 1));
      });
    }
  }

  Widget build(BuildContext context) {
    String today = DateFormat.yMMMMEEEEd().format(todayCal2).toUpperCase();

    List splitted = today.split(' ');
    String dayOfWeek = splitted[0].toString().toLowerCase()[0].toUpperCase() +
        splitted[0].toString().toLowerCase().substring(1);

    // Small hack to remove the ending "," when set to english!
    if (dayOfWeek.endsWith(",")) {
      dayOfWeek = dayOfWeek.substring(0, dayOfWeek.length - 1);
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.navigate_before,
                size: 30.0,
              ),
              color: const Color.fromRGBO(0, 0, 0, 0.5),
              onPressed: () {
                calculateDateFunction(1);
              }),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  dayOfWeek,
                  style: styleDayOfWeek,
                ),
                new Text(
                  splitted[1] + ' ' + splitted[2] + ' ' + splitted[3],
                  style: styledDate,
                ),
              ]),
          new IconButton(
              icon: new Icon(
                Icons.navigate_next,
                size: 30.0,
              ),
              color: const Color.fromRGBO(0, 0, 0, 0.5),
              onPressed: () {
                calculateDateFunction(2);
              }),
        ],
      ),
    );
  }
}
