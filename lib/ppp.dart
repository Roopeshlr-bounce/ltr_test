@JS()
library myjsfile;

import 'package:js/js.dart';

@JS('bouncePlugin')
class BounceDart {
  external static printName(String string);
  external static fetchToken(Function(String token) token);
}