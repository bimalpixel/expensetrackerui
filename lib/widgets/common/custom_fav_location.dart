import 'package:flutter/material.dart';

class CustomFabLocation extends FloatingActionButtonLocation {
  final double offset;

  const CustomFabLocation(this.offset);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX =
        (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2;

    final double fabY =
        scaffoldGeometry.contentBottom -
        scaffoldGeometry.floatingActionButtonSize.height / 2 -
        offset;

    return Offset(fabX, fabY);
  }
}
