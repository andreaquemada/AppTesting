import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle skipStyle = new TextStyle(color: Colors.pink[400], fontSize: 20.0);
TextStyle finishStyle = new TextStyle(color: Colors.white, fontSize: 20.0);
BoxDecoration border = new BoxDecoration(
  border: new Border.all(color: Colors.pink[400], width: 1.0),
  borderRadius: new BorderRadius.all(const Radius.circular(25.0)),
);

BoxDecoration finishBorder = new BoxDecoration(
  border: new Border.all(color: Colors.pink[400], width: 1.0),
  color: Colors.pink[400],
  borderRadius: new BorderRadius.all(const Radius.circular(25.0)),
);
