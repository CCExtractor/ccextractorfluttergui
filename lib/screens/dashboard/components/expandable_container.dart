import 'package:flutter/material.dart';

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final Widget child;

  ExpandableContainer({
    required this.child,
    this.collapsedHeight = 0.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return new AnimatedContainer(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded
          ? MediaQuery.of(context).size.height * 0.52
          : collapsedHeight,
      child: Container(
        child: child,
      ),
    );
  }
}
