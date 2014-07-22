// Include gulp
var gulp = require('gulp');

// Include Our Plugins
var jshint = require('gulp-jshint');
var shell = require('gulp-shell');

// Lint Task
gulp.task('lint-server-js', function() {
  return gulp.src('routes/**/*.js')
    .pipe(jshint())
    .pipe(jshint.reporter('default'));
});

// Watch Files For Changes
gulp.task('watch', function() {
    gulp.watch('routes/**/*.js', ['lint-server']);
});

gulp.task('run', shell.task(['node start.js']));

// Default Task
gulp.task('default', ['lint-server-js', 'run', 'watch']);
