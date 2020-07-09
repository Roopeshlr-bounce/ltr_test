@JS()
library stringify;

import 'package:js/js.dart';

// Calls invoke JavaScript `JSON.stringify(obj)`.
@JS('Print.postMessage')
external String postMessage(Object obj);

@JS('Print.postMessage')
external String postMessage2(Object obj);