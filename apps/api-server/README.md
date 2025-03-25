# API Server

A simple Go API server that serves as the backend for the monorepo application.

## Development

To run the development server:

```bash
make dev-api
```

This will start the server on port 8080.

## API Endpoints

- `GET /api/health` - Health check endpoint
- `GET /api/hello` - Simple hello message endpoint

## Building

To build the server:

```bash
make build-api
```

The binary will be created in the `bin` directory.
