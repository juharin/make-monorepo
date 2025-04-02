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
          <h1>React x Flutter</h1>
        </div>
      </nav>
      <div className="content">
        <div className="logo-container">
          <img src="/images/react-logo.svg" alt="React Logo" className="logo-react" />
          <img src="/images/flutter-logo.svg" alt="Flutter Logo" className="logo-flutter" />
        </div>
        <p>Bundling with Rsbuild. Calls a Go API and embeds a Flutter view.</p>
        <div className="api-message">
          <img src="/images/Go-Logo_Blue.svg" alt="Go Logo" className="logo-go" />
          <span>{message}</span>
        </div>
        <p>You have clicked the button {count} times</p>
        <div className="button-container">
          <button 
            onClick={incrementCounter}
            className="increment-button"
          >
            Increment
          </button>
        </div>
        <div className="button-container">
          <button 
            onClick={incrementFlutterCounter}
            className="increment-button"
          >
            Increment Flutter counter
          </button>
        </div>
        <div
          className="flutter-wrapper"
          data-testid="flutter-wrapper"
        >
          <div
            id="flutter-container"
          />
        </div>
      </div>
    </div>
  );
};

export default App;
