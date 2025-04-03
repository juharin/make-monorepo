{{flutter_js}}
{{flutter_build_config}}

// Import the InitialViewData class
import { InitialViewData } from './flutterBridge.js';

// Create a global object to hold Flutter-related functionality
window.flutterApp = window.flutterApp || {};

_flutter.loader.load({
  onEntrypointLoaded: async function onEntrypointLoaded(engineInitializer) {
    let engine = await engineInitializer.initializeEngine({
      multiViewEnabled: true, // Enables embedded mode.
    });
    let app = await engine.runApp();
    // Make Flutter app instance available globally
    window.flutterApp.instance = app;
    // Add the Flutter view to our container
    app.addView({
      hostElement: document.getElementById('flutter-container'),
      initialData: new InitialViewData('mobile_app', Math.floor(Math.random() * 100)),
    });
  }
});
