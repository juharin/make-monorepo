import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;
import 'dart:js_interop' as js_interop;
import 'multi_view_app.dart' show MultiViewApp;
import 'empty_app.dart' show EmptyApp;
import 'mobile_app.dart' show MobileApp;

void main() {
  // For Flutter web embedding in multi-view mode
  runWidget(
    MultiViewApp(
      viewBuilder: (BuildContext context) {
        final int viewId = View.of(context).viewId;
        final initialData = ui_web.views.getInitialData(viewId) as InitialViewData;
        if (initialData.appIdentifier == 'mobile-app') {
          return const MobileApp();
        }
        return const EmptyApp();
      },
    ),
  );
}

class InitialViewData {
  final String appIdentifier;
  InitialViewData({required this.appIdentifier});
}

