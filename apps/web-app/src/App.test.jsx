import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import App from './App';
// Import the functions to be mocked
import * as flutterBridge from './flutterBridge';

// Mock the flutterBridge module
vi.mock('./flutterBridge', () => ({
  incrementFlutterCounter: vi.fn(),
  initializeReactApi: vi.fn(),
  disposeReactApi: vi.fn(),
}));

// Mock the fetch function
global.fetch = vi.fn();

describe('App', () => {
  beforeEach(() => {
    // Reset mocks before each test
    vi.resetAllMocks();
    // Provide a default mock implementation for fetch
    global.fetch.mockImplementation(() =>
      Promise.resolve({
        ok: true, // Ensure ok is true for successful responses
        json: () => Promise.resolve({ message: 'Hello from Go API!' })
      })
    );
    // Reset window bridge if it exists from previous tests
    if (window.reactAppBridge) {
      delete window.reactAppBridge;
    }
  });

  afterEach(() => {
    // Clean up window object
     if (window.reactAppBridge) {
      delete window.reactAppBridge;
    }
  });


  it('renders the app with initial state and calls initializeReactApi', () => {
    render(<App />);

    // Check for updated main title
    expect(screen.getByText('React Host App')).toBeInTheDocument();
    // Check for initial counter value (use getByText with careful matching)
    expect(screen.getByText('0', { selector: '.counter-value' })).toBeInTheDocument();
    // Check for buttons using more specific name matching
    expect(screen.getByRole('button', { name: /\+ React/i })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /\+ Flutter/i })).toBeInTheDocument();
    // Check for Flutter wrapper
    expect(screen.getByTestId('flutter-wrapper')).toBeInTheDocument();
    // Check if initializeReactApi was called on mount
    expect(flutterBridge.initializeReactApi).toHaveBeenCalledTimes(1);
  });

  it('increments React counter when "+ React" button is clicked', () => {
    render(<App />);

    const reactButton = screen.getByRole('button', { name: /\+ React/i });
    fireEvent.click(reactButton);

    // Check if counter display updated
    expect(screen.getByText('1', { selector: '.counter-value' })).toBeInTheDocument();
    fireEvent.click(reactButton);
    expect(screen.getByText('2', { selector: '.counter-value' })).toBeInTheDocument();
  });

  it('calls incrementFlutterCounter when "+ Flutter" button is clicked', () => {
    render(<App />);

    const flutterButton = screen.getByRole('button', { name: /\+ Flutter/i });
    fireEvent.click(flutterButton);

    // Check if the mocked function was called
    expect(flutterBridge.incrementFlutterCounter).toHaveBeenCalledTimes(1);
  });


  it('calls disposeReactApi on unmount', () => {
    const { unmount } = render(<App />);

    // Ensure initialize was called
    expect(flutterBridge.initializeReactApi).toHaveBeenCalledTimes(1);

    // Unmount the component
    unmount();

    // Check if disposeReactApi was called
    expect(flutterBridge.disposeReactApi).toHaveBeenCalledTimes(1);
  });

  it('sets up window.reactAppBridge correctly and allows external increment', async () => {
     render(<App />);

     // Wait for useEffect to run and setup the bridge
     await waitFor(() => {
       expect(window.reactAppBridge).toBeDefined();
       expect(window.reactAppBridge.incrementReactCount).toBeInstanceOf(Function);
       expect(window.reactAppBridge.getCount).toBeInstanceOf(Function);
     });

     // Check initial count via bridge
     expect(window.reactAppBridge.getCount()).toBe(0);

     // Increment count using the bridge function
     window.reactAppBridge.incrementReactCount();

     // Check if UI updated - wrap in waitFor
     await waitFor(() => {
       expect(screen.getByText('1', { selector: '.counter-value' })).toBeInTheDocument();
     });
     // Check count via bridge again
     expect(window.reactAppBridge.getCount()).toBe(1);
  });


  it('displays API message when fetch succeeds', async () => {
    // Mock successful API response (redundant due to beforeEach, but good for clarity)
    global.fetch.mockResolvedValueOnce({
      ok: true,
      json: () => Promise.resolve({ message: 'Mock API Success!' })
    });

    render(<App />);

    // Wait for the API message to appear
    // Use findByText for asynchronous elements
    const message = await screen.findByText('Mock API Success!');
    expect(message).toBeInTheDocument();
  });

  it('handles API fetch error gracefully', async () => {
    // Mock failed API response
    const apiError = new Error('API Network Error');
    global.fetch.mockRejectedValueOnce(apiError);

    // Spy on console.error to check if error is logged
    const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {});

    render(<App />);

    // Wait for the error handling logic (e.g., console log) to execute
    await waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Error fetching hello endpoint:', apiError);
    });

    // Ensure no error message is displayed in the UI (unless designed to)
    expect(screen.queryByText(/error/i)).not.toBeInTheDocument();

    consoleSpy.mockRestore(); // Clean up the spy
  });

  // Add test for API response not ok
  it('handles API response not ok gracefully', async () => {
    global.fetch.mockResolvedValueOnce({
      ok: false,
      status: 404,
      statusText: 'Not Found',
       // Mock json() needed because App.jsx might still try to parse
       // even if we throw an error before it. Best to keep it.
      json: () => Promise.resolve({ error: 'Not found' })
    });

    const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {});

    render(<App />);

    await waitFor(() => {
       // Now that App.jsx throws an error, consoleSpy should be called with the string first.
      expect(consoleSpy).toHaveBeenCalledWith(
        'Error fetching hello endpoint:', 
        expect.objectContaining({ 
          message: expect.stringContaining('HTTP error! status: 404') 
        })
      );
    });
     // Ensure no error message is displayed in the UI (unless designed to)
    expect(screen.queryByText(/error/i)).not.toBeInTheDocument();

    consoleSpy.mockRestore();
  });

}); 