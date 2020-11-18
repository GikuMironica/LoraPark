// This is a wrapper widget so that we can dismiss the keyboard when we tap
// away from it.
import 'package:flutter/material.dart' show GestureDetector, Widget, WidgetsBinding;

GestureDetector hideKeyboardWrapper({Widget child}) {
  return GestureDetector(
      onTap: () =>
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: child);
}
