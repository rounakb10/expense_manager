import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:git_demo2/Screens/add_expense_screen.dart';

class FAB extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;
  final Widget page;
  final String tooltipText;
  FAB({
    this.width,
    this.height,
    this.color,
    this.icon,
    this.onClick,
    this.page,
    this.tooltipText,
  });

  @override
  Widget build(BuildContext context) {
    if (page == null)
      return Container(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        width: width,
        height: height,
        child: IconButton(
          icon: icon,
          tooltip: 'Add',
          enableFeedback: true,
          onPressed: onClick,
        ),
      );
    return OpenContainer(
      closedColor: Colors.transparent,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      transitionDuration: Duration(milliseconds: 400),
      closedBuilder: (BuildContext c, VoidCallback action) => Container(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        width: width,
        height: height,
        child: IconButton(
          icon: icon,
          tooltip: tooltipText,
          enableFeedback: true,
          onPressed: action,
        ),
      ),
      openBuilder: (BuildContext c, VoidCallback action) => page,
      tappable: false,
    );
  }
}
