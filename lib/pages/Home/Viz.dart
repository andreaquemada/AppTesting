import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reafel_app/pages/Home/DataPainter.dart';
import 'package:reafel_app/pages/Home/style.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/LegendWidget.dart';
import 'package:vector_math/vector_math.dart' show radians;

class Viz extends StatefulWidget {
  @override
  VizState createState() => new VizState();
}

class VizState extends State<Viz> with TickerProviderStateMixin {
  Animation controller;

  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;

    return new RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final bool open = true;

  RadialAnimation({Key key, this.controller})
      : scale = Tween<double>(begin: 1.5, end: 0.0).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.linear),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double rad = radians(90);

    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
      child: InkResponse(
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                width: 250.0,
                height: 250.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
              ),
              new Container(
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              new Container(
                width: 200.0,
                height: 200.0,
                child: new CustomPaint(
                  painter: new DataPainter(),
                ),
              ),
              /*Container(
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Heart Score',
                          style: styleTitleScore,
                        ),
                        Text(
                          '8 / 10',
                          style: styleScore,
                        ),
                      ],
                    )),
              ),*/
            ],
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
                  title: new Text(Translations.of(context).text('vizInfo'),
                      style: styleInfoTitle),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              LegendWidget(
                                circle: true,
                                icon: null,
                                color: Color(0XFFFF00D6), //Pink
                                parameter: 'HRV',
                              ),
                              LegendWidget(
                                circle: true,
                                icon: null,
                                color: Color(0XFF4285F4), //Blue
                                parameter: 'ACC.',
                              ),
                              LegendWidget(
                                circle: true,
                                icon: null,
                                color: Color(0XFFE07900), //Orange
                                parameter: 'HR',
                              ),
                              LegendWidget(
                                circle: true,
                                icon: null,
                                color: Color(0XFF00FFF0), //Light blue
                                parameter:
                                    Translations.of(context).text("Event"),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          height: 20.0,
                          decoration: BoxDecoration(
                            // Box decoration takes a gradient
                            gradient: LinearGradient(
                              // Where the linear gradient begins and ends
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              // Add one stop for each color. Stops should increase from 0 to 1
                              stops: [0.1, 0.6, 0.9],
                              colors: [
                                // Colors are easy thanks to Flutter's Colors class.[800],[700],[600],[400]
                                Color(0xFF2C1F47), //Sleep
                                Color(0xFF692a6f), //Sedentary
                                Color(0xFFbf406a), //Active
                                //Color(0xFFed8f60),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text(
                                Translations.of(context).text("sleep"),
                                style: styleInfo,
                              ),
                              new Text(
                                Translations.of(context).text("sedentary"),
                                style: styleInfo,
                              ),
                              new Text(
                                Translations.of(context).text("active"),
                                style: styleInfo,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.teal),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
          );
        },
      ),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
