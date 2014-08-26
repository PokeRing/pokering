var express         = require('express'),
    path            = require('path'),
    logger          = require('morgan'),
    cookieParser    = require('cookie-parser'),
    bodyParser      = require('body-parser'),
    mysql           = require('mysql');

var app = express();

var config      = require('./config/app');
var dbConfig    = require('./config/database');
config.database = dbConfig[app.get('env')];

var db = mysql.createPool({
    host     : config.database.host,
    user     : config.database.user,
    password : config.database.password,
    database : config.database.database
});

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.set('db', db);

/************ BEGIN ROUTES *************/

// This is the only route for the actual webapp, a single page app, so just serving the index html
var index = require('./app/routes/index');
app.use('/', index);

// All others here are API resources
var users = require('./app/routes/api/users');
app.use('/api/users', users);

/************ END ROUTES ***************/

/// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

/// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.send('<h1>' + err.message + '</h1><h2>' + err.status + '</h2><pre>' + err.stack + '</pre>');
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.json({
        message: err.message,
        status: err.status
    });
});

module.exports = app;
