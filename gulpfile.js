// Include gulp
var gulp = require('gulp');

// Include Our Plugins
var jshint = require('gulp-jshint');

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

gulp.task('run', function() {
  var debug = require('debug')('PokeRing');
  var app = require('./app');

  app.set('port', process.env.PORT || 3000);

  var server = app.listen(app.get('port'), function() {
    debug('Express server listening on port ' + server.address().port);
  });
});

// Default Task
gulp.task('default', ['lint-server-js', 'run', 'watch']);
