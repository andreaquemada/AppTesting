import 'package:reafel_app/data/data_dtos.dart';

class DeviceModel{

  Device device;


  ///Whether device is connected to smartphone or not
  bool get connected => false;



  DeviceModel(this.device)
      : assert(device != null, 'A DeviceModel.'),
        super();
}