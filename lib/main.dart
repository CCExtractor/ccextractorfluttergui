import 'dart:io';
import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/utils/responsive.dart';
import 'package:ccxgui/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('CCExtractor');
    setWindowMinSize(const Size(800, 500));
    setWindowMaxSize(const Size(10000, 10000));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xff2e8fff),
        backgroundColor: kBgDarkColor,
        canvasColor: kBgDarkColor,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}



// Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Current Progress:',
//             ),
//             FutureBuilder(
//                 future: _incrementCounter(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return StreamBuilder(
//                       stream: test(),
//                       initialData: progress.last,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           double test =
//                               double.parse((snapshot.data.toString()));
//                           return CircularPercentIndicator(
//                             radius: 60.0,
//                             lineWidth: 5.0,
//                             percent: test / 100,
//                             center: Text("$test%"),
//                             progressColor: Colors.green,
//                           );
//                         } else if (snapshot.hasError) {
//                           print(snapshot.error);
//                         }

//                         return CircularPercentIndicator(
//                           radius: 60.0,
//                           lineWidth: 5.0,
//                           percent: double.parse(progress.last.toString()) / 100,
//                           center: Text("${progress.last}%"),
//                           progressColor: Colors.green,
//                         );
//                       },
//                     );
//                   }
//                   return CircularProgressIndicator();
//                 }),
//           ],
//         ),
//       ),
