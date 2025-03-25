# Web App

A React application that demonstrates how to embed the Flutter app in a web context.

## Overview

This React application showcases how to integrate a Flutter web app within a modern web application. It demonstrates proper initialization, communication, and styling between React and Flutter components.

## Features

- Flutter web embedding
- React components
- API integration
- Modern UI design
- Responsive layout

## Development

### Prerequisites

- Node.js and npm
- Flutter SDK (for web support)

### Running Locally

1. Navigate to the web app directory:
   ```bash
   cd apps/web-app
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

Or use the Make command from the root:
```bash
make dev-web
```

### Building

Build the web app:
```bash
make build-web
```

## Project Structure

```
web-app/
├── src/
│   ├── App.jsx        # Main application component
│   ├── App.css        # Application styles
│   └── main.jsx       # Application entry point
├── public/            # Static assets
└── package.json       # Node.js dependencies
```

## Integration with Flutter

The web app demonstrates how to embed the Flutter app:

```jsx
// In your React component
<div className="flutter-wrapper">
  <div id="flutter-container"></div>
</div>
```

## API Integration

The web app communicates with the Go API server:

```javascript
useEffect(() => {
  fetch('http://localhost:8080/api/hello')
    .then(response => response.json())
    .then(data => setMessage(data.message))
    .catch(error => console.error('Error:', error));
}, []);
```

## Styling

The app uses CSS modules for styling:
```css
.flutter-wrapper {
  display: flex;
  justify-content: center;
  width: 100%;
  margin-top: 20px;
}

#flutter-container {
  width: 75vw;
  height: 500px;
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 8px;
  position: relative;
  overflow: hidden;
}
```

## Testing

Run tests:
```bash
make test-web
```

## Dependencies

- [Mobile App](../mobile_app/README.md) - The embeddable Flutter application
- [API Server](../api-server/README.md) - Backend services

## Build Process

1. Build the Flutter web app:
   ```bash
   make build-mobile-web
   ```

2. Build the React app:
   ```bash
   make build-web
   ```

The build process ensures that:
- Flutter web assets are copied to the correct location
- React app is built with proper optimizations
- All dependencies are properly resolved
