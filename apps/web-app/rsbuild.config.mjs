import { defineConfig } from '@rsbuild/core';
import { pluginReact } from '@rsbuild/plugin-react';

export default defineConfig({
  plugins: [pluginReact()],
  html: {
    title: 'Rsbuild with React',
    tags: [
      {
        tag: 'script',
        attrs: {
          src: 'flutter_bootstrap.js',
          type: 'module',
          async: true,
        },
        append: false,
      },
    ],
  },
  source: {
    entry: {
      index: './src/index.jsx',
    },
    html: {
      template: './public/index.html',
    },
  },
});
