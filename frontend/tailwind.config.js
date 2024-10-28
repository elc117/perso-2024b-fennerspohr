import daisyui from "daisyui";

/** @type {import('tailwindcss').Config} */
export default {
    content: [ "./index.html","./src/App.vue", "./src/**/*.{js,ts,jsx,tsx,vue}", ],
    theme: {
        extend: {},
    },
    plugins: [
        daisyui,
    ],
}

