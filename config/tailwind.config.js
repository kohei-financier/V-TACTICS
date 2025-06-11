const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        "valorant-color": "#FF4655",
      },
    },
  },
  plugins: [
    require('daisyui'),
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ],
  daisyui: {
    themes: [
      {
        my_light_theme: {
          "primary": "#ff4655",
          "secondary": "#0090ff",
          "accent": "#f97316",
          "neutral": "#001611",
          "base-100": "#f3f4f6",
          "info": "#a3e635",
          "success": "#22d3ee",
          "warning": "#fcd34d",
          "error": "#ef4444",
          },
        my_dark_theme: {
          "primary": "#ff5c6b",  /* ライトテーマの赤に近い明るさで、コントラストを強調 */
          "secondary": "#00aaff", /* ライトテーマの青に近い明るさで、コントラストを強調 */
          "accent": "#ff843a",   /* ライトテーマのオレンジに近い明るさで、コントラストを強調 */
          "neutral": "#d1d5db",  /* やや明るめのテキスト色 */
          "base-100": "#2d3748", /* やや明るめの暗いグレー（チャコールグレーのような色） */
          "info": "#a3e635",     /* ライトテーマの緑を維持、視認性良好 */
          "success": "#22d3ee",  /* ライトテーマの水色を維持、視認性良好 */
          "warning": "#fcd34d",  /* ライトテーマの黄色を維持、視認性良好 */
          "error": "#ef4444",    /* ライトテーマの赤を維持、視認性良好 */
          },
        },
      ],
  },
}
