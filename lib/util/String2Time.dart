// Crazy work-around to convert from String back to DateTime:
import 'package:flutter/material.dart';

class String2Time {

  static TimeOfDay getTime(String mytime) {

    TimeOfDay outTime;

    //String selectedSmall = mytime.substring(5);
    List<String> selectedPieces = mytime.split(':');
    //1969-07-20 20:18:04Z
    String selectedCombined = DateTime.now().toString().substring(0, 10)+ ' '+mytime+':00';
    print('Este es el parsed DateTime del String Time of Day: ');
    print(selectedCombined);
    outTime = TimeOfDay.fromDateTime(DateTime.parse(selectedCombined));

    return outTime;
  }

}