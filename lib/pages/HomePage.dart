import 'package:flutter/material.dart';
import 'package:reafel_app/blocs/bloc.dart';
import 'package:reafel_app/blocs/provider.dart';
import 'package:reafel_app/models/user_model.dart';
import 'package:reafel_app/pages/Demographics/Demographics.dart';
import 'package:reafel_app/pages/Home/Home.dart';
import 'package:reafel_app/pages/TabPage.dart';
import 'package:reafel_app/translations.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';
  UserModel user;


  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 88.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/pet1.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        bloc.submit() == null
            ? 'Welcome'
            : 'Welcome ${user.email.split('@')[0].toString()}', //
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        Translations.of(context).text("basicInfo")
        ,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final ok = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.pinkAccent[700],
        elevation: 5.0,
        color: Colors.white,
        child: MaterialButton(
          minWidth: 42.0,
          height: 42.0,
          onPressed: () {
            //Navigator.of(context).pushReplacementNamed(MainTabs.tag);
            Navigator.of(context).pop();
            Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new Demographics()));
          },
          child: Text('OK', style: TextStyle(color: Colors.teal)),
        ),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.teal,
          Colors.tealAccent[700],
        ]),
      ),
      child: Column(
        children: <Widget>[alucard, welcome, lorem, ok],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
