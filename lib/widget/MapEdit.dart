import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var api_key = "AIzaSyDLGpQ-wUdllb35otDIDSEpvIHeE7W_y_U";

class MapEdit extends StatefulWidget {
  const MapEdit({Key key}) : super(key: key);

  _MapEditState createState() => _MapEditState();
}

class _MapEditState extends State<MapEdit> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  //var _mapView = new MapView();
  //var staticMapProvider = new StaticMapProvider(api_key);
  Uri staticMapUri;
  //CameraPosition cameraPosition;




  //Add a method to call to show the map.
  /*void showMap(double latitude, double longitude) {
    _mapView.show(new MapOptions(
      mapViewType: MapViewType.normal,
      initialCameraPosition: new CameraPosition(
          new Location(latitude, longitude), 15.0),
      showUserLocation: true,
      title: "Recent Location",
      hideToolbar: true,
    ));
    _mapView.zoomToFit(padding: 100);

    _mapView.onMapTapped.listen((_) {
      setState(() {
        _mapView.zoomToFit(padding: 100);
      });
    });
  }*/

  Widget build(BuildContext context) {
   /*
    Iterable<Widget> probes = ListTile.divideTiles(
        context: context, tiles: mapBloc.runningProbes.map<Widget>((probe) => buildMap(context, probe)));*/


    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('My Map'),
        //TODO - move actions/settings icon to the app level.
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Theme.of(context).platform == TargetPlatform.iOS
                  ? Icons.more_horiz
                  : Icons.more_vert,
            ),
            tooltip: 'Settings',
            onPressed: _showSettings,
          ),
        ],
      ),
      body: Container()/*buildMap(context)*/,
    );
  }

/*  Widget buildMap(BuildContext context) {
    return StreamBuilder<Datum>(
      stream: ProbeRegistry.probes[DataType.LOCATION].events,
      builder: (context, AsyncSnapshot<Datum> snapshot) {
        if (snapshot.hasData) {
          Datum checkOut = snapshot.data;
          Map<String, dynamic> cheyy = checkOut.toJson();

          return Column(
            children: <Widget>[
              new Container(
                  height: 250.0,
                  child: //Text('Mi latitud es ${cheyy['latitude']} y mi longitud es ${cheyy['longitude']}'),
                      new Stack(children: <Widget>[
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
                          child: new Image.network(staticMapProvider
                              .getStaticUri(
                                  new Location(
                                      cheyy['latitude'], cheyy['longitude']),
                                  15,
                                  height: 400,
                                  width: 800,
                                  mapType: StaticMapViewType.roadmap)
                              .toString()),
                        ),
                      ),
                      onTap: () {
                        showMap(cheyy['latitude'], cheyy['longitude']);
                      },
                    )
                  ])),
              new Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                child: new Text(
                  "This map is interactive. Tap on it!",
                  style: new TextStyle(fontSize: 13.0),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error in probe state - ${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }*/

  void _showSettings() {
    Scaffold.of(context).showSnackBar(
        const SnackBar(content: Text('Settings not implemented yet...')));
  }
}
