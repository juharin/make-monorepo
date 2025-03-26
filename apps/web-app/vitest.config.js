import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./src/test/setup.js'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'src/test/setup.js',
        '**/*.d.ts',
        '**/*.test.{js,jsx}',
        '**/*.spec.{js,jsx}',
      ],
    },
    deps: {
      inline: ['vitest-canvas-mock'],
    },
    // Add Node.js polyfills for CI environment
    browser: {
      enabled: true,
      name: 'jsdom',
      provider: 'jsdom',
    },
  },
}); 