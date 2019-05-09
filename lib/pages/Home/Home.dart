import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reafel_app/blocs/reafel_bloc.dart';
import 'package:reafel_app/blocs/sensing_bloc.dart';
import 'package:reafel_app/models/data_model.dart';
import 'package:reafel_app/models/user_model.dart';
import 'package:reafel_app/pages/Home/CalculateDate.dart';
import 'package:reafel_app/pages/Home/Viz.dart';
import 'package:reafel_app/pages/Home/style.dart';
import 'package:reafel_app/pages/Login/LoginPage.dart';
import 'package:reafel_app/translations.dart';
import 'package:reafel_app/widget/LegendWidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

const url = 'https://nervous-hypatia-49b16c.netlify.com/';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  /*final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;*/

  DataModel dataModel;
  UserModel user;
  List<charts.Series> seriesList;
  bool animate;

  HomeState() : super();

  @override
  void initState() {
    super.initState();
    /*flutterWebviewPlugin.launch(url,
        rect: new Rect.fromLTWH(0.0, 140.0, 400, 305.0),
        withZoom: true);*/
  }

  @override
  dispose() {
    //flutterWebviewPlugin.close();
    //flutterWebviewPlugin.dispose();
    print('Im in Home dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final reafelBloc = ReafelBloc();

    return new Scaffold(
      appBar: myAppBar(context, user),
      backgroundColor: Colors.white,
      body: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CalculateDate(),
            Viz(),
            /*Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.rotate(
                  origin: Offset(50.0, 50.0),
                  angle: pi,
                  child: charts.TimeSeriesChart(
                      createSampleData(), // Set up a bucketing axis that will place all values below 0.1 (10%)
                      // into a bucket at the bottom of the chart.
                      //
                      // Configure a tick count of 3 so that we get 100%, 50%, and the
                      // threshold.
                      primaryMeasureAxis: charts.BucketingAxisSpec(
                          threshold: 0.1,
                          tickProviderSpec:
                              new charts.BucketingNumericTickProviderSpec(
                                  desiredTickCount: 2)),
                      dateTimeFactory: const charts.LocalDateTimeFactory(),
                      domainAxis: new charts.DateTimeAxisSpec(
                          viewport: new charts.DateTimeExtents(
                              start: new DateTime(2019, 2, 25, 0, 0),
                              end: new DateTime(2019, 2, 25, 11, 0))),
                      // Configure the default renderer as a line renderer. This will be used
                      // for any series that does not define a rendererIdKey.
                      //
                      // This is the default configuration, but is shown here for  illustration.
                      defaultRenderer: new charts.LineRendererConfig(
                          includeLine: true, includePoints: true),
                      customSeriesRenderers: [
                        new charts.PointRendererConfig(
                          // ID used to link series to this renderer.
                          customRendererId: 'eventPoint',
                          radiusPx: 1.0,
                        )
                      ],
                      animate: animate),
                ),
              ),
            ),*/
            //Container(width: width,height: 285.0,),
            myLegend(context)
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;

  /// Create one series with sample hard coded data.
  /// Create one series with sample hard coded data.
  static List<charts.Series<DataModel, DateTime>> createSampleData() {
    final myHRVData = reafelBloc.receiveDataList('hrv');
    final myHRData = reafelBloc.receiveDataList('hr');
    final myMETData = reafelBloc.receiveDataList('met');
    final myEventData = reafelBloc.receiveEventDay();


    return [
      new charts.Series<DataModel, DateTime>(
        id: 'HRV',
        colorFn: (DataModel data, _) => charts.Color(
            r: Colors.pinkAccent.red,
            g: Colors.pinkAccent.green,
            b: Colors.pinkAccent.blue,
            a: Colors.pinkAccent.alpha),
        domainFn: (DataModel data, _) => data.dateTime,
        measureFn: (DataModel data, _) => data.measure,
        radiusPxFn: (DataModel data, _) => data.radius,
        data: myHRVData,
      ) /*
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint')*/
          ,
      new charts.Series<DataModel, DateTime>(
              id: 'HR',
              colorFn: (DataModel data, _) => charts.Color(
                  r: Colors.greenAccent.red,
                  g: Colors.greenAccent.green,
                  b: Colors.greenAccent.blue,
                  a: Colors.greenAccent.alpha),
              domainFn: (DataModel data, _) => data.dateTime,
              measureFn: (DataModel data, _) => data.measure,
              radiusPxFn: (DataModel data, _) => data.radius,
              data:
                  myHRData) /*
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint')*/
          ,
      new charts.Series<DataModel, DateTime>(
          id: 'MET',
          colorFn: (DataModel data, _) => charts.Color(
              r: Colors.yellowAccent.red,
              g: Colors.yellowAccent.green,
              b: Colors.yellowAccent.blue,
              a: Colors.yellowAccent.alpha),
          domainFn: (DataModel data, _) => data.dateTime,
          measureFn: (DataModel data, _) => data.measure,
          radiusPxFn: (DataModel data, _) => data.radius,
          data: myMETData),
      new charts.Series<DataModel, DateTime>(
          id: 'Events',
          colorFn: (DataModel data, _) => charts.MaterialPalette.black,
          domainFn: (DataModel data, _) => data.dateTime,
          measureFn: (DataModel data, _) => data.measure,
          radiusPxFn: (DataModel data, _) => 5.0,
          data: myEventData)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'eventPoint'),
    ];
  }
}

/*/// Sample linear data type.
class PersonalData{
  final DateTime date;
  final double measure;
  final double radius;
  final charts.Color color;

  PersonalData(this.date, this.measure, this.radius, Color color) : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}*/



Widget myLegend(context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 65.0),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LegendWidget(
                circle: false,
                icon: FontAwesomeIcons.running,
                color: null,
                parameter: '0.5\n/ 1 h',
              ),
              LegendWidget(
                circle: false,
                icon: FontAwesomeIcons.shoePrints,
                color: null,
                parameter: '4100\n/ 6000',
                turn: '90',
              ),
              LegendWidget(
                circle: false,
                icon: Icons.brightness_3,
                color: null,
                parameter: '7.2\n/ 8h',
                turn: '180',
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget myAppBar(context, user) {
  return new AppBar(
      title: Text(
        'HeartWave',
        style: appbar,
      ),
      actions: <Widget>[
        BadgeIconButton(
            itemCount: 3,
            badgeColor: Colors.pinkAccent[700],
            badgeTextColor: Colors.white,
            icon: Icon(Icons.notifications),
            onPressed: () {sensingBloc.start();}),
        IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              reafelBloc.logout(user);
              print('I logged out');
              Navigator.of(context).pop();
              Navigator.of(context).push(new PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new LoginPage()));
            })
      ]);
}
