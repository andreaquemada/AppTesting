
import 'dart:async';

class SensingQualityCheckBloc{


  //bool _status;


  final _connectionStatusController = StreamController<bool>.broadcast();


  StreamSink<bool> get connectionStatus => _connectionStatusController.sink;

  Stream<bool> get status => _connectionStatusController.stream.map((event) {
    print("I got this event: $event");
    return event;
  });




  final _tapMarkerStatusController = StreamController<bool>.broadcast();

  StreamSink<bool> get tapMarkerStatus => _tapMarkerStatusController.sink;


  Stream<bool> get isTapMarkerPressed => _tapMarkerStatusController.stream.map((event) {
    print(" Tap Marker event: $event");
    return event;
  });


  void dispose(){
    _connectionStatusController.close();
    _tapMarkerStatusController.close();
  }


 /* SensingQualityCheckBloc(){

    _connectionStatusController.stream.listen(onData);

  }


  void onData( bool data){

    //print("inside onData");

    if(data==true) {
      _status = true;
    }
    else
      _status=false;

    connectionStatus.add(_status);

  }
*/



}

final sensingQualityCheckBloc = SensingQualityCheckBloc();



