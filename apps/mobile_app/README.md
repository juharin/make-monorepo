# Mobile App

An embeddable Flutter application designed to be integrated into both web and mobile applications.

## Overview

This Flutter application is designed to be modular and embeddable, allowing it to be used as a component in both web and mobile applications. It demonstrates the concept of creating reusable Flutter components that can be shared across different platforms.

## Features

- Counter functionality
- Responsive design
- Web embedding support
- Mobile embedding support
- Cross-platform compatibility

## Development

### Prerequisites

- Flutter SDK
- Dart SDK

### Running Locally

1. Navigate to the mobile app directory:
   ```bash
   cd apps/mobile_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

Or use the Make command from the root:
```bash
make dev-mobile
```

### Web Development

To run the app in web mode:
```bash
make dev-mobile-web
```

### Building

Build the app for different platforms:

- Android APK:
  ```bash
  make build-mobile
  ```

- Web:
  ```bash
  make build-mobile-web
  ```

## Project Structure

```
mobile_app/
├── lib/
│   ├── main.dart      # Application entry point
│   └── multi_view_app.dart  # Web embedding support
├── test/              # Test files
└── pubspec.yaml      # Flutter dependencies
```

## Integration

This app can be embedded in:
- [Web App](../web-app/README.md) - Using Flutter web
- [Mobile Host App](../mobile_host_app/README.md) - Using Flutter widget embedding

## Web Embedding

The app supports web embedding through the `multi_view_app.dart` module, which provides:
- Proper initialization for web context
- Support for multiple Flutter views
- Integration with web frameworks

## Testing

Run tests:
```bash
make test-mobile
```

## Usage Example

```dart
import 'package:mobile_app/main.dart' as mobile_app;

// In your Flutter app
Scaffold(
  body: mobile_app.MyApp(),
)
```
