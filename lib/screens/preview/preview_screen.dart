// import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
// import 'package:ccxgui/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:percent_indicator/percent_indicator.dart';

// class PreviewScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Summary"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: BlocBuilder<ProcessBloc, ProcessState>(
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: ListView(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       color: kBgLightColor,
//                       width: MediaQuery.of(context).size.width,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           children: [
//                             state.video != null
//                                 ? Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                           "Resolution: ${state.video!.resolution}",
//                                           style: TextStyle(fontSize: 18)),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                           "Aspect ratio: ${state.video!.aspectRatio}",
//                                           style: TextStyle(fontSize: 18)),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                           "Frame rate: ${state.video!.frameRate}",
//                                           style: TextStyle(fontSize: 18)),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text("Encoding: ${state.video!.encoding}",
//                                           style: TextStyle(fontSize: 18)),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                           "Target format: ${state.video!.targetFormat}",
//                                           style: TextStyle(fontSize: 18)),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text("Frame rate: 29.97",
//                                           style: TextStyle(fontSize: 18)),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ],
//                                   )
//                                 : CircularProgressIndicator(),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     LinearPercentIndicator(
//                       percent: int.parse(state.progress!) / 100,
//                       center: Text("${state.progress!}%"),
//                       lineHeight: 24,
//                       progressColor: Colors.green,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Logs",
//                       style: TextStyle(fontSize: 24),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     LogsView(),
//                   ],
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class LogsView extends StatefulWidget {
//   @override
//   _LogsViewState createState() => _LogsViewState();
// }

// class _LogsViewState extends State<LogsView> {
//   ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProcessBloc, ProcessState>(
//       builder: (context, state) {
//         if (state.logs != null) {
//           WidgetsBinding.instance!.addPostFrameCallback(
//             (_) {
//               _scrollController.jumpTo(
//                 _scrollController.position.maxScrollExtent,
//               );
//             },
//           );
//           return Container(
//             color: kBgLightColor,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.4,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Scrollbar(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         state.logs![index],
//                         style: TextStyle(
//                           color: state.logs![index]
//                                   .contains(RegExp(r"\d+:\d+-\d+:\d+"))
//                               ? Colors.amber
//                               : Colors.white,
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: state.logs!.length,
//                 ),
//               ),
//             ),
//           );
//         } else
//           return CircularProgressIndicator();
//       },
//     );
//   }
// }
