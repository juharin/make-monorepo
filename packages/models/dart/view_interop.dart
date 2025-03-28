import 'dart:js_interop';

@JS('initialViewData')
external InitialViewData get initialViewData;

class InitialViewData {
  final String appIdentifier;
  final int randomIntValue;
  
  InitialViewData({required this.appIdentifier, required this.randomIntValue});
}

extension type Time._(JSObject _) implements JSObject {
  external Time(int hours, int minutes);
  external factory Time.onlyHours(int hours);

  external static Time dinnerTime;
  external static Time getTimeDifference(Time t1, Time t2);

  external int hours;
  external int minutes;
  external bool isDinnerTime();

  bool isMidnight() => hours == 0 && minutes == 0;
}
