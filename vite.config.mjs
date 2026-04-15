import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import tailwindcss from '@tailwindcss/vite';
import { loadTranslations } from '@ember-intl/vite';

export default defineConfig({
  plugins: [
    classicEmberSupport(),
    ember(),
    // extra plugins here
    tailwindcss(),
    loadTranslations(),
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
});
