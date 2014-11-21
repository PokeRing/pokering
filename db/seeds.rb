# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all()
User.create([
  {
    first_name: 'Penny',
    last_name: 'Lane',
    email: 'pennylane@getpokering.com',
    username: 'pennylane',
    pin: '1234',
    favorite_hand: '4 of a kind',
    phone: '1235550987',
    city: 'Memphis',
    state: 'TN',
    notify_via: 'email',
    status: 'active'
  },
  {
    first_name: 'George',
    last_name: 'Bladell',
    email: 'g.blad@getpokering.com',
    username: 'g.blad',
    pin: '1234',
    notify_via: 'mobile',
    status: 'active'
  },
  {
    first_name: 'Vinny',
    last_name: 'Goombots',
    email: 'vgooms@getpokering.com',
    username: 'vgooms',
    pin: '1234',
    favorite_hand: 'Royal Flush',
    phone: '1235554387',
    city: 'New York',
    state: 'NY',
    notify_via: 'email',
    bio: 'Hey, my name is Vinny!  I\'ve been made fun of my whole life because of my last name, so I\'ve decided to become good at something to get back at everyone.  And that something is poker.  Are you ready to play me?  Because I bet I will beat you.  I have years and years of turmoil to prove it.',
    status: 'active'
  },
  {
    email: 'kate.grainger@getpokering.com',
    status: 'invited'
  },
  {
    first_name: 'Manny',
    last_name: 'Thomas',
    email: 'mmthomas@getpokering.com',
    username: 'mmthomas',
    pin: '1234',
    notify_via: 'mobile',
    status: 'inactive'
  }
])
