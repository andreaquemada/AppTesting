import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reafel_app/blocs/reafel_bloc.dart';
import 'package:reafel_app/blocs/sensing_qualitycheck_bloc.dart';
import 'package:reafel_app/models/device_model.dart';
import 'package:reafel_app/pages/BLE_pairing/Ble_pairing.dart';
import 'package:reafel_app/pages/Events/Events.dart';
import 'package:reafel_app/pages/Events/NewEvent.dart';
import 'package:reafel_app/pages/Home/Home.dart';
import 'package:reafel_app/pages/HomePage.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/FABBottomAppBarItem.dart';
import 'package:badges/badges.dart';
import 'package:reafel_app/blocs/ble_bloc.dart';
import 'package:reafel_app/pages/Home/Home.dart';

const url = 'http://sharp-lamport-89a6ea.netlify.com/';

class MainTabs extends StatefulWidget {
  MainTabs({Key key, this.title}) : super(key: key);
  static String tag = 'tab-page';

  final String title;

  @override
  MainTabsState createState() => new MainTabsState(reafelBloc.deviceConnected());
}

class MainTabsState extends State<MainTabs> with TickerProviderStateMixin {

  TabController controller;
  int mySelectedIdx;
  DeviceModel device;
  bool connected;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  StreamSubscription<bool> succesfulPairingSubscription;

  StreamSubscription<bool> tapMarkerEventSubscription;

  MainTabsState(this.connected) : super();

  @override
  void initState() {


    succesfulPairingSubscription =
        sensingQualityCheckBloc.status.listen((status) {
          print("inside  status redirect");
          if (status ==false) {
            Navigator.of(context).pushReplacementNamed(ReafelBleScan.tag);
          } else {
           // Navigator.of(context).pushReplacementNamed(HomePage.tag);
          }
        });

    tapMarkerEventSubscription= sensingQualityCheckBloc.isTapMarkerPressed.listen((isMarkerPresser){
      print(" Tap marker pressed " + isMarkerPresser.toString());


    });


    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    controller = new TabController(vsync: this, length: 3);
    mySelectedIdx = 0;
    super.initState();

  }

  @override
  void dispose() {
    print('Im in TabPage dispose');
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }



  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }


  Widget _selectedTab(int index) {
    setState(() {
      mySelectedIdx = index;
    });
  }

  Widget _selectedTabBuild(int index) {
    switch (index) {
      case 0:
        return new Home();
      case 1:
        return new Events();
      default:
        return new Container(
            child: new Center(
              child: new Text('TBD4'),
            ));
    }
  }

  @override
  Widget build(BuildContext context) {

    final reafelBloc = ReafelBloc();


    /// Code for dot which shows connection with device
    /* Material(
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: Colors.black54,
      elevation: 5.0,
      color: Colors.transparent,
      child: new Container(
        width: 9.0,
        height: 9.0,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: connected ? Colors.green : Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    ),*/


    /// Working version
    return WillPopScope(
      onWillPop: null,
      child: new Scaffold(
        body: Center(child: _selectedTabBuild(mySelectedIdx)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: new FloatingActionButton(
            backgroundColor: Colors.pinkAccent[700],
            child: AnimatedIcon(
              icon: AnimatedIcons.add_event, progress: _animateIcon,),
            onPressed: () {
              Navigator.of(context).push(new PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new NewEvent()));

            }),
        bottomNavigationBar: FABBottomAppBar(
          color: CupertinoColors.inactiveGray,
          selectedColor: Colors.teal,
          //notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
            FABBottomAppBarItem(iconData: Icons.calendar_today, text: 'Events'),

          ],
        ),
      ),
    );

    /*      bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 4.0,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.home), tooltip: 'Home', onPressed: () {},),
                IconButton(icon: Icon(Icons.today),tooltip: 'Events', onPressed: () {},),
                IconButton(icon: Icon(Icons.format_list_bulleted), tooltip: 'PROs', onPressed: () {},),
                IconButton(icon: Icon(Icons.settings), tooltip: 'Settings', onPressed: (){})
              ],
            ),
          ),

      bottomNavigationBar: new TabBar(

            indicatorSize: TabBarIndicatorSize.tab,
            //indicatorWeight: 0.0,
              unselectedLabelColor: CupertinoColors.inactiveGray,
              labelColor: Colors.teal,
              controller: controller, tabs: <Tab>[
            new Tab(text: 'Home', icon: new Icon(Icons.home)),
            new Tab(text: 'Events', icon: new Icon(FontAwesomeIcons.calendarCheck)),
          ]),
          body: new TabBarView(
              controller: controller,
              children: <Widget>[new Home(), new Events()])),
    );*/

    /*   return new CupertinoTabScaffold(
      tabBar: new CupertinoTabBar(
          backgroundColor: Colors.white.withOpacity(0.98),
          // Color.fromRGBO(97, 195, 217, 0.0),
          inactiveColor: CupertinoColors.inactiveGray,
          //Color.fromRGBO(255,255,255,1.0),
          activeColor: Colors.teal,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              title: new Text(Translations.of(context).text('Home')),
              icon: new Icon(
                Icons.home,
              ),
            ),
            new BottomNavigationBarItem(
              //title: new Text(Translations.of(context).text('PROs')),
              icon: new Icon(Icons.add_circle, size: 50.0,),
            ),
            new BottomNavigationBarItem(
              title: new Text(Translations.of(context).text('Events')),
              icon: new Icon(Icons.today),
            ),

          ]),
      tabBuilder: (BuildContext context, int index) {
        assert(index >= 0 && index <= 2);
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return Home();
              },
              defaultTitle: 'Home',
            );
            break;
          case 1:
            Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new NewEvent()));
            break;
          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) => Events(),
              defaultTitle: 'Events',
            );
            break;

        }
        return null;
        *//*return new CupertinoTabView(
            routes: routes,
            builder: (BuildContext context) {
          switch (index) {
            case 0:
              return new Home();
            case 1:
              return new NewEvent();
            case 2:
              return new Events();

            default:
              return new Container(
                  child: new Center(
                child: new Text('TBD4'),
              ));
          }

        });*//*
      },
    );*/

  }
}
