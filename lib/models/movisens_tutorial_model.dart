import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reafel_app/data/data_dtos.dart';

class MovisensTutorialModel {
  Tutorial tutorial;

  List<IconData> get picList => [
        FontAwesomeIcons.laptop,
        FontAwesomeIcons.clipboardCheck,
        FontAwesomeIcons.userCheck,
        FontAwesomeIcons.square,
        FontAwesomeIcons.userShield,
        FontAwesomeIcons.bluetooth,
        FontAwesomeIcons.mobileAlt
      ];

  List<String> get titleList => [
        'Start Movisens',
        'Movisens Specifications',
        'Get yourself ready',
        'Get Movisens ready',
        'Placement',
        'Bluetooth Connection',
        'Pairing'
      ];

  List<String> get descriptionList => [
        'Connect Movisens to a Windows 7 PC and open the Movisens Sensor Manager',
        'Specify starting time and duration of recording. Then disconnect Movisens from PC',
        'For a good adherence of Movisens shave your chest and make sure your skin is dry',
        'Attach 2 electrodes to Movisens\n Remove stickers from both electrodes',
        'Place Movisense on your chest with the label upright and readable',
        'Go to Settings/Bluetooth in your phone and turn on Bluetooth',
        'Search for available devices and select Movisens EcgMove 4'
      ];

  MovisensTutorialModel(this.tutorial)
      : assert(tutorial != null,
            'A MovisensTutorialModel must be initialized with a real Tutorial.'),
        super() {
    //TODO - initialize
    tutorial.iconList = this.picList;
    tutorial.titleList = this.titleList;
    tutorial.descriptionList = this.descriptionList;
  }
}
