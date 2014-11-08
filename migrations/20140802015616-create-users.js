var dbm = require('db-migrate');
var type = dbm.dataType;

exports.up = function(db, callback) {
    db.createTable('users', {
        id: { type: 'int', primaryKey: true, autoIncrement: true },
        first_name: { type: 'string', length: 255 },
        last_name: { type: 'string', length: 255 },
        email: { type: 'string', length: 255, notNull: true },
        username: { type: 'string', length: 255 },
        pin: { type: 'int', length: 4 },
        favorite_hand: { type: 'string', length: 45 },
        avatar_url: { type: 'string', length: 255 },
        phone: { type: 'string', length: 45 },
        city: { type: 'string', length: 255 },
        state: { type: 'string', length: 100 },
        notify_via: { type: 'string', length: 45 },
        bio: { type: 'text' },
        status: { type: 'string', length: 45, notNull: true },
        date_created: { type: 'datetime', notNull: true },
        date_updated: { type: 'datetime', notNull: true }
    }, callback);
};

exports.down = function(db, callback) {
    db.dropTable('users', callback);
};
