import 'package:flutter/material.dart';
import 'dart:js_interop';
import 'dart:ui_web';
import 'js_bridge.dart' as js_bridge;

int getRandomIntValue(BuildContext context) {
  final int viewId = View.of(context).viewId;
  final jsInitialData = views.getInitialData(viewId) as JSObject;
  final initialData = js_bridge.InitialViewData.fromJS(jsInitialData);
  return initialData.randomIntValue;
}

String getAppIdentifier(BuildContext context) {
  final int viewId = View.of(context).viewId;
  final jsInitialData = views.getInitialData(viewId) as JSObject;
  final initialData = js_bridge.InitialViewData.fromJS(jsInitialData);
  return initialData.appIdentifier;
}

void initializeJsInterop(void Function() func) {
  js_bridge.initializeJsInterop(
    incrementCounterFn: func,
  );
}

void disposeJsInterop() {
  js_bridge.disposeJsInterop();
}

void incrementReactCounter() {
  js_bridge.incrementReactCounter();
}
