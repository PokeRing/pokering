var express = require('express'),
    router  = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
    res.sendfile(__dirname + '/public/index.html');
});

module.exports = router;
