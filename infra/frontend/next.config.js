/** @type {import('next').NextConfig} */

const { i18n } = require('./next-i18next.config.js');

const nextConfig = {
  reactStrictMode: true,
  i18n,
  output: 'standalone', 
  
  // In Next.js 16, turbopack is a stable, top-level key!
  turbopack: {
    // Fixes the "workspace root" warning
    root: __dirname, 
    
    // Your SVG rules
    rules: {
      '*.svg': {
        loaders: ['@svgr/webpack'],
        as: '*.js',
      },
    },
  },
};

module.exports = nextConfig;