var config  = require('../config/app'),
    auth    = require('basic-auth');

exports.getError = function(status, message) {
    var err = new Error(message);
    err.status = status;
    return err;
}

exports.authenticate = function(req, res, next) {
    req.app.get('db').getConnection(function(err, connection) {
        if (err) {
            return next(exports.getError(503, err.code));
        } else {
            var creds = auth(req);
            if (!creds) {
                res.writeHead(401, { 'WWW-Authenticate': 'Basic realm="Pokering"' });
                res.end();
                return false;
            } else {
                connection.query("SELECT * FROM `users` WHERE `status` = 'active' AND username = '" + creds.name + "' AND pin = '" + creds.pass + "'", function(err, rows, fields) {
                    if (rows.length == 0) {
                        res.writeHead(401, { 'WWW-Authenticate': 'Basic realm="Pokering"' });
                        res.end();
                        return false;
                    }
                    return true;
                });
            }
        }
    });
}

exports.sendCollection = function(table, page, connection, res, next) {
    connection.query('SELECT SQL_CALC_FOUND_ROWS * FROM `' + connection.escape(table) + '` LIMIT ' + (page ? (page - 1) * config.collections.limit : 0) + ',' + config.collections.limit , function(err, rows, fields) {
        if (err) {
            return next(exports.getError(500, err.code));
        }
        connection.query('SELECT FOUND_ROWS() as total', function(err, total) {
            if (err) {
                return next(exports.getError(500, err.code));
            }
            res.send({
                total:  total[0]['total'],
                count:  rows.length,
                page:   page ? page : 1,
                result: rows
            });
            connection.release();
        });
    });
}

exports.sendItem = function(table, fields, res, next) {
    req.app.get('db').getConnection(function(err, connection) {
        if (err) {
            return next(exports.getError(503, err.code));
        } else {
            var condition = "";
            var count = 0;
            for (var field in fields) {
                if (count > 0) condition += " AND ";
                condition += "`" + connection.espace(field) + "` = '" + connection.escape(fields[field]) + "'";
            }
            connection.query('SELECT * FROM `' + connection.escape(table) + '` WHERE ' + condition, function(err, rows, fields) {
                if (err) {
                    return next(exports.getError(500, err.code));
                }
                return res.send(rows);
                connection.release();
            });
        }
    });
}

exports.protectSql = function(string) {

}
