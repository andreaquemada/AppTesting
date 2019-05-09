
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:reafel_app/blocs/sensing_bloc.dart';

class StudyModel{
  Study study;

  String get name => study.name;
  String get description => study.description ?? 'Who wrote the description? Not me. Then who?';
  String get userID => study.id;
  String get samplingStategy => study.samplingStrategy;
  String get dataEndPoint => study.dataEndPoint.toString();

  /// Events on the state of the study executor
  Stream<ProbeState> get studyExecutorStateEvents => sensingBloc.sensing.controller.executor.stateEvents;

  /// Current state of the study executor (e.g., resumed, paused, ...)
  ProbeState get studyState => sensingBloc.sensing.controller.executor.state;

  /// Get all sesing events (i.e. all [Datum] objects being collected).
  Stream<Datum> get samplingEvents => sensingBloc.sensing.controller.events;

  /// The total sampling size so far since this study was started.
  int get samplingSize => sensingBloc.sensing.controller.samplingSize;

  StudyModel(this.study)
      : assert(study != null, 'A StudyModel must be initialized with a real Study.'),
        super();
}
