import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

var api_key = "";

class Edit extends StatefulWidget {

  const Edit({Key key}) : super(key: key);


  @override
  EditState createState() => new EditState();
}

class EditState extends State<Edit> with TickerProviderStateMixin {
  //Create an instance variable for the mapView
  //var _mapView = new MapView();
  //var staticMapProvider = new StaticMapProvider(api_key);
  //Uri staticMapUri;
  //CameraPosition cameraPosition;
  TextEditingController eventController = TextEditingController();

 /* List<Marker> markers = <Marker>[
    new Marker("1", "DTU Skylab", 55.781725, 12.512708, color: Colors.amber),
    new Marker("2", "Hegnet", 55.782479, 12.517160, color: Colors.purple),
  ];*/



  //Add a method to call to show the map.
  /*void showMap() {
    _mapView.show(new MapOptions(
      mapViewType: MapViewType.normal,
      initialCameraPosition:
          new CameraPosition(new Location(55.784438, 12.517504), 15.0),
      showUserLocation: true,
      title: "Recent Location",
      hideToolbar: true,
    ));
    _mapView.setMarkers(markers);
    _mapView.zoomToFit(padding: 100);

    _mapView.onMapTapped.listen((_) {
      setState(() {
        _mapView.setMarkers(markers);
        _mapView.zoomToFit(padding: 100);
      });
    });
  }*/

  @override
  void initState() {
    super.initState();

    //cameraPosition = new CameraPosition(new Location(55.784438, 12.517504), 2.5);
    /*staticMapUri = staticMapProvider.getStaticUri(
        new Location(55.784438, 12.517504), 15,
        height: 400, width: 800, mapType: StaticMapViewType.roadmap);*/
    eventController = TextEditingController(text: ' ');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    DateFormat formatting = DateFormat('kk:mm:ss, on EEE d MMM');
    String formattedDate = formatting.format(DateTime.now());


    return new Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text('Edit your event',
              style: new TextStyle(color: Colors.white)),
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: new Container(
          margin: EdgeInsets.only(top: 10.0),
          color: CupertinoColors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: TextField(
              controller: eventController,
              //onSaved: (value) {
              //  print('jello: $value');
              //},
              onChanged: (value)
              {
                print('halo');
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Please specify it here.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ),

        /*new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Center(
                child: new Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: new Text(
                      'Hey! An event was triggered',
                      style: new TextStyle(color: Colors.teal, fontSize: 17.0),
                      textAlign: TextAlign.left,
                    )),
              ),
              new Padding(
                  padding: EdgeInsets.only(top: 32.0, left: 16.0),
                  child: new Text(
                    'While you were in ...',
                    style: new TextStyle(color: Colors.teal, fontSize: 15.0),
                    textAlign: TextAlign.center,
                  )),
              new Container(
                  height: 250.0,
                  child: new Stack(children: <Widget>[
                    new Center(
                      child: Container(
                        child: new Text(
                          "Searching for map ...",
                          textAlign: TextAlign.center,
                        ),
                        // padding: const EdgeInsets.all(20.0),
                      ),
                    ),
                    new InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0),
                        child: new Center(
                          child: new Image.network(staticMapUri.toString()),
                        ),
                      ),
                      onTap: showMap,
                    )
                  ])),
              new Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: new Text(
                  "This map is interactive. Tap on it!",
                  style: new TextStyle(fontSize: 13.0),
                ),
              ),
              *//*new Container(
                padding: new EdgeInsets.only(top: 15.0, left: 15.0),
                child: new Text(
                    "Camera Position: \n\nLat: ${cameraPosition.center.latitude}\n\nLng:${cameraPosition.center.longitude}\n\nZoom: ${cameraPosition.zoom}"),
              ),*//*
              new Padding(
                  padding: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        'At ',
                        style:
                            new TextStyle(color: Colors.teal, fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                      new Text(
                        '$formattedDate',
                        style: new TextStyle(
                            color: Colors.black54, fontSize: 15.0),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  )),
              new Padding(
                  padding: EdgeInsets.only(top: 32.0, left: 16.0),
                  child: new Text(
                    'Do you remember what happened?',
                    style: new TextStyle(color: Colors.teal, fontSize: 15.0),
                    textAlign: TextAlign.center,
                  )),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: new RaisedButton(
                      child: new Text(
                        'Submit',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.teal,
                      highlightColor: Colors.teal[900],
                      onPressed: () {
                        print('Edit event submitted');
                      }),
                ),
              )
            ],
          ),
        )*/);
  }
}
