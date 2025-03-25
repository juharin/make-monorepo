# Mobile Host App

A Flutter application that demonstrates how to embed the mobile app as a component.

## Overview

This Flutter application serves as a host for the embeddable mobile app, showcasing how to integrate Flutter components within other Flutter applications. It demonstrates proper widget embedding and state management between the host and embedded apps.

## Features

- Embedded mobile app integration
- Counter functionality
- Clean architecture
- State management
- Cross-platform support

## Development

### Prerequisites

- Flutter SDK
- Dart SDK

### Running Locally

1. Navigate to the mobile host app directory:
   ```bash
   cd apps/mobile_host_app
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
make dev-mobile-host
```

### Building

Build the app for Android:
```bash
make build-mobile-host
```

## Project Structure

```
mobile_host_app/
├── lib/
│   └── main.dart      # Application entry point
├── test/              # Test files
└── pubspec.yaml      # Flutter dependencies
```

## Integration with Mobile App

The host app demonstrates how to embed the mobile app:

```dart
import 'package:mobile_app/main.dart' as mobile_app;

// In your Flutter app
Scaffold(
  body: Column(
    children: [
      // Host app content
      Text('Host App Counter: $_counter'),
      
      // Embedded mobile app
      SizedBox(
        height: 300,
        child: mobile_app.MyApp(),
      ),
    ],
  ),
)
```

## Testing

Run tests:
```bash
make test-mobile
```

## Dependencies

- [Mobile App](../mobile_app/README.md) - The embeddable Flutter application
- [API Server](../api-server/README.md) - Backend services

## Architecture

The host app follows these architectural principles:
- Clear separation between host and embedded app
- Independent state management
- Modular widget structure
- Clean integration patterns
