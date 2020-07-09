@JS()
library callable_function;

import 'package:js/js.dart';

/// Allows assigning a function to be callable from `window.functionName()`
@JS('functionName')
external set _functionName(void Function(String) f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void functionName();

void _someDartFunction(String string) {
  print('Hello from Dart! $string');
}

void main() {
  _functionName = allowInterop(_someDartFunction);
  // JavaScript code may now call `functionName()` or `window.functionName()`.
}