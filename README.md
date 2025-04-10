# Embed Flutter Monorepo

A demonstration of building modular applications in a monorepo structure, focusing on embedding Flutter apps within different host applications (web, mobile). This project showcases how to create and integrate different types of applications while sharing code and maintaining a clean architecture using Make for build orchestration.

## Project Structure

```
.
├── apps/
│   ├── api-server/     # Go backend API server
│   ├── mobile_app/     # Embeddable Flutter app
│   ├── mobile_host_app/# Flutter app that embeds mobile_app
│   └── web-app/        # React web app that embeds mobile_app
├── bin/                # Compiled binaries
├── scripts/           # Build and utility scripts
└── Makefile          # Build orchestration
```

## Applications

- [API Server](apps/api-server/README.md) - Go backend providing REST API endpoints
- [Mobile App](apps/mobile_app/README.md) - Embeddable Flutter application
- [Mobile Host App](apps/mobile_host_app/README.md) - Flutter application that embeds the mobile app
- [Web App](apps/web-app/README.md) - React application that embeds the mobile app

## Key Features

- **Modular Architecture**: Each application is self-contained but can be integrated with others
- **Code Sharing**: Common code and models can be shared across applications
- **Build Orchestration**: Unified build system using Make
- **Cross-Platform**: Support for web and mobile platforms
- **Flutter Web**: Demonstration of Flutter web embedding in React

## Getting Started

### Prerequisites

- Go 1.21 or later
- Flutter SDK
- Node.js and npm
- Make

### Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:juharin/embed-flutter.git
   cd embed-flutter
   ```

2. Install dependencies:
   ```bash
   make deps
   ```

3. Build all applications:
   ```bash
   make build
   ```

### Development

Start development servers:

- API server: `make dev-api`
- Embeddable app for web: `make dev-mobile-web`
- Embeddable app: `make dev-mobile`
- Web app: `make dev-web`
- Mobile host app: `make dev-mobile-host`

### Testing

Run all tests:
```bash
make test
```

### Linting and Formatting

- Run linters: `make lint`
- Format code: `make format`

## Build Commands

- `make build` - Build all applications
- `make build-web` - Build web app
- `make build-api` - Build API server
- `make build-mobile` - Build mobile app
- `make build-mobile-host` - Build mobile host app
- `make build-mobile-web` - Build mobile app for web

## Clean Up

Remove build artifacts:
```bash
make clean
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
