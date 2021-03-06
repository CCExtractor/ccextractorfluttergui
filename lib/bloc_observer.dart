// Logs events and states during transition, needs some improvement to reduce spam
// @override
// String toString() => 'Event { prop: prop }';

import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   super.onEvent(bloc, event);

  //   if ({ProcessFileExtractorOutput, ProcessFileExtractorProgress}
  //       .contains(event)) print('onEvent -- ${bloc.runtimeType}, $event');
  // }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   // CurrentSettingsState and ProcessState have a lot of spam
  //   if ({transition.nextState, transition.nextState}
  //           .contains(CurrentSettingsState) ||
  //       {transition.nextState, transition.nextState}.contains(ProcessState)) {
  //     print(transition);
  //   }
  //   super.onTransition(bloc, transition);
  // }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
