# API Server

A Go-based REST API server that provides backend services for the monorepo applications.

## Overview

This API server is built using Go and provides REST endpoints that can be consumed by both the web and mobile applications in the monorepo.

## Features

- RESTful API endpoints
- JSON response format
- CORS support for web integration
- Modular architecture

## API Endpoints

### GET /api/hello

Returns a greeting message.

**Response:**
```json
{
    "message": "Hello from Go API!"
}
```

## Development

### Prerequisites

- Go 1.21 or later

### Running Locally

1. Navigate to the API server directory:
   ```bash
   cd apps/api-server
   ```

2. Install dependencies:
   ```bash
   go mod download
   ```

3. Run the server:
   ```bash
   go run ./cmd/server
   ```

Or use the Make command from the root:
```bash
make dev-api
```

The server will start on `http://localhost:8080`.

### Building

Build the API server:
```bash
make build-api
```

The binary will be created in the `bin` directory as `api-server`.

## Testing

Run tests:
```bash
make test-api
```

## Project Structure

```
api-server/
├── cmd/
│   └── server/        # Main application entry point
├── internal/          # Internal packages
├── pkg/              # Public packages
└── go.mod           # Go module definition
```

## Integration

The API server is designed to be consumed by:
- [Web App](../web-app/README.md)
- [Mobile App](../mobile_app/README.md)
- [Mobile Host App](../mobile_host_app/README.md)
