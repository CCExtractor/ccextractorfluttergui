import 'dart:io';
import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/screens/home.dart';
import 'package:ccxgui/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

LocalStorage storage = LocalStorage("config.json");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await initializeSettings(false);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('CCExtractor');
    setWindowMinSize(const Size(800, 800));
    setWindowMaxSize(const Size(10000, 10000));
  }
  runApp(MyApp());
}

Future initializeSettings(bool force) async {
  await storage.ready;
  if (!outputFormats.contains(await storage.getItem("output_format")) ||
      await storage.getItem("output_file_name") is! String ||
      await storage.getItem("append") is! bool ||
      await storage.getItem("autoprogram") is! bool ||
      force) {
    await storage.setItem("output_format", "srt");
    await storage.setItem("output_file_name", "");
    await storage.setItem("append", false);
    await storage.setItem("autoprogram", true);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProcessBloc>(
          create: (context) => ProcessBloc(),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Color(0xff01bcd6),
          backgroundColor: kBgDarkColor,
          canvasColor: kBgDarkColor,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}

// Logs events and states during transition
class SimpleBlocObserver extends BlocObserver {
  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   print(transition);
  //   super.onTransition(bloc, transition);
  // }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
