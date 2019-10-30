'use strict';

// Necessary Plugins
var gulp    = require('gulp');
var plumber = require('gulp-plumber');
var paths   = require('../paths');

// Call Uglify and concat JS
module.exports = gulp.task('pdf', function() {
  return gulp.src(paths.source.pdf)
    .pipe(plumber())
    .pipe(gulp.dest(paths.build.pdf));
});
