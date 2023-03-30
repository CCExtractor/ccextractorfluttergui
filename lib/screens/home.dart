import 'dart:io';

import 'package:ccxgui/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navigation_rail/navigation_rail.dart';

import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/bloc/updater_bloc/updater_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:ccxgui/screens/dashboard/dashboard.dart';
import 'package:ccxgui/screens/settings/basic_settings.dart';
import 'package:ccxgui/screens/settings/hardsubx_settings.dart';
import 'package:ccxgui/screens/settings/input_settings.dart';
import 'package:ccxgui/screens/settings/obscure_settings.dart';
import 'package:ccxgui/screens/settings/output_settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;
  final String logo = 'assets/ccx.svg';
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdaterBloc, UpdaterState>(
      listener: (context, state) {
        if (state.updateAvailable) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Update available\n\nChangelog:'),
                content: Container(
                  width: 800,
                  child: Markdown(
                      controller: scrollController,
                      selectable: true,
                      shrinkWrap: true,
                      data: state.changelog),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<UpdaterBloc>()
                            .add(DownloadUpdate(state.downloadURL));
                      },
                      child: const Text('Download'),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          CustomSnackBarMessage.show(
              context, 'You are already on the latest version');
        }
      },
      child: NavRail(
        desktopBreakpoint: 1150,
        hideTitleBar: true,
        drawerHeaderBuilder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DrawerHeader(
                child: SvgPicture.asset(
                  logo,
                  semanticsLabel: 'CCExtractor Logo',
                ),
              ),
              BlocBuilder<ProcessBloc, ProcessState>(
                builder: (context, state) {
                  return Column(
                    children: [_checkForUpdates(state)],
                  );
                },
              ),
            ],
          );
        },
        currentIndex: _currentIndex,
        onTap: (val) {
          if (mounted && _currentIndex != val) {
            setState(() {
              _currentIndex = val;
            });
          }
        },
        body: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            Dashboard(),
            BasicSettingsScreen(),
            InputSettingsScreen(),
            OutputSettingsScreen(),
            HardSubxSettingsScreen(),
            ObscureSettingsScreen(),
          ],
        ),
        tabs: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Dashboard',
            icon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            label: 'Basic Settings',
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: 'Input Settings',
            icon: Icon(Icons.input),
          ),
          BottomNavigationBarItem(
            label: 'Output Settings',
            icon: Icon(Icons.dvr_outlined),
          ),
          BottomNavigationBarItem(
            label: 'HardSubx Settings',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Obscure Settings',
            icon: Icon(Icons.do_disturb_alt_rounded),
          ),
        ],
      ),
    );
  }

  Widget _checkForUpdates(ProcessState state) {
    if (!Platform.isWindows) return Container();

    return BlocBuilder<ProcessBloc, ProcessState>(
      builder: (context, processState) {
        return InkWell(
          borderRadius: BorderRadius.circular(25),
          hoverColor: Colors.transparent,
          onTap: () {
            context
                .read<UpdaterBloc>()
                .add(CheckForUpdates(processState.version!));
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: kBgLightColor,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Icon(
                      Icons.update,
                      color: Colors.white54,
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          'Check for updates',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Text(
                      'V${state.version!.trim()}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
