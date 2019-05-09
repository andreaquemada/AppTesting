import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reafel_app/blocs/provider.dart';
import 'package:reafel_app/pages/BLE_pairing/Ble_pairing.dart';
import 'package:reafel_app/pages/HomePage.dart';
import 'package:reafel_app/pages/Login/LoginPage.dart';
import 'package:reafel_app/pages/SplashPage.dart';
import 'package:reafel_app/pages/TabPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reafel_app/pages/Tutorial/MainTutorial.dart';
import 'package:reafel_app/translations.dart';

void main() async {
  //MapView.setApiKey("<AIzaSyDLGpQ-wUdllb35otDIDSEpvIHeE7W_y_U>");
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //final routes;

/*
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {*/

  final routes = <String, WidgetBuilder>{
  LoginPage.tag: (context) => LoginPage(),
  HomePage.tag: (context) => HomePage(),
  MainTabs.tag: (context) => MainTabs(),
  MainTutorial.tag: (context) => MainTutorial(),
  ReafelBleScan.tag:  (context) => ReafelBleScan(),
  };

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'HEARTWAVE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Nunito',
        ),
        localizationsDelegates: [
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          const FallbackMaterialLocalisationsDelegate()
        ],
        supportedLocales: [
          const Locale('en',''),
          const Locale('da','')
        ],
        home: SplashPage(),
        routes: routes,
      ),
    );
  }

}
