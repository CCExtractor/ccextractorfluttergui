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
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('CCExtractor');
      setWindowMinSize(const Size(800, 800));
      setWindowMaxSize(const Size(10000, 10000));
    }
    runApp(
      MyApp(),
    );
  },
    blocObserver: SimpleBlocObserver(),
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
