import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants.dart';

extension NumExtension on num {
  ///same as screenAwareHeight(4, context)
  ///EXAMPLE: 4.rh
  double rh() {
    double drawingHeight = MediaQuery.of(
          navKey.currentContext!,
        ).size.height -
        MediaQuery.of(
          navKey.currentContext!,
        ).padding.top;
    return this * drawingHeight / baseHeight;
  }

  double rw() {
    double drawingWidth = MediaQuery.of(
          navKey.currentContext!,
        ).size.width -
        16;
    return this * drawingWidth / baseWidth;
  }
}
