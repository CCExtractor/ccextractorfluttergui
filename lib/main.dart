import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/bloc/updater_bloc/updater_bloc.dart';
import 'package:ccxgui/repositories/settings_repository.dart';
import 'package:ccxgui/screens/home.dart';
import 'package:ccxgui/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('CCExtractor');
    setWindowMinSize(const Size(800, 800));
    setWindowMaxSize(const Size(10000, 10000));
  }
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(
    backgroundColor: kBgDarkColor,
    canvasColor: kBgDarkColor,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider<ProcessBloc>(
          create: (context) => ProcessBloc()..add(GetCCExtractorVersion()),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) =>
              SettingsBloc(SettingsRepository())..add(CheckSettingsEvent()),
        ),
        BlocProvider<UpdaterBloc>(
          create: (context) => UpdaterBloc(),
        ),
      ],
      child: MaterialApp(
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            secondary: Color(0xff01bcd6),
          ),
        ),
        home: Home(),
      ),
    );
  }
}

// Logs events and states during transition
class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
