import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import App from './App';

// Mock the fetch function
global.fetch = vi.fn();

describe('App', () => {
  beforeEach(() => {
    // Reset fetch mock before each test
    vi.resetAllMocks();
    // Provide a default mock implementation
    global.fetch.mockImplementation(() => 
      Promise.resolve({
        json: () => Promise.resolve({ message: 'Hello from Go API!' })
      })
    );
  });

  it('renders the app with initial state', () => {
    render(<App />);
    
    // Check for main elements
    expect(screen.getByText('React x Flutter')).toBeInTheDocument();
    expect(screen.getByText('You have clicked the button 0 times')).toBeInTheDocument();
    expect(screen.getByRole('button', { class: 'increment-button' })).toBeInTheDocument();
  });

  it('increments counter when button is clicked', () => {
    render(<App />);
    
    const button = screen.getByRole('button', { class: 'increment-button' });
    fireEvent.click(button);
    
    expect(screen.getByText('You have clicked the button 1 times')).toBeInTheDocument();
  });

  it('displays API message when fetch succeeds', async () => {
    // Mock successful API response
    global.fetch.mockResolvedValueOnce({
      json: () => Promise.resolve({ message: 'Hello from Go API!' })
    });

    render(<App />);
    
    // Wait for the API message to appear
    const message = await screen.findByText('Hello from Go API!');
    expect(message).toBeInTheDocument();
  });

  it('handles API error gracefully', async () => {
    // Mock failed API response
    global.fetch.mockRejectedValueOnce(new Error('API Error'));

    // Mock console.error to prevent test output
    const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {});

    render(<App />);
    
    // Wait for any state updates
    await vi.waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Error fetching hello endpoint:', expect.any(Error));
    });

    consoleSpy.mockRestore();
  });
}); 