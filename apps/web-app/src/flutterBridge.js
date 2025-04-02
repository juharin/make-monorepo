// Class representing the initial data to pass
// from JS to Flutter when adding a new view
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

// Must expose the type to the global scope
globalThis.InitialViewData = InitialViewData;

// Increments the React counter when called from Flutter
export const incrementReactCounter = () => {
  if (window.reactAppBridge?.incrementReactCount) {
    window.reactAppBridge.incrementReactCount();
    return true;
  }
  console.warn('React app bridge not available');
  return false;
};

// Expose the function to the global scope for Flutter to access
globalThis.incrementReactCounter = incrementReactCounter;

// Increments the Flutter counter when called from JS
export const incrementFlutterCounter = () => {
  if (globalThis.incrementFlutterCount) {
    globalThis.incrementFlutterCount();
    return true;
  }
  console.warn('Flutter counter function not available');
  return false;
};

// Initializes the React API for Flutter to call
export const initializeReactApi = () => {
  // Already initialized above with globalThis.incrementReactCounter
};

// Cleans up the React API when component unmounts
export const disposeReactApi = () => {
  delete globalThis.incrementReactCounter;
};
