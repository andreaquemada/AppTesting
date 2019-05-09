import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reafel_app/blocs/reafel_bloc.dart';
import 'package:reafel_app/data/data_dtos.dart';
import 'package:reafel_app/models/user_model.dart';
import 'package:reafel_app/pages/Demographics/birthdayPicker.dart';
import 'package:reafel_app/pages/TabPage.dart';
import 'package:reafel_app/pages/Tutorial/MainTutorial.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/HeightWeightWidget.dart';

class Demographics extends StatefulWidget {

  Demographics({Key key}) : super(key: key);
  static String tag = 'demograph-page';
  @override
  State<StatefulWidget> createState() => new DemographicsState();

}

/*class MyData {
  String name = '';
  String gender = '';
  String height = '';
  String weight = '';
  DateTime birthday;
}*/

class DemographicsState extends State<Demographics> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    String myTitle = Translations.of(context).text('About you');

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(myTitle, style: new TextStyle(color: Colors.white)),
        ),
        body: new StepperBody());
  }
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => new _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {


  int currStep = 0;
  //static var _focusNode = new FocusNode();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  //static MyData data = new MyData();
  UserModel user = new UserModel(User());

  Radio<int> radio1;
  Radio<int> radio2;
  int groupValue = 0;
  int groupValue1 = 0;


  List<DropdownMenuItem<String>> _dropDownMenuItems;

  List _genders = ['male','female'];
  List<DropdownMenuItem<String>> _dropDownMenuItems1;
  String _selectedGender;
  DateTime _selectedDateOfBirth;
  String _selectedHeight;
  String _selectedWeight;

  @override
  void initState() {
    super.initState();
    _selectedGender = _genders[0];
    _selectedHeight = '';
    _selectedWeight = '';
  }



  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List statuses) {
    List<DropdownMenuItem<String>> items = new List();
    for (String status in statuses) {
      items.add(new DropdownMenuItem(
          value: status,
          child: new Text(Translations.of(context).text(status))));
    }
    return items;
  }



  void changedDropDownItem1(String selectedGender) {
    setState(() {
      _selectedGender = selectedGender;
    });
    user.gender = selectedGender;
  }

  Future<Null> _showBirthDateDialog(BuildContext context) async {
    DateTime birthDate = await showBirthDatePicker(
      context: context,
      firstYear: 1900,
      lastYear: DateTime.now().year,
      initialDate: user.dob ?? new DateTime.now(),
    );
    if (mounted && birthDate != null) {
      setState(() {
        _selectedDateOfBirth = birthDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reafelBloc = ReafelBloc();
    // Fetch the items for the dropdrown menu:
    _dropDownMenuItems1 = buildAndGetDropDownMenuItems(_genders);
    // Fetch locale for the birthday!
    Locale myLocale = Localizations.localeOf(context);

    final height = MediaQuery.of(context).size.height;

    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    void _submitDetails() async {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage(Translations.of(context).text('validator'));
      } else if (_selectedDateOfBirth == null) {
        showSnackBarMessage(Translations.of(context).text('birthday_missing'));
      } else {
        formState.save();
        //document.reference.updateData({'name': data.name});

        setState(() {
          user.dob = _selectedDateOfBirth;
          user.gender = _selectedGender;
          user.height = _selectedHeight;
          user.weight = _selectedWeight;

          reafelBloc.sendUserDataToCarp(user);

          print('DOB: ${user.dob}\n Height:${user.height}\n Weight: ${user.weight} \nGender: ${user.gender}');
        });
      }
    }

    return new Container(
        height: height,
        child: new Form(
          key: _formKey,
          child: new Stepper(
            steps: <Step>[
              new Step(
                title: Text(Translations.of(context).text('gender')),
                // subtitle: const Text('Subtitle'),
                isActive: true,
                state: StepState.indexed,
                content: new Container(
                  alignment: AlignmentDirectional.topStart,
                  child: new DropdownButton(
                    value: _selectedGender,
                    items: _dropDownMenuItems1,
                    onChanged: changedDropDownItem1,
                  ),
                ),
              ),
              new Step(
                  title: Text(Translations.of(context).text('Date of Birth')),
                  isActive: true,
                  state: StepState.indexed,
                  content: new InkResponse(
                    child: new Text(
                      _selectedDateOfBirth == null
                          ? Translations.of(context).text('input_birthday')
                          : new DateFormat.yMMMMd(myLocale.languageCode)
                          .format(_selectedDateOfBirth),
                      textAlign: TextAlign.left,
                    ),
                    onTap: () {
                      setState(() {
                        _showBirthDateDialog(context);
                      });
                    },
                  )),
              new Step(
                  title: Text(Translations.of(context).text('height')),
                  isActive: true,
                  state: StepState.indexed,
                  content: HeightWeightWidget(choice: '1',
                    callbackValue: ((val){_selectedHeight = val;
                    }))),
              new Step(
                  title: Text(Translations.of(context).text('weight')),
                  // subtitle: const Text('Subtitle'),
                  isActive: true,
                  state: StepState.indexed,
                  content: HeightWeightWidget(choice: '2',
                    callbackValue: (val) => _selectedWeight =val,)),

            ],
            type: StepperType.vertical,
            currentStep: this.currStep,
            onStepContinue: () {
              setState(() {
                if (currStep == 1 && _selectedDateOfBirth == null) {
                  showSnackBarMessage(
                      Translations.of(context).text('birthday_missing'));
                } else if (currStep < 4 - 1) {
                  currStep = currStep + 1;
                } else {
                  _submitDetails();
                  Navigator.of(context).pushNamed(MainTutorial.tag);
                }

                // else {
                // Scaffold
                //     .of(context)
                //     .showSnackBar(new SnackBar(content: new Text('$currStep')));

                // if (currStep == 1) {
                //   print('First Step');
                //   print('object' + FocusScope.of(context).toStringDeep());
                // }

                // }
              });
            },
            onStepCancel: () {
              setState(() {
                if (currStep > 0) {
                  currStep = currStep - 1;
                } else {
                  currStep = 0;
                }
              });
            },
            onStepTapped: (step) {
              setState(() {
                currStep = step;
              });
            },
          ),
        ));
  }
}
