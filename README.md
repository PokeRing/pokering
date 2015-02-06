PokeRing Web Application and API
================================

# Overview
The PokeRing web application is built with Ruby on Rails.  

The frontend is just a single page app.  Rails is used to render the single html page at `/`, but aside from that, there are no Rails dependencies for or restrictions on frontend development.  It is designed to be an isolated frontend development experience.

Rail's larger use is for serving the API resources under various routes within `/api/...`.

# To begin local development
1. Install ruby 2.2.0, and rails 4.1.2. [RVM](http://rvm.io/rvm/install) is the recommended way of installing:
        
        \curl -sSL https://get.rvm.io | bash -s stable && source ~/.rvm/scripts/rvm
        rvm install 2.2.0 && rvm use 2.2.0 --default
        gem install rails -v 4.1.2

2. Install mysql.  Again this is easiest to do through homebrew: `brew install mysql`.  Ensure that mysql is started and is started on startup (easy to follow instructions included at the end of the `brew install`).
3. Run the following from the command line `mysql -uroot -e "CREATE DATABASE pokering" && mysql -uroot -e "CREATE DATABASE pokeringtests" && mysql -uroot -e "CREATE USER 'pokering'@'localhost' IDENTIFIED BY 'p0kerings'" && mysql -uroot -e "GRANT ALL PRIVILEGES ON pokering.* TO 'pokering'@'localhost'" && mysql -uroot -e "GRANT ALL PRIVILEGES ON pokeringtests.* TO 'pokering'@'localhost'" && mysql -uroot -e "FLUSH PRIVILEGES"`.  If you already had mysql installed, and have a root password set, you'll just need to include that password in each of these calls, like `mysql -uroot -p12345 -e "CREATE DATABASE..."`
4. Clone this repository, navigate to your cloned repo root, then run `bin/rake source:pull_dev && bin/rake db:seed`.  This will install the ruby gem dependencies, set up your db, and populate it with seed data.
5. Run `rails server`.  This will start a development server on your machine, accessible at [http://localhost:3000/](http://localhost:3000/).
6. When you need to pull changes from the github repo, there's an npm convenience script `bin/rake source:pull_dev` that will pull the most recent master code and perform necessary cleanup, migrations, etc after the pull.  If you're working on a feature branch you'll need to run all the commands manually.  See `lib/tasks/source.rake` to see everything that happens.
7. Frontend files such as html, css, images, and javascript live in the `/public` directory.

# API Documentation
Once up and running locally, API docs can be found at [http://localhost:3000/api/v1/docs](http://localhost:3000/api/v1/docs).

# Application Notifications
The API utilizes server-sent events for the `/api/v1/notifications` controller. There's a demo page with example code for connecting to and handling the stream of real-time results from this API resource: `/public/sse-notifications-demo.html`.  We'll want to remove this file at some point before deploying to production for the first time.  Useful in getting development rolling for this functionality on the front-end.

I will say that things like sockets and server sent events are still fairly fragile.  We may determine for browser compatibility, consistency, or stability that falling back to AJAX long polling for real-time notifications is the way to go.

# Writing and Running Tests
To run tests: `bin/rake test`.  Unit and integration testing via default Rails capabilities within the `test` directory.

Running cURL tests manually, this is a generally good reference: `curl -v --user pennylane:1234 -X POST -d '{"parent_type": "games", "parent_id": 1, "invited_id": 3}' http://localhost:3000/api/v1/invites`

# Deployments
Staging and Production servers are hosted at AWS.  To deploy, you'll need the appropriate `pokering.pem` key to connect over SSH.  Ask an admin for the key, and once you have it, put it in `~/.ssh/` on your local machine.

1. Deploying to staging: `bin/rake source:deploy_staging`
2. Deploying to production: `bin/rake source:deploy_production`

# Working with AWS
For sys admins on the project, sshing in to any of the EC2 instances can be done by using the user ubuntu and the pokering.pem identify file.

------------------------------------------------------------------------------

# Sysadmin Notes

We're not going to use puppet or any sort of server admin automation tool yet.  But, tracking each server set up on EC2 here for now so it could happen at some point if need be.

dev/utility server setup notes (elastic IP of 54.208.252.9)
========
The same instructions should apply when setting up the production server, replacing "staging" refs with "production", beefing up the AWS settings, etc.

1. Create EC2 instance using Ubuntu 14.04 LTS AMI
2. Used `pokering.pem` key file as set in the instance creation to SSH in: copy `pokering.pem` to `~/.ssh/`, then ssh in to the instance: `ssh -i ~/.ssh/pokering.pem ubuntu@54.208.252.9`
3. `sudo apt-get update`
4. Install RVM: `gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && curl -L get.rvm.io | bash -s stable && source ~/.rvm/scripts/rvm && rvm requirements`
5. Install Ruby: `rvm install 2.2.0 && rvm use 2.2.0 --default`
6. Install Rails and Passenger gems: `gem install --no-rdoc --no-ri rails -v 4.1.2 && gem install --no-rdoc --no-ri passenger`
7. Install Nginx w/ Passenger Support: `rvmsudo passenger-install-nginx-module` and follow instructions to install any missing dependencies, re-run the above command after.
8. Install service scripts: `wget -O init-deb.sh https://www.linode.com/docs/assets/660-init-deb.sh && sudo mv init-deb.sh /etc/init.d/nginx && sudo chmod +x /etc/init.d/nginx && sudo /usr/sbin/update-rc.d -f nginx defaults`
9. Start nginx: `sudo service nginx start`
10. Install git: `sudo apt-get install git`
11. Install MySQL utilities (necessary for mysql2 gem): `sudo apt-get install libmysqlclient-dev`
12. Create deploy key for ubuntu user and add to github: `ssh-keygen -t rsa` no passphrase, copy the public key to github
13. `cd /var && sudo mkdir -p www/pokering && cd www && sudo chown ubuntu:ubuntu pokering`
14. (from the `/var/www` directory) Clone the app repo: `git clone git@github.com:PokeRing/pokering.git pokering`
15. `cd pokering && bundle install --without development && RAILS_ENV=staging bin/rake db:migrate` (seed the DB if desired: `RAILS_ENV=staging bin/rake db:seed`)
16. Update nginx config (probably at `/opt/nginx/conf/nginx.conf`):

        server {
            listen 80;
            server_name test.getpokering.com;
            passenger_enabled on;
            rails_env staging;
            root /var/www/pokering/public;
        }

17. Restart nginx `sudo service nginx restart`

RDS
=========
Create RDS instance, straightforward, with database `pokering`.  Connect to it and run:

    ALTER DATABASE pokering DEFAULT COLLATE utf8_unicode_ci;
    ALTER DATABASE pokering DEFAULT CHARACTER SET utf8;

