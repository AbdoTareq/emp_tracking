import '../../export.dart';

extension NumExtension on num {
  ///same as screenAwareHeight(4, context)
  ///EXAMPLE: 4.rh
  double get rh {
    double drawingHeight = MediaQuery.of(
          navKey.currentContext!,
        ).size.height -
        MediaQuery.of(
          navKey.currentContext!,
        ).padding.top;
    return this * drawingHeight / baseHeight;
  }

  double get rw {
    double drawingWidth = MediaQuery.of(
          navKey.currentContext!,
        ).size.width -
        16;
    return this * drawingWidth / baseWidth;
  }
}
