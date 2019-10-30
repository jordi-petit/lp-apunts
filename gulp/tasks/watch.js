'use strict';

// Necessary Plugins
var gulp  = require('gulp');
var paths = require('../paths');

// Call Watch
module.exports = gulp.task('watch', function() {
    gulp.watch([paths.source.slides, paths.source.templates], gulp.parallel('jade'));
    gulp.watch(paths.source.js, gulp.parallel('js'));
    gulp.watch(paths.source.coffee, gulp.parallel('coffee'));
    gulp.watch(paths.source.styl, gulp.parallel('stylus'));
    gulp.watch(paths.source.img, gulp.parallel('imagemin'));
    gulp.watch(paths.source.pdf, gulp.parallel('pdf'));
});
