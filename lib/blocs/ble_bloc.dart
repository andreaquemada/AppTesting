import 'package:reafel_app/data/backend.dart';
import 'package:reafel_app/sensing/sensingEval.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';



class BleBloc{

  FlutterBlue _flutterBlue = FlutterBlue.instance;

  /// Scanning
  StreamSubscription scanSubscription;
  Map<DeviceIdentifier, ScanResult> scanResults = new Map();
  bool isScanning = false;

  /// State
  StreamSubscription stateSubscription;
  BluetoothState state = BluetoothState.on;

  /// Device
  BluetoothDevice device;
  bool get isConnected => (device != null);
  StreamSubscription deviceConnection;
  StreamSubscription deviceStateSubscription;
  List<BluetoothService> services = new List();
  Map<Guid, StreamSubscription> valueChangedSubscriptions = {};
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;


  SensingEval sensing = SensingEval();
  Backend backend = Backend();

  void init() {
    /// TODO - implement initialization
    ///
    // Immediately get the state of FlutterBlue
    _flutterBlue.state.then((s) {
        state = s;
        print('Hey I am getting flutter bluestate: $state');

    });
    // Subscribe to state changes
    stateSubscription = _flutterBlue.onStateChanged().listen((s) {

        state = s;

        print('Hey I am getting flutter bluestate onStateChanged: $state');

    });

   // startScan();

  }


  @override
  void dispose() {
    stateSubscription?.cancel();
    stateSubscription = null;
    scanSubscription?.cancel();
    scanSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    //_scanResultController;

  }



  final _scanResultController = StreamController<String>.broadcast();


  StreamSink<String> get scanResult => _scanResultController.sink;

  Stream<String> get status => _scanResultController.stream.map((event) {
    print("I got this device event: $event");
    return event;
  });






  startScan() {

    print("Start scan called ");

    scanSubscription = _flutterBlue
        .scan(
      timeout: const Duration(seconds: 5),

    )
        .listen((scanResult) {
        if(scanResult.advertisementData.localName.contains("C3-")||scanResult.advertisementData.localName.contains("MOVISENS"))
        {
          scanResults[scanResult.device.id] = scanResult;

          _scanResultController.add(scanResult.device.id.toString());

          print("Name " + scanResult.device.name +" id "+scanResult.device.id.toString() );
          }

    }, onDone: stopScan);


      isScanning = true;



  }

  stopScan() {
    scanSubscription?.cancel();
    scanSubscription = null;
    isScanning = false;

  }

  connect(BluetoothDevice d) async {
    device = d;

    print( "Device is  " +device.name.toString()+" ID " + device.id.toString());

 /// start plugin here..
    ///
    SensingEval sensingEval = new SensingEval();
    sensingEval.start();

  }

  disconnect() {
    // Remove all value changed listeners
    valueChangedSubscriptions.forEach((uuid, sub) => sub.cancel());
    valueChangedSubscriptions.clear();
    deviceStateSubscription?.cancel();
    deviceStateSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;

      device = null;

  }
}

final bleBloc = BleBloc();
