import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants.dart';

extension NumExtension on num {
  ///same as screenAwareHeight(4, context)
  ///EXAMPLE: 4.rh
  double rh() {
    double drawingHeight = MediaQuery.of(Root.appContext!).size.height -
        MediaQuery.of(Root.appContext!).padding.top;
    return this * drawingHeight / baseHeight;
  }

  double rw() {
    double drawingWidth = MediaQuery.of(Root.appContext!).size.width - 16;
    return this * drawingWidth / baseWidth;
  }
}
