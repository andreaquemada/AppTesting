import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reafel_app/translations.dart';

class PROs extends StatefulWidget {


  @override
  PROsState createState() => new PROsState();
}

class PROsState extends State<PROs> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(Translations.of(context).text("PROs"), style: new TextStyle(color: Colors.white)),
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: new Center(
          child: new Text(Translations.of(context).text("work")),
        ));
  }
}
