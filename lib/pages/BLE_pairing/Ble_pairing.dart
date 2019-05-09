import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:reafel_app/blocs/ble_bloc.dart';
import 'package:reafel_app/blocs/sensing_qualitycheck_bloc.dart';
import 'package:reafel_app/pages/Home/Home.dart';
import 'package:reafel_app/pages/HomePage.dart';
import 'package:reafel_app/pages/TabPage.dart';
import 'ble_tile.dart';

class ReafelBleScan extends StatefulWidget {
  static String tag = 'ble-page';

  @override
  _ReafelBleScanState createState() => new _ReafelBleScanState(bleBloc.state);
}

class _ReafelBleScanState extends State<ReafelBleScan> {
//  SensingQualityCheckBloc  sensingQualityCheckBloc = SensingQualityCheckBloc();
  StreamSubscription<bool> succesfulPairingSubscription;

  StreamSubscription<String> scanResultsSubscription;
  // var bleBloc;

  BluetoothState state;

  _ReafelBleScanState(this.state) : super();

  @override
  void initState() {
    //bleBloc = BleBloc();
    bleBloc.init();

    String device;

    succesfulPairingSubscription =
        sensingQualityCheckBloc.status.listen((status) {
      print("inside  status redirect");
      if (status == true) {
        Navigator.of(context).pushReplacementNamed(MainTabs.tag);
      } /*else {
        Navigator.of(context).pushReplacementNamed(HomePage.tag);
      }*/
    });

    bleBloc.status.listen((onScanResult) {
      print("found device" + onScanResult);

      device = onScanResult;

      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    bleBloc.dispose();
    succesfulPairingSubscription.cancel();
    super.dispose();
  }

  _buildScanningButton(BleBloc bleBloc) {
    if (bleBloc.isConnected || bleBloc.state != BluetoothState.on) {
      return null;
    }
    if (bleBloc.isScanning) {
      print("Is scanning " + bleBloc.isScanning.toString());
      return new FloatingActionButton(
        child: new Icon(Icons.stop),
        onPressed: () => bleBloc.stopScan(),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.pink,
      );
    } else {
      return new FloatingActionButton(
        child: new Icon(Icons.search),
        onPressed: () => bleBloc.startScan(),
        backgroundColor: Colors.pink,
      );
    }
  }

  _buildScanResultTiles(BleBloc bleBloc) {
    print("results" +
        bleBloc.scanResults.values
            .map((r) => ScanResultTile(
                  result: r,
                  onTap: () => bleBloc.connect(r.device),
                ))
            .toList()
            .toString());

    // print();

    return bleBloc.scanResults.values
        .map((r) => ScanResultTile(
              result: r,
              onTap: () => bleBloc.connect(r.device),
            ))
        .toList();
  }

  _buildActionButtons(BleBloc bleBloc) {
    if (bleBloc.isConnected) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => bleBloc.disconnect(),
        )
      ];
    }
  }

  _buildAlertTile(BleBloc bleBloc) {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'Bluetooth adapter is ${bleBloc.state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead.color,
        ),
      ),
    );
  }

  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    var tiles = new List<Widget>();
    if (bleBloc.state != BluetoothState.on) {
      print('Bluetooth state is; ${bleBloc.state}');

      tiles.add(_buildAlertTile(bleBloc));
    }
    if (bleBloc.isConnected) {
      setState(() {
        tiles.addAll(_buildScanResultTiles(bleBloc));
      });

      //  tiles.addAll(_buildScanResultTiles(bleBloc));

      /*  tiles.add(_buildDeviceStateTile());
     tiles.addAll(_buildServiceTiles());*/
    } else {
      tiles.addAll(_buildScanResultTiles(bleBloc));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Device Pairing'),
        actions: _buildActionButtons(bleBloc),
      ),
      floatingActionButton: _buildScanningButton(bleBloc),
      /*floatingActionButton:
            FloatingActionButton(


                onPressed: () => bleBloc.startScan()


            )
*/
      body: new Stack(
        children: <Widget>[
          (bleBloc.isScanning) ? _buildProgressBarTile() : new Container(),
          new ListView(
            children: tiles,
          )
        ],
      ),
    );
  }
}
