import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reafel_app/pages/Home/style.dart';

class DataPainter extends CustomPainter {
  var dotsWidth = 2.0;
  var clockText;

  Paint hrvPaint = new Paint();
  Paint accPaint = new Paint();
  Paint hrPaint = new Paint();
  Paint actPaint = new Paint();
  Paint eventPaint = new Paint();
  Paint dotPaint = new Paint();
  TextPainter textPaint = new TextPainter();
  TextStyle textStyle;

  DataPainter({this.clockText= ClockText.roman})
      :dotPaint= new Paint(),
        textPaint= new TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = const TextStyle(
          color: Colors.black,
          fontFamily: 'Times New Roman',
          fontSize: 15.0,
        )
  {
    dotPaint.color= Colors.blueGrey;
  }


  @override
  void paint(Canvas canvas, Size size) {
    final freq = 720;
    final actChunks = 12;
    final eventsNum = 3;
    final ticks = 24;
    final angle = 2 * pi / freq;
    final angleAct = 2 * pi / actChunks;
    final angleEvent = 2 * pi / eventsNum;
    final angleTicks = 2 * pi / ticks;
    final radius = size.width / 2;

    hrvPaint.color = Color(0XFFFF00D6);//Pink
    accPaint.color = Color(0XFF4285F4); //Blue
    hrPaint.color = Color(0XFFE07900); //Orange
    eventPaint.color = Color(0XFF00FFF0); //Light Blue
    dotPaint.color = const Color.fromRGBO(0, 0, 0, 0.5); //Grey
    //List<Color> activityColors = [Colors.purpleAccent[200], Colors.purpleAccent[700], Colors.purple[700], Colors.purple[900]];
    List<Color> activityColors = [
      Color(0xFF2C1F47), //Sleep
      Color(0xFF692a6f), //Sedentary
      Color(0xFFbf406a), //Active
      //Color(0xFFed8f60),
    ];

    actPaint.strokeWidth = 10.0;
    actPaint.style = PaintingStyle.stroke;
    actPaint.strokeCap = StrokeCap.square;

    /*eventPaint.strokeWidth = 10.0;
    eventPaint.style = PaintingStyle.stroke;
    eventPaint.strokeCap = StrokeCap.square;*/
    eventPaint.strokeWidth = 3.0 ;

    canvas.save();
    Offset centerArc = new Offset(0.0, 0.0);


    Random randRadius = Random();
    Random randColors = Random();
    Random randAngle = Random();

    int next = 0 + randAngle.nextInt((2*pi).floor());

    // drawing
    canvas.translate(radius, radius);
    var hrvRadius = new List<int>.generate(
        freq + 1, (i) => -(radius).floor() - randRadius.nextInt(50));
    var hrRadius = new List<int>.generate(
        freq + 1, (i) => -radius.floor() - randRadius.nextInt(50));
    var accRadius = new List<int>.generate(
        freq + 1, (i) => -radius.floor() - randRadius.nextInt(50));
    var randomActivityColors = new List<Color>.generate(
        freq + 1, (i) => activityColors[randColors.nextInt(3)]);
    print('Lista de elementos: $hrvRadius');

    print(hrvRadius);

    //canvas.drawRect(Rect.fromCircle(center: Offset(0.0,0.0),radius: radius ), accPaint );
    //canvas.drawCircle(new Offset(0.0, -radius - 10.0), dotsWidth, hrPaint);

    for (var i = 0; i < ticks; i++) {

      if(i % 2 == 0)
      {
        canvas.save();
        canvas.translate(0.0, - radius + 30.0);
        textPaint.text= new TextSpan(
          text: '${i == 0 ? ticks : i}',
          style: styleInfo,);
        //helps make the text painted vertically
        canvas.rotate(- angleTicks * i);

        textPaint.layout();
        textPaint.paint(canvas, new Offset(-(textPaint.width/2), -(textPaint.height/2)));
        canvas.restore();
      }
      else{
        canvas.drawCircle(new Offset(0.0, radius - 25.0), dotsWidth, dotPaint);
      }
      canvas.rotate(angleTicks);

    }

    for (var i = 0; i < actChunks; i++) {
      actPaint.color = randomActivityColors[i];

      canvas.drawArc(
          new Rect.fromCircle(center: centerArc, radius: radius - 10.0),
          -pi / 2,
          pi / 6,
          false,
          actPaint);
      canvas.rotate(angleAct);
    }

    for (var i = 0; i < eventsNum; i++) {

      canvas.drawLine(Offset(0.0, radius - 15.0),
          Offset(0.0, radius - 5.0), eventPaint);
      canvas.rotate(next.toDouble());
    }

    for (var i = 0; i < freq; i++) {
      i == freq
          ? canvas.drawLine(Offset(0.0, hrvRadius[i].toDouble()),
              Offset(0.0, hrvRadius[0].toDouble()), hrvPaint)
          : canvas.drawLine(Offset(0.0, hrvRadius[i].toDouble()),
              Offset(0.0, hrvRadius[i + 1].toDouble()), hrvPaint);

      i == freq
          ? canvas.drawLine(Offset(0.0, hrRadius[i].toDouble()),
              Offset(0.0, hrRadius[0].toDouble()), hrPaint)
          : canvas.drawLine(Offset(0.0, hrRadius[i].toDouble()),
              Offset(0.0, hrRadius[i + 1].toDouble()), hrPaint);

      i == freq
          ? canvas.drawLine(Offset(0.0, accRadius[i].toDouble()),
              Offset(0.0, accRadius[0].toDouble()), accPaint)
          : canvas.drawLine(Offset(0.0, accRadius[i].toDouble()),
              Offset(0.0, accRadius[i + 1].toDouble()), accPaint);



      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}

enum ClockText{
  roman,
  arabic
}
