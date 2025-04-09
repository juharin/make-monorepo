import 'dart:js_interop';
import 'dart:js_interop_unsafe';

// Represents the initial data passed from JavaScript to Flutter
extension type InitialViewData._(JSObject _) implements JSObject {
  external InitialViewData(String appIdentifier, int randomIntValue);
  external String appIdentifier;
  external int randomIntValue;

  // Creates an InitialViewData from a generic JavaScript object
  static InitialViewData fromJS(JSObject jsObject) {
    // Fix the property access to use proper JS interop
    final appId = jsObject.getProperty('appIdentifier'.toJS) as JSString;
    final randomInt = jsObject.getProperty('randomIntValue'.toJS) as JSNumber;
    return InitialViewData(appId.toDart, randomInt.toDartInt);
  }
}

// JavaScript to Dart interop functions
@JS()
external void incrementReactCounter();

// Dart to JavaScript interop functions
@JS()
external set incrementFlutterCount(JSFunction value);

// Registers all exportable Dart functions to JavaScript 
void initializeJsInterop({
  required void Function() incrementCounterFn,
}) {
  incrementFlutterCount = incrementCounterFn.toJS;
}

// Unregisters all exportable Dart functions from JavaScript
void disposeJsInterop() {
  // No direct way to "unset", but we can replace with a no-op function
  incrementFlutterCount = (() {}).toJS;
}
