'use strict';

// Necessary Plugins
var gulp = require('gulp');

// Default task
//module.exports = gulp.task('default', ['js', 'coffee', 'jade', 'stylus', 'imagemin', 'watch', 'browser-sync']);

module.exports = gulp.task('default', gulp.parallel(['js', 'coffee', 'jade', 'stylus', 'imagemin', 'pdf', 'zip', 'watch', 'browser-sync']));
