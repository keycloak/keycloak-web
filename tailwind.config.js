/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./pages/**/*.ftl",
    "./templates/**/*.ftl",
    "./blog/**/*.ftl",
    "./guides/**/*.ftl"
  ],
  darkMode: 'class',
  theme: {
    extend: {
      fontFamily: {
        headline: ['Manrope', 'ui-sans-serif', 'system-ui', 'sans-serif'],
        body: ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
      colors: {
        primary: {
          DEFAULT: '#006194',
          container: '#007bba',
          fixed: '#cde5ff',
        },
        'on-primary': {
          DEFAULT: '#ffffff',
          fixed: '#001d32',
          'fixed-variant': '#004a75',
        },
        background: '#f7f9ff',
        surface: {
          DEFAULT: '#f7f9ff',
          'container-low': '#f1f4fa',
          'container': '#ebeef4',
          'container-high': '#e5e8ee',
          'container-highest': '#dfe3e9',
          'container-lowest': '#ffffff',
        },
        'on-surface': {
          DEFAULT: '#181c20',
          variant: '#3f4850',
        },
        'outline-variant': '#bfc7d2',
        error: {
          DEFAULT: '#ba1a1a',
          container: '#ffdad6',
        },
        tertiary: '#894d00',
        secondary: {
          container: '#dce2f9',
        },
      },
      borderRadius: {
        'xl': '0.75rem',
        '2xl': '1rem',
        '3xl': '1.5rem',
      },
      spacing: {
        '18': '4.5rem',
        '22': '5.5rem',
      },
    },
  },
  plugins: [],
}
