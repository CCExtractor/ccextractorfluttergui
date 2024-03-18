import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/bloc/updater_bloc/updater_bloc.dart';
import 'package:ccxgui/screens/dashboard/components/custom_snackbar.dart';
import 'package:ccxgui/screens/dashboard/dashboard.dart';
import 'package:ccxgui/screens/settings/basic_settings.dart';
import 'package:ccxgui/screens/settings/hardsubx_settings.dart';
import 'package:ccxgui/screens/settings/input_settings.dart';
import 'package:ccxgui/screens/settings/obscure_settings.dart';
import 'package:ccxgui/screens/settings/output_settings.dart';
import 'package:ccxgui/utils/constants.dart';

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
      child: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _currentIndex,
            extended: true,
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedLabelTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.white54,
            ),
            unselectedLabelTextStyle: TextStyle(
              color: Colors.white54,
            ),
            selectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.secondary,
            ),
            useIndicator: false,
            leading: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SvgPicture.asset(
                  logo,
                  semanticsLabel: 'CCExtractor Logo',
                  height: 80,
                ),
                _CheckForUpdatesButton(),
              ],
            ),
            destinations: [
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 6),
                icon: Icon(Icons.dashboard),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 6),
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: Text('Basic Settings'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 6),
                icon: Icon(Icons.input),
                selectedIcon: Icon(Icons.input),
                label: Text('Input Settings'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 6),
                icon: Icon(Icons.dvr_outlined),
                selectedIcon: Icon(Icons.dvr_outlined),
                label: Text('Output Settings'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 6),
                icon: Icon(Icons.search),
                selectedIcon: Icon(Icons.search),
                label: Text('HardSubx Settings'),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.only(top: 6),
                icon: Icon(Icons.do_disturb_alt_rounded),
                selectedIcon: Icon(Icons.do_disturb_alt_rounded),
                label: Text('Obscure Settings'),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
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
          ),
        ],
      ),
    );
  }
}

class _CheckForUpdatesButton extends StatelessWidget {
  const _CheckForUpdatesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isWindows) return Container();

    return BlocBuilder<ProcessBloc, ProcessState>(
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(25),
          hoverColor: Colors.transparent,
          onTap: () {
            context.read<UpdaterBloc>().add(CheckForUpdates(state.version!));
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
