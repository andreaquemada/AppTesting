//part of mubs;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reafel_app/pages/Login/LoginPage.dart';

class SplashPage extends StatefulWidget {
  @override
  State createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Give the navigation animations, etc, some time to finish
    new Future.delayed(new Duration(seconds: 3))
        .then((_) => Navigator.of(context).pushReplacementNamed(LoginPage.tag));
  }

  final background = new Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage("assets/splash.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  );

  final tealOpacity = Container(
    color: Colors.teal.withOpacity(0.4),
  );

  final cachet = new Container(
    alignment: AlignmentDirectional.center,
    padding: EdgeInsets.all(8.0),
    child: new Hero(
      tag: "tick",
      child: new Image.asset('assets/cachet.png',
          width: 200.0, height: 50.0, scale: 1.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //return new LoadingIndicator();
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          tealOpacity,
          cachet,
        ],
      ),
    );
  }
}
