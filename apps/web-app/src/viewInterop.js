//--------------------------------
//    Call JS from Dart
//--------------------------------

export class InitialViewData {
  constructor(appIdentifier, randomIntValue) {
    this.appIdentifier = appIdentifier;
    this.randomIntValue = randomIntValue;
  }
  
  get appIdentifier() {
    return this._appIdentifier;
  }

  set appIdentifier(value) {
    this._appIdentifier = value;
  }

  get randomIntValue() {
    return this._randomIntValue;
  }

  set randomIntValue(value) {
    this._randomIntValue = value;
  }
}

// Must expose the type to the global scope.
globalThis.InitialViewData = InitialViewData;

export const incrementCounter = () => {
  // Use the React bridge if available
  if (window.reactAppBridge) {
    window.reactAppBridge.incrementCount();
  } else {
    console.warn('React app bridge not available');
  }
};

globalThis.incrementCounter = incrementCounter;

//--------------------------------
//    Call Dart from JS
//--------------------------------

//globalThis.exportedFunction('hello world');
