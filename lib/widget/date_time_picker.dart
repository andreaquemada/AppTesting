import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';

Future<dynamic> selectDate(
  BuildContext context, myselectedDate
) async {
  FocusScope.of(context).requestFocus(new FocusNode());
  final DateTime picked = await showDatePicker(
      context: context,
      initialDate: myselectedDate,
      firstDate: new DateTime(1901, 1),
      lastDate: new DateTime(2101));
  if (picked != null) {
    return new DateFormat.yMEd().format(picked).toString();
  }
}

Future<dynamic> selectTime(BuildContext context, selectedTime) async {
  final formating = TimeOfDayFormat.H_colon_mm;
  print('Understanding formating: $formating');
  final TimeOfDay picked =
      await showTimePicker(context: context, initialTime: selectedTime);
  if (picked != null) {
    //return new DateFormat.Hm().format(picked).toString();
    return picked;
  }
}
