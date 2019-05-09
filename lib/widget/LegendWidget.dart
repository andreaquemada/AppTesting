import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafel_app/pages/Home/style.dart';
import 'package:reafel_app/translations.dart';

class LegendWidget extends StatelessWidget {
  final bool circle;
  final IconData icon;
  final Color color;
  final String parameter;
  final String turn;

  LegendWidget({this.circle, this.icon, this.color, this.parameter, this.turn});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            circle
                ? Container(
                    decoration: new BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    width: 10.0,
                    height: 10.0,
                  )
                :
            new RotatedBox(
                quarterTurns: turn == '90' ? 3 : turn == '180' ? 2 : 0,
                child: new Icon(
                  icon,
                  color: CupertinoColors.inactiveGray,
                  size: 25.0,
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: new Text(parameter,
                  style: styleInfo),
            ),
          ]),
    );
  }
}
