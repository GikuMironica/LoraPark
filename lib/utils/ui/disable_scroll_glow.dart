import 'package:flutter/widgets.dart'
    show ScrollBehavior, BuildContext, Widget, AxisDirection;

/// DisableScrollGlow
///
/// This is a wrapper class that prevents the blue splash on Android
/// when scrolling to the extreme top, or extreme bottom.
class DisableScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
