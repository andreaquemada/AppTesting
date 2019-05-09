

import 'package:reafel_app/models/study_model.dart';
import 'package:reafel_app/sensing/sensingEval.dart';

class SensingBloc{

  SensingEval sensing = SensingEval();

  /// Get the study for HeartWave.
  StudyModel get study => sensing.study != null ? StudyModel(sensing.study) : null;

  void init() async {}

  void start() async => await sensing.start();

  void pause() => sensing.controller.pause();

  void resume() async => sensing.controller.resume();

  void stop() => sensing.stop();

  void dispose() async => sensing.stop();

}

final sensingBloc = SensingBloc();
