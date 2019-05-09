
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:reafel_app/translations.dart';
import 'package:numberpicker/numberpicker.dart';

class _BirthDatePickerDialog extends StatefulWidget {
  const _BirthDatePickerDialog({
    Key key,
    @required this.initialDate,
    @required this.firstYear,
    @required this.lastYear,
  }) : super(key: key);

  final DateTime initialDate;
  final num firstYear;
  final num lastYear;

  @override
  _BirthDatePickerDialogState createState() =>
      new _BirthDatePickerDialogState();
}

class _BirthDatePickerDialogState extends State<_BirthDatePickerDialog> {
  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialDate.year;
    _selectedMonth = widget.initialDate.month;
    _selectedDay = widget.initialDate.day;
  }

  num _selectedYear;
  num _selectedMonth;
  num _selectedDay;

  void _vibrate() {
    switch (Theme
        .of(context)
        .platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        HapticFeedback.vibrate();
        break;
      case TargetPlatform.iOS:
        break;
    }
  }

  void _handleYearChanged(num value) {
    if (value < widget.firstYear || value > widget.lastYear)
      return;
    _vibrate();
    setState(() {
      _selectedYear = value;
    });
  }

  void _handleMonthChanged(num value) {
    if (value < 1 || value > 12)
      return;
    _vibrate();
    setState(() {
      _selectedMonth = value;
    });
  }

  void _handleDayChanged(num value) {
    if (value < 1 || value > 31)
      return;
    _vibrate();
    setState(() {
      _selectedDay = value;
    });
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handleOk() {
    Navigator.pop(
        context, new DateTime(_selectedYear, _selectedMonth, _selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = Theme.of(context).textTheme.headline;
    return new AlertDialog(
      actions: <Widget>[
        new FlatButton(
          child: new Text(Translations.of(context).text("cancel")),
          onPressed: _handleCancel,
        ),
        new FlatButton(
          child: const Text('OK'),
          onPressed: _handleOk,
        ),
      ],
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(Translations.of(context).text("year"), style: headerStyle),
              new NumberPicker.integer(
                listViewWidth: 70.0,
                initialValue: _selectedYear,
                minValue: widget.firstYear,
                maxValue: widget.lastYear ?? new DateTime.now().year,
                onChanged: _handleYearChanged,
              ),
            ],
          ),
          new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text(Translations.of(context).text("month"), style: headerStyle),
              new NumberPicker.integer(
                listViewWidth: 70.0,
                initialValue: _selectedMonth,
                minValue: 1,
                maxValue: 12,
                onChanged: _handleMonthChanged,
              ),
            ],
          ),
          new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(Translations.of(context).text("day"), style: headerStyle),
              new NumberPicker.integer(
                listViewWidth: 70.0,
                initialValue: _selectedDay,
                minValue: 1,
                maxValue: 31,
                onChanged: _handleDayChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shows a dialog containing a birth date picker.
///
/// The returned [Future] resolves to the date selected by the user when the
/// user closes the dialog. If the user cancels the dialog, null is returned.
///
/// See also:
///
///  * [showTimePicker]
///  * [showDatePicker]
///  * <https://material.google.com/components/pickers.html#pickers-date-pickers>
Future<DateTime> showBirthDatePicker({
  @required BuildContext context,
  @required DateTime initialDate,
  @required num firstYear,
  num lastYear,
}) async {
  assert(lastYear == null ||
      lastYear >= firstYear, 'lastYear must be on or after firstYear');
  assert(initialDate.year >= firstYear, 'initialDate must be after firstYear');
  assert(lastYear == null ||
      initialDate.year <= lastYear, 'initialDate must be before lastYear');
  return await showDialog(
      context: context,
      builder: (BuildContext context){
        return new _BirthDatePickerDialog(
          initialDate: initialDate,
          firstYear: firstYear,
          lastYear: lastYear,
      );
      }
  );
}