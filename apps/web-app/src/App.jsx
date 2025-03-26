import { useState, useEffect } from 'react';
import './App.css';

const App = () => {
  const [message, setMessage] = useState('');
  const [count, setCount] = useState(0);

  useEffect(() => {
    fetch('http://localhost:8080/api/hello')
      .then(response => response.json())
      .then(data => setMessage(data.message))
      .catch(error => console.error('Error fetching hello endpoint:', error));
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
            onClick={() => {
              setCount(count + 1);
              //window.flutterApp.instance
            }}
            className="increment-button"
          >
            Increment
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
