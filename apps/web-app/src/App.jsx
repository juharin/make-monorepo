import { useState, useEffect, useRef } from 'react';
import './App.css';
import { incrementFlutterCounter, initializeReactApi, disposeReactApi } from './flutterBridge';

const App = () => {
  const [message, setMessage] = useState('');
  const [count, setCount] = useState(0);
  const countRef = useRef(count);

  const incrementCounter = () => {
    setCount(prevCount => prevCount + 1);
  };

  useEffect(() => {
    countRef.current = count;
  }, [count]);

  useEffect(() => {
    fetch('http://localhost:8080/api/hello')
      .then(response => response.json())
      .then(data => setMessage(data.message))
      .catch(error => console.error('Error fetching hello endpoint:', error));
    
    // Expose React state setter to global scope
    window.reactAppBridge = {
      incrementReactCount: incrementCounter,
      getCount: () => countRef.current
    };
    
    // Initialize the React API for Flutter
    initializeReactApi();
    
    return () => {
      delete window.reactAppBridge;
      disposeReactApi();
    };
  }, []);

  return (
    <div className="app">
      <nav className="navbar">
        <div className="navbar-brand">
        <img src="/images/react-logo.svg" alt="React Logo" className="logo-react-navbar" />
          <h1>React Host App</h1>
          <a 
            href="https://github.com/juharin/make-monorepo"
            target="_blank"
            rel="noopener noreferrer"
            className="github-link-navbar"
          >
            <img src="/images/github-mark.svg" alt="GitHub Logo" className="logo-github-navbar" />
          </a>
        </div>
      </nav>
      <div className="content">
        <div className="content-header">
          <h1>Embed Flutter apps in React 🤝</h1>
        </div>
        
        <div className="cards-container">
          {/* React Card */}
          <div className="card">
            <div className="card-header">
              <img src="/images/react-logo.svg" alt="React Logo" className="card-logo" />
              <h2 className="card-title">React Counter</h2>
            </div>
            <div className="card-content">
              <div className="counter-display">
                <div className="counter-value">{count}</div>
              </div>
              <div className="button-container">
                <button 
                  onClick={incrementCounter}
                  className="increment-button"
                >
                  + React
                </button>
              </div>
              <div className="button-container">
                <button 
                  onClick={incrementFlutterCounter}
                  className="increment-button"
                >
                  + Flutter
                </button>
              </div>
            </div>
          </div>

          {/* Flutter Card */}
          <div className="card">
            <div className="card-header">
              <img src="/images/flutter-logo.svg" alt="Flutter Logo" className="card-logo" />
              <h2 className="card-title">Embedded Flutter app</h2>
            </div>
            <div className="card-content">
              <div className="flutter-wrapper" data-testid="flutter-wrapper">
                <div id="flutter-container" />
              </div>
            </div>
          </div>

          {/* Go API Card */}
          <div className="card">
            <div className="card-header">
              <img src="/images/Go-Logo_Blue.svg" alt="Go Logo" className="card-logo go" />
              <h2 className="card-title">Go API</h2>
            </div>
            <div className="card-content">
              <p style={{ marginBottom: '10px' }}>Message from Go API server:</p>
              <div className="api-message">
                <span>{message}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <footer className="footer">
        <div className="footer-content">
          <p>Make-based monorepo demonstrating cross-platform integration of React, Flutter, and Go</p>
          <div className="footer-links">
            <a href="https://github.com/juharin/make-monorepo" target="_blank" rel="noopener noreferrer" className="footer-link">
              GitHub Repository
            </a>
            <a href="https://react.dev" target="_blank" rel="noopener noreferrer" className="footer-link">
              React
            </a>
            <a href="https://flutter.dev" target="_blank" rel="noopener noreferrer" className="footer-link">
              Flutter
            </a>
            <a href="https://go.dev" target="_blank" rel="noopener noreferrer" className="footer-link">
              Go
            </a>
          </div>
          <p style={{ marginTop: '1.5rem', fontSize: '0.9rem' }}>{new Date().getFullYear()} 👋 Juha Rinne</p>
        </div>
      </footer>
    </div>
  );
};

export default App;
