import 'package:flutter/material.dart';
import 'package:reafel_app/blocs/reafel_bloc.dart';
import 'package:reafel_app/models/movisens_tutorial_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:reafel_app/pages/BLE_pairing/Ble_pairing.dart';
import 'package:reafel_app/pages/TabPage.dart';
import 'package:reafel_app/pages/Tutorial/style.dart';

class MainTutorial extends StatefulWidget {
  static String tag = 'tutorial-page';

  const MainTutorial({
    Key key,
  }) : super(key: key);

  @override
  MainTutorialState createState() =>
      new MainTutorialState(reafelBloc.receiveTutorial());
}

class MainTutorialState extends State<MainTutorial>
    with TickerProviderStateMixin {
  final MovisensTutorialModel tutorial;
  int _current = 0;

  MainTutorialState(this.tutorial) : super();

  @override
  Widget build(BuildContext context) {
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }

      return result;
    }

    Widget mapSkip(List list, Function handler) {
      Widget result;
      for (var i = 0; i < list.length; i++) {
        result = handler(i, list[i]);
      }

      return result;
    }

    List<int> pages =
        new List<int>.generate(tutorial.picList.length, (int index) => index);

    final carousinyo = CarouselSlider(
      height: MediaQuery.of(context).size.height,
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 1.0,
      aspectRatio: 2.0,
      enableInfiniteScroll: false,
      onPageChanged: (i) {
        setState(() {
          _current = i;
        });
      },
      items: pages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
/*decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.teal,
                          Colors.tealAccent[700],
                        ]),
                      ),*/
                child: Stack(
                  children: <Widget>[
/*ClipPath(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.teal,
                                  Colors.tealAccent[700],
                                ]),
                              ),
                            ),
                            clipper: BottomWaveClipper(),
                          ),*/

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          tutorial.titleList[i],
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            tutorial.picList[i],
                            color: Colors.pink[400],
                            size: 120.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 54.0, right: 16.0, left: 16.0, bottom: 16.0),
                          child: Text(
                            tutorial.descriptionList[i],
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ));
          },
        );
      }).toList(),
    );

    final body = Center(
        child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
          carousinyo,
          Container(
              child: mapSkip(pages, (ele, url) {
            return Container(
              height: 50.0,
              alignment: Alignment.bottomCenter,
              margin: new EdgeInsets.only(bottom: 100.0),
              child: InkWell(
                  onTap: () {
                    print("El index es: $ele");
                    Navigator.of(context).push(new PageRouteBuilder(
                        //pageBuilder: (_, __, ___) => new MainTabs()));
                    pageBuilder: (_, __, ___) => new ReafelBleScan()));
                  },
                  child: new Container(
                      padding: new EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                      decoration: _current == ele ? finishBorder : border,
                      child: _current == ele
                          ? new Text('Finish', style: finishStyle)
                          : new Text('Skip', style: skipStyle))),
            );
          })),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                  pages,
                  (index, url) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Colors.pink[400] //Color.fromRGBO(0, 0, 0, 0.9)
                              : Colors.pink[400].withOpacity(
                                  0.3) //Color.fromRGBO(0, 0, 0, 0.4)
                          ),
                    );
                  },
                ),
              ))
        ]));

    return Scaffold(
      body: body,
    );
  }
}
