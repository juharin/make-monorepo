import 'package:flutter/material.dart';
import 'dart:js_interop';
import 'dart:ui_web';
import 'multi_view_app.dart' show MultiViewApp;
import 'empty_app.dart' show EmptyApp;
import 'mobile_app.dart' show MobileApp;
import 'js_bridge.dart' show InitialViewData;

void main() {
  // For Flutter web embedding in multi-view mode
  runWidget(
    MultiViewApp(
      viewBuilder: (BuildContext context) {
        final int viewId = View.of(context).viewId;
        final jsInitialData = views.getInitialData(viewId) as JSObject;
        final initialData = InitialViewData.fromJS(jsInitialData);
        if (initialData.appIdentifier == 'mobile_app') {
          return const MobileApp();
        }
        return const EmptyApp();
      },
    ),
  );
}
