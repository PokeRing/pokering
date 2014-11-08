var express = require('express'),
    router  = express.Router(),
    utils   = require('../../utils');

/* GET users collection */
router.get('/', function(req, res, next) {
    if (!utils.authenticate(req, res, next)) return res.end();
    req.app.get('db').getConnection(function(err, connection) {
        if (err) {
            return next(utils.getError(503, err.code));
        } else {
            utils.sendCollection('users', req.query.page, connection, res, next);
        }
    });
});

/* GET a single user */
router.get('/:username', function(req, res, next) {
    if (!utils.authenticate(req, res, next)) return;
    req.app.get('db').getConnection(function(err, connection) {
        if (err) {
            return next(utils.getError(503, err.code));
        } else {
            utils.sendItem('users', {'username': req.params.username}, res, next);
        }
    });
});

module.exports = router;
