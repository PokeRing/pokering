var express = require('express'),
    router  = express.Router(),
    utils   = require('../../utils');

/* GET users collection */
router.get('/', function(req, res, next) {
    req.app.get('db').getConnection(function(err, connection) {
        if (err) {
            return next(utils.getError(503, err.code));
        } else {
            utils.sendCollection('users', req.query.page, connection, res, next);
        }
    });
});

/* GET a single user */
router.get('/:id', function(req, res) {
    if (req.params.id == 1) {
        res.json({'id': 1, 'name': 'Joe'});
    } else if (req.params.id == 2) {
        res.json({'id': 2, 'name': 'Phil'});
    } else {
        throw utils.getError(404, 'User not found');
    }
});

module.exports = router;
