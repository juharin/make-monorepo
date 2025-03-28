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

// Need to expose the type to the global scope.
globalThis.InitialViewData = InitialViewData;
