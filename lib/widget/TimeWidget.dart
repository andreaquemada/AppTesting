import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reafel_app/util/String2DateTime.dart';
import 'package:reafel_app/util/String2Time.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/date_time_picker.dart';

typedef void StringCallback(String val);
typedef void DoubleCallback(double val);

class TimeWidget extends StatefulWidget {
  final StringCallback callbackDate;
  final StringCallback callbackTime;

  const TimeWidget(
      {Key key, this.callbackDate, this.callbackTime})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new TimeWidgetState(
      callbackDate: this.callbackDate,
      callbackTime: this.callbackTime);
}

class TimeWidgetState extends State<TimeWidget> {
  String selectedDate;
  String selectedTime;
  dynamic color = new Color.fromRGBO(0, 0, 0, 0.3);

  StringCallback callbackDate;
  StringCallback callbackTime;

  TimeWidgetState(
      {this.callbackDate, this.callbackTime});

  @override
  void initState() {
    selectedDate = new DateFormat.yMEd().format(new DateTime.now()).toString();
    selectedTime = new DateFormat.Hm().format(new DateTime.now()).toString();


    super.initState();
  }

  closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  openCalender() async {
    //if (edit) {
    // Crazy work-around to convert from String back to DateTime:
    DateTime myDateTime = String2DateTime.getTime(selectedDate);

    print('$selectedDate');

    selectDate(context, myDateTime).then((date) {
      setState(() {
        if (date != null) selectedDate = date;
      });
    });
  }

  openTime() async {
    //if (edit) {
    // Crazy work-around to convert from String back to DateTime:
    TimeOfDay myTime = String2Time.getTime(selectedTime);

    print('$selectedTime');

    selectTime(context, myTime).then((time) {
      setState(() {
        if (time != null) selectedTime = time.toString().substring(10, 15);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    print('Printing selectedTime: $selectedTime');

    callbackDate(selectedDate);
    callbackTime(selectedTime);

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Padding(
            padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(
                        Icons.watch_later,
                        color: color,
                        size: 25.0,
                      ),
                      onPressed: () {
                        closeKeyboard();
                        openCalender();
                      }),
                  Expanded(
                    child: InkResponse(
                      child: new Text(selectedDate,
                          style:
                              new TextStyle(color: CupertinoColors.inactiveGray)),
                      onTap: ()
                      {
                        closeKeyboard();
                        openCalender();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: InkResponse(
                      child: new Text(selectedTime,
                          style:
                              new TextStyle(color: CupertinoColors.inactiveGray)),
                      onTap: (){
                        openTime();
                      },
                    ),
                  ),
                ])),
        Container(
          height: 1.0,
          width: size.width - 20.0,
          color:  color,
        ),

      ],
    );
  }
}
