var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res) {
  res.json([
    {'id': 1, 'name': 'Joe'},
    {'id': 2, 'name': 'Phil'}
  ]);
});

module.exports = router;
