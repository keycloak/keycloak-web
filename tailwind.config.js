/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.ftl",
    "./templates/**/*.ftl",
    "./resources/js/**/*.js",
  ],
  theme: {
    extend: {
      colors: {
        // Keycloak brand colors
        primary: {
          DEFAULT: '#428bca',
          hover: '#326d9f',
          light: '#66b3e0',
          dark: '#2c5a7f',
        },
      },
      fontFamily: {
        sans: ['system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'sans-serif'],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
}
