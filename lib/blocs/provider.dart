 import 'package:flutter/material.dart';
import 'package:reafel_app/blocs/bloc.dart';


class Provider extends InheritedWidget{

  final bloc = new Bloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context){
    return(context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }

 }

