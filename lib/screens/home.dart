import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navigation_rail/navigation_rail.dart';

import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/screens/dashboard/dashboard.dart';
import 'package:ccxgui/screens/settings/basic_settings.dart';
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
  @override
  Widget build(BuildContext context) {
    return NavRail(
      desktopBreakpoint: 1150,
      hideTitleBar: true,
      drawerHeaderBuilder: (context) {
        return Column(
          children: <Widget>[
            DrawerHeader(
              child: SvgPicture.asset(
                logo,
                semanticsLabel: 'CCExtractor Logo',
              ),
            ),
            BlocBuilder<ProcessBloc, ProcessState>(
              builder: (context, state) {
                return Text(
                  state.version!.trim(),
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor),
                );
              },
            ),
          ],
        );
      },
      drawerFooterBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 16),
          child: MaterialButton(
            hoverColor: Colors.transparent,
            onPressed: () {}, // TODO: implement check for updates
            child: Row(
              children: [
                Icon(
                  Icons.update,
                  color: Colors.white54,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Check for updates',
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ],
            ),
          ),
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
          label: 'Obscure Settings',
          icon: Icon(Icons.do_disturb_alt_rounded),
        ),
      ],
    );
  }
}
