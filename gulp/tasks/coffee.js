'use strict';

// Necessary Plugins
var gulp    = require('gulp');
var plumber = require('gulp-plumber');
var uglify  = require('gulp-uglify');
var paths   = require('../paths');

module.exports = gulp.task('coffee', function() {
  return gulp.src(paths.source.coffee)
    .pipe(plumber())
    .pipe(gulp.dest(paths.build.coffee));
});
