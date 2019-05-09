import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reafel_app/util/String2DateTime.dart';
import 'package:reafel_app/util/String2Time.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/date_time_picker.dart';

typedef void StringCallback(String val);
typedef void DoubleCallback(double val);

class HeightWeightWidget extends StatefulWidget {
  final String choice;
  final StringCallback callbackValue;

  const HeightWeightWidget({Key key, this.choice, this.callbackValue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new HeightWeightWidgetState(choice: this.choice, callbackValue: this.callbackValue);
}

class HeightWeightWidgetState extends State<HeightWeightWidget> {
  dynamic color = new Color.fromRGBO(0, 0, 0, 0.3);
  final controller = new TextEditingController();

  String choice;
  StringCallback callbackValue;

  HeightWeightWidgetState({this.choice, this.callbackValue});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return new Container(
      padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 8.0, top: 5.0, bottom: 5.0, right: 32.0),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: choice == '1'
                        ? Translations.of(context).text("heightEx")
                        : choice == '2' ? Translations.of(context).text("weightEx") : '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value)
                  {
                    callbackValue(value);
                  },
                  onSubmitted: (value){
                    //callbackValue(value);
                    //print('On submitted: Height or weight ${value}');
                  },

                  onEditingComplete: (){

                    //callbackValue(controller.text);
                    print('on Edit: Height or weight ${controller.text}');
                  },
                ),
              ),
            ),
            new Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  shape: BoxShape.rectangle,
                  color: Colors.transparent),
              child: new Text(
                choice == '1'
                    ? Translations.of(context).text("cm")
                    :  choice == '2' ? Translations.of(context).text("kg") : '',
                style: new TextStyle(
                    color: Colors.teal,
                    fontFamily: 'Avenir',
                    fontSize: 15.0),
              ),
            )
          ]),
    );
  }
}
