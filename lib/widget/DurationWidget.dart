import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reafel_app/util/String2DateTime.dart';
import 'package:reafel_app/util/String2Time.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/date_time_picker.dart';

typedef void StringCallback(String val);
typedef void DoubleCallback(double val);

class DurationWidget extends StatefulWidget {
  final DoubleCallback callbackDuration;

  const DurationWidget({Key key, this.callbackDuration}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new DurationWidgetState(callbackDuration: this.callbackDuration);
}

class DurationWidgetState extends State<DurationWidget> {
  dynamic color = new Color.fromRGBO(0, 0, 0, 0.3);
  double _sliderValue;
  DoubleCallback callbackDuration;

  DurationWidgetState({this.callbackDuration});

  @override
  void initState() {
    _sliderValue = 10.0;

    super.initState();
  }

  closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    callbackDuration(_sliderValue);

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Icon(
                  Icons.hourglass_empty,
                  color: color,
                  size: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                  child: new Text(Translations.of(context).text('Duration'),
                      style:
                          new TextStyle(color: CupertinoColors.inactiveGray)),
                ),

              ]),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
                _sliderValue > 119.0
                    ? '+ 1h'
                    : _sliderValue < 60.0 ? '${_sliderValue.floor()} sec'
                    : (_sliderValue - 60.0) == 0.0 ? '1 min'
                    : '${(_sliderValue - 60).floor()} min',
                style:
                new TextStyle(color: CupertinoColors.inactiveGray)),
            Slider(
              activeColor: Colors.pink,
              min: 0.0,
              max: 120.0,
              divisions: 12,
              onChanged: (newRating) {
                setState(() => _sliderValue = newRating);
              },
              value: _sliderValue,
            ),
          ],
        ),
        Container(
          height: 1.0,
          width: size.width - 20.0,
          color: color,
        ),
      ],
    );
  }
}
