import 'dart:math';

import 'package:flutter/material.dart';

class DataPainterTry extends CustomPainter {


  var dotsWidth = 1.0;

  Paint accPaint = new Paint();

  Paint accPaintTry = new Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final freq = 12;
    final angle = 2 * pi / freq;
    final radius = size.width / 2;

    accPaint.color = Colors.greenAccent;
    accPaint.strokeWidth = 1.0;
    accPaint.style = PaintingStyle.stroke;
    accPaint.strokeCap = StrokeCap.square;

    accPaintTry.color = Colors.pinkAccent;
    accPaintTry.strokeWidth = 1.0;
    accPaintTry.style = PaintingStyle.stroke;
    accPaintTry.strokeCap = StrokeCap.square;
    canvas.save();



    Random randRadius = Random();

    // drawing
    canvas.translate(radius, radius);
    var hrvRadius = new List<double>.generate(freq +1, (i) =>  radius + randRadius.nextInt(20));
    print('Lista de elementos: $hrvRadius y el radius era: $radius');
    print(hrvRadius);

    Offset center  = new Offset(0.0, 0.0);
    Offset invertedCenter  = new Offset(radius/2, - radius - sqrt(3)*radius/2);


/*
    canvas.drawArc(Rect.fromCircle(center: center,radius: hrvRadius[0]),
        -pi/2,
        angle,
        false,
        accPaint);
    canvas.drawArc(Rect.fromCircle(center: invertedCenter,radius: hrvRadius[0]),
    pi/2,
    angle,
    false,
    accPaintTry) ;*/


    for (var i = 0; i < freq; i++) {
      //canvas.drawRect(Rect.fromLTRB( 0.0, 0.0, radius*2, radius*2 ), accPaint );

      //canvas.drawRect(Rect.fromCircle(center: invertedCenter,radius: hrvRadius[0]), accPaintTry );

      /*center  = new Offset(0.0, 0.0);
      invertedCenter  = new Offset(radius/2, - radius - sqrt(3)*radius/2);*/

      i==0 ? canvas.drawArc(Rect.fromCircle(center: center,radius: hrvRadius[i]),
              -pi/2,
              angle,
              false,
              accPaint):
      i.isEven ? canvas.drawArc(Rect.fromCircle(center: center,radius: hrvRadius[i]),
          -pi/2,
          angle,
          false,
          accPaint)
      :canvas.drawArc(Rect.fromCircle(center: invertedCenter,radius: hrvRadius[i]),
          pi/2,
          angle,
          false,
          accPaintTry) ;
            canvas.rotate(angle);
    }

  canvas.restore();
}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }


}