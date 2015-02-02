# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all()
ActiveRecord::Base.connection.execute("ALTER TABLE users AUTO_INCREMENT = 1")
User.create([
  {
    first_name: 'Penny',
    last_name: 'Lane',
    email: 'pennylane@getpokering.com',
    username: 'pennylane',
    password: '1234',
    password_confirmation: '1234',
    favorite_hand: '4 of a kind',
    phone: '1235550987',
    city: 'Memphis',
    state: 'TN',
    notify_via: 'email',
    share: 'full',
    is_admin: false,
    status: 'active'
  },
  {
    first_name: 'George',
    last_name: 'Bladell',
    email: 'g.blad@getpokering.com',
    username: 'g.blad',
    password: '1234',
    password_confirmation: '1234',
    notify_via: 'mobile',
    share: 'basic',
    is_admin: false,
    status: 'active'
  },
  {
    first_name: 'Vinny',
    last_name: 'Goombots',
    email: 'vgooms@getpokering.com',
    username: 'vgooms',
    password: '1234',
    password_confirmation: '1234',
    favorite_hand: 'Royal Flush',
    phone: '1235554387',
    city: 'New York',
    state: 'NY',
    notify_via: 'email',
    bio: 'Hey, my name is Vinny!  I\'ve been made fun of my whole life because of my last name, so I\'ve decided to become good at something to get back at everyone.  And that something is poker.  Are you ready to play me?  Because I bet I will beat you.  I have years and years of turmoil to prove it.',
    share: 'personal',
    is_admin: false,
    status: 'active'
  },
  {
    email: 'kate.grainger@getpokering.com',
    status: 'invited',
    password: '1234',
    password_confirmation: '1234',
    share: 'full',
    is_admin: false
  },
  {
    first_name: 'Manny',
    last_name: 'Thomas',
    email: 'mmthomas@getpokering.com',
    username: 'mmthomas',
    password: '1234',
    password_confirmation: '1234',
    notify_via: 'mobile',
    share: 'full',
    is_admin: false,
    status: 'inactive'
  },
  {
    first_name: 'Mister',
    last_name: 'Admin',
    email: 'admin@getpokering.com',
    username: 'admin',
    password: '1234',
    password_confirmation: '1234',
    notify_via: 'email',
    share: 'basic',
    is_admin: true,
    status: 'active'
  }
])

Ring.delete_all()
ActiveRecord::Base.connection.execute("ALTER TABLE rings AUTO_INCREMENT = 1")
Ring.create([
  {
    title: 'Penny\'s Pokering',
    creator_id: 1,
    status: 'active',
    users: [2,3]
  },
  {
    title: 'Vin',
    creator_id: 3,
    status: 'active',
    users: [1,4]
  },
  {
    title: 'Mannatee',
    creator_id: 4,
    status: 'inactive',
    users: [1,2,3]
  }
])

Trip.delete_all()
ActiveRecord::Base.connection.execute("ALTER TABLE trips AUTO_INCREMENT = 1")
Trip.create([
  {
    organizer_id: 1,
    location: 'Borgata, Atlantic City, NJ',
    arrival_date: '2015-05-09T05:00:00Z',
    departure_date: '2015-05-12T05:00:00Z',
    is_chop_room: true,
    max_players: 4,
    players: '[]',
    notify_rings: true,
    status: 'active'
  },
  {
    organizer_id: 1,
    location: 'caesars palace, las vegas, nv',
    arrival_date: '2015-07-15T05:00:00Z',
    departure_date: '2015-07-20T08:00:00Z',
    is_chop_room: false,
    max_players: 10,
    players: '[2]',
    notify_rings: false,
    status: 'active'
  }
])

Game.delete_all()
ActiveRecord::Base.connection.execute("ALTER TABLE games AUTO_INCREMENT = 1")
Game.create([
  {
    organizer_id: 1,
    name: 'Game 1',
    location: '123 3rd Ave Apt 3, New York, NY',
    date: '2015-05-09T05:00:00Z',
    base_game_type: 'tournament',
    game_type: 'holdem',
    limit_type: 'no-limit',
    stakes: 1.5,
    buy_in: 1.5,
    re_buy_in: 1.5,
    buy_in_min: 1.5,
    buy_in_max: 1.5,
    min_players: 1,
    max_players: 1,
    players: '[2,3]',
    status: 'active'
  },
  {
    organizer_id: 1,
    name: 'Game 2',
    location: '124 3rd Ave Apt 3, New York, NY',
    date: '2015-04-31T20:54:38Z',
    base_game_type: 'cash',
    game_type: 'holdem',
    limit_type: 'no-limit',
    stakes: 1.5,
    buy_in: 1.5,
    re_buy_in: 1.5,
    buy_in_min: 1.5,
    buy_in_max: 1.5,
    min_players: 1,
    max_players: 1,
    players: '[3,6]',
    status: 'active'
  }
])

Comment.delete_all()
ActiveRecord::Base.connection.execute("ALTER TABLE comments AUTO_INCREMENT = 1")
Comment.create([
  {
    parent_type: 'games',
    parent_id: 1,
    commenter_id: 1,
    comment: 'Just wanted to say I like this game',
    status: 'active'
  },
  {
    parent_type: 'trips',
    parent_id: 1,
    commenter_id: 1,
    comment: 'Just wanted to say I like this trip',
    status: 'active'
  }
])

Invite.delete_all()
ActiveRecord::Base.connection.execute("ALTER TABLE invites AUTO_INCREMENT = 1")
Invite.create([
  {
    parent_type: 'games',
    parent_id: 1,
    invited_id: 3,
    status: 'outstanding'
  },
  {
    parent_type: 'trips',
    parent_id: 1,
    invited_id: 3,
    status: 'accepted'
  }
])

Request.delete_all()
ActiveRecord::Base.connection.execute("ALTER TABLE requests AUTO_INCREMENT = 1")
Request.create([
  {
    parent_type: 'games',
    parent_id: 1,
    requester_id: 3,
    request_type: 'invite',
    status: 'active'
  }
])
