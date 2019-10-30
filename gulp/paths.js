'use strict';

module.exports = {
  source: {
    templates: './src/templates/**/*.jade',
    slides: './src/slides/*.md',
    js: './src/js/**/*.js',
    coffee: './src/coffee/**/*.coffee',
    styl: './src/styl/**/*.styl',
    img: './src/img/**/*',
    pdf: './src/pdf/**/*',
    files: {
      jade: './src/templates/*.jade',   // he canviat aquesta línia per tenir múltiples presentacions al mateix directori
      styl: './src/styl/main.styl'
    }
  },

  browserSync: {
    html: './build/**/*.html',
    css: './build/css/**/*.css',
    js: './build/js/**/*.js',
    coffee: './build/coffee/**/*.coffee',
    img: './build/img/**/*',
    pdf: './build/pdf/**/*'
  },

  build: {
    html: './build/',
    css: './build/css',
    js: './build/js',
    coffee: './build/coffee',
    img: './build/img',
    pdf: './build/pdf'
  },

  deploy: {
    pages: './build/**/*'
  }
};
