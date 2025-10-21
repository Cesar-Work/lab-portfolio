/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './index.html',
    './src/**/*.{ts,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        lab: {
          bg: '#0a0a0f',
          panel: '#101018',
          accent: '#00fff0',
          amber: '#ffb300'
        }
      },
      fontFamily: {
        mono: ['JetBrains Mono', 'ui-monospace', 'SFMono-Regular', 'Menlo', 'monospace']
      },
      boxShadow: {
        glow: '0 0 30px rgba(0,255,240,0.15)'
      }
    }
  },
  plugins: []
}

