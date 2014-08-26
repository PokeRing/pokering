var config = require('../config/app');

exports.getError = function(status, message) {
    var err = new Error(message);
    err.status = status;
    return err;
}

exports.sendCollection = function(name, page, connection, res, next) {
    connection.query('SELECT SQL_CALC_FOUND_ROWS * FROM ' + name + ' LIMIT ' + (page ? (page - 1) * config.collections.limit : 0) + ',' + config.collections.limit , function(err, rows, fields) {
        if (err) {
            return next(getError(500, err.code));
        }
        connection.query('SELECT FOUND_ROWS() as total', function(err, total) {
            if (err) {
                return next(getError(500, err.code));
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
