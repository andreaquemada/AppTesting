import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reafel_app/pages/DataPainterTry.dart';



class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    final screenSize = MediaQuery.of(context).size.width;

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Settings', style: new TextStyle(color: Colors.white)),
          actions: <Widget>[

          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
              alignment: AlignmentDirectional.center,
            children:<Widget>[
              new Container(
                //alignment: AlignmentDirectional.center,
                width: 200.0,
                height: 200.0,
                child: new CustomPaint(
                  painter: new DataPainterTry(),
                ),
              ),
            ]
          ),
        ),

    );
  }
}

