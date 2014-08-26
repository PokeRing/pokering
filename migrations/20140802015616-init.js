var dbm = require('db-migrate');
var type = dbm.dataType;

exports.up = function(db, callback) {
    db.createTable('users', {
        id: { type: 'int', primaryKey: true, autoIncrement: true },
        first_name: 'string',
        last_name: 'string'
    }, callback);
};

exports.down = function(db, callback) {

};
