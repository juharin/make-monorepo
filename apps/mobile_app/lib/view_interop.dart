import 'dart:js_interop';
import 'dart:js_interop_unsafe';

//@JSExport()
extension type InitialViewData._(JSObject _) implements JSObject {
  external InitialViewData(String appIdentifier, int randomIntValue);
  external String appIdentifier;
  external int randomIntValue;

  static InitialViewData fromJS(JSObject jsObject) {
    final appId = (jsObject['appIdentifier'] as JSString).toDart;
    int randomInt = (jsObject['randomIntValue'] as JSNumber).toDartInt;
    return InitialViewData(appId, randomInt);
  }
}

@JS()
external void incrementCounter();
