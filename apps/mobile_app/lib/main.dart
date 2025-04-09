import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'mobile_app.dart' show MobileApp;

import 'web/entry_point.dart' if (dart.library.io) 'stub/entry_point.dart';

void main() {
  if (kIsWeb) {
    // Call the web-specific initialization
    initializeWebApp();
  } else {
    runApp(const MobileApp());
  }
}
