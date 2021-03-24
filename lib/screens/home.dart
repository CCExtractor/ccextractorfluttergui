import 'package:ccxgui/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navigation_rail/navigation_rail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final String logo = 'assets/ccx.svg';
  @override
  Widget build(BuildContext context) {
    return NavRail(
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
          ],
        );
      },
      currentIndex: _currentIndex,
      onTap: (val) {
        if (mounted)
          setState(() {
            _currentIndex = val;
          });
      },
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Dashboard(),
          Container(color: Colors.red[300]),
          Container(color: Colors.purple[300]),
          Container(color: Colors.grey[300]),
        ],
      ),
      tabs: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: "Dashboard",
          icon: Icon(Icons.dashboard),
        ),
        BottomNavigationBarItem(
          label: "Settings",
          icon: Icon(Icons.settings),
        ),
        BottomNavigationBarItem(
          label: "Option",
          icon: Icon(Icons.folder),
        ),
        BottomNavigationBarItem(
          label: "Option",
          icon: Icon(Icons.camera),
        ),
      ],
    );
  }
}
