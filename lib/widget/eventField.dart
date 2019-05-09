
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafel_app/translations.dart';

class EventField extends StatelessWidget {
  final IconData icon;
  final String measure;
  final String value;

  EventField({this.icon, this.measure, this.value});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return new Container(
        width: size.width,
        padding: new EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Icon(
                icon,
                color: CupertinoColors.inactiveGray,
                size: 25.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(Translations.of(context).text(measure),
                      style: new TextStyle(
                          color: CupertinoColors.inactiveGray)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(value,
                    style: new TextStyle(
                        color: CupertinoColors.inactiveGray)),
              ),
            ]));
  }
}