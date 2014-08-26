// Include gulp
var gulp = require('gulp');

// Include Our Plugins
var jshint  = require('gulp-jshint'),
    shell   = require('gulp-shell');

// Lint Task
gulp.task('lint-server-js', function() {
    return gulp.src('routes/**/*.js')
        .pipe(jshint())
        .pipe(jshint.reporter('default'));
});

// Watch Files For Changes
gulp.task('watch', function() {
    gulp.watch('routes/**/*.js', ['lint-server-js']);
});

gulp.task('run', shell.task(['./node_modules/supervisor/lib/cli-wrapper.js -e node,js,json start.js']));

// Default Task
gulp.task('default', ['lint-server-js', 'run', 'watch']);
