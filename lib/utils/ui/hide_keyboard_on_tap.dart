// This is a wrapper widget so that we can dismiss the keyboard when we tap
// away from it.
import 'package:flutter/material.dart'
    show GestureDetector, FocusScope, Widget, BuildContext;

GestureDetector hideKeyboardOnTap({BuildContext context, Widget child}) {
  return GestureDetector(
    onTap: () {
      var currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild.unfocus();
      }
    },
    child: child,
  );
}
