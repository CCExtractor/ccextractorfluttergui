// DEPRECATED, WILL REMVOE FROM GIT SOON. WAS ONLY USED TO PRESERVE SIDEBAR 
// WHEN PREVIEW PAGE WAS SHOWN WHICH IS NOW DEPERATED TOO


// import 'package:ccxgui/screens/dashboard/dashboard.dart';
// import 'package:flutter/material.dart';

// /// Routes for dashboard
// class NestedNavigatorRoutes {
//   static const String dashboard = '/';
//   static const String preview = '/preview';
// }

// /// We use nested navigator to keep the drawer persistent in preview screen too.
// class NestedNavigator extends StatelessWidget {
//   NestedNavigator({required this.navigatorKey});
//   final GlobalKey<NavigatorState> navigatorKey;

//   /// More info for how to pass data in nested navigator here: https://medium.com/coding-with-flutter/flutter-case-study-multiple-navigators-with-bottomnavigationbar-90eb6caa6dbf
//   // ignore: unused_element
//   void _push(BuildContext context) {
//     var routeBuilders = _routeBuilders(
//       context,
//     );

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             routeBuilders[NestedNavigatorRoutes.preview]!(context),
//       ),
//     );
//   }

//   Map<String, WidgetBuilder> _routeBuilders(
//     BuildContext context,
//   ) {
//     return {
//       NestedNavigatorRoutes.dashboard: (context) => Dashboard(),
//       // NestedNavigatorRoutes.preview: (context) => PreviewScreen(),
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     var routeBuilders = _routeBuilders(context);

//     return Navigator(
//         key: navigatorKey,
//         initialRoute: NestedNavigatorRoutes.dashboard,
//         onGenerateRoute: (routeSettings) {
//           return MaterialPageRoute(
//             builder: (context) => routeBuilders[routeSettings.name]!(context),
//           );
//         });
//   }
// }
