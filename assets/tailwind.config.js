const colors = require("tailwindcss/colors");

module.exports = {
  content: [
    "../lib/*_web/**/*.*ex",
    "./js/**/*.js",
    "../deps/petal_components/**/*.*ex",
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: colors.pink,
        secondary: colors.blue,
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require("@tailwindcss/forms")
  ],
  darkMode: "class",
};