PokeRing Web Application and API
================================

# Overview
The PokeRing web application is built on node.js and the expressjs web framework.  

The frontend is just a single page app.  Express is used to render the single html page at `/`, but aside from that, there are no node/express dependencies for or restrictions on frontend development.

The node/express backend's other and larger use is for serving the API resources under various routes within `/api/`.

# To begin local development
1. Install ruby 2.1.1, and rails 4.1.2.  [RVM](http://rvm.io/rvm/install) is the recommended way of installing:
        
        \curl -sSL https://get.rvm.io | bash -s stable && source ~/.rvm/scripts/rvm
        rvm install 2.1.1 && rvm use 2.1.1 --default
        gem install rails -v 4.1.2

2. Install mysql.  Again this is easiest to do through homebrew: `brew install mysql`.  Ensure that mysql is started and is started on startup (easy to follow instructions included at the end of the `brew install`).
3. Run the following from the command line `mysql -uroot -e "CREATE DATABASE pokering" && mysql -uroot -e "CREATE USER 'pokering'@'localhost' IDENTIFIED BY 'p0kerings'" && mysql -uroot -e "GRANT ALL PRIVILEGES ON pokering.* TO 'pokering'@'localhost'" && mysql -uroot -e "FLUSH PRIVILEGES"`.  If you already had mysql installed, and have a root password set, you'll just need to include that password in each of these calls, like `mysql -uroot -p12345 -e "CREATE DATABASE..."`
4. Clone this repository, navigate to your cloned repo root, then run `bundle install && bin/rake db:migrate && bin/rake db:seed`.  This will install the ruby gem dependencies, set up your db, and populate it with seed data.
5. Run `rails server`.  This will start a development server on your machine, accessible at [http://localhost:3000/](http://localhost:3000/).
6. When you need to pull changes from the github repo, there's an npm convenience script `` that will fetch, pull, npm prune and install all for you in a single command.
7. Frontend files such as html, css, images, and javascript live in the `/public` directory.

# Writing and Running Tests


# Deployments
Test and Production servers are hosted at AWS.  We're making use of [Jenkins CI](http://jenkins-ci.org/) to manage some automation of deployment needs.  After pushing changes to this repo, simply go to http://http://54.88.174.144/:8080, log in with the creds jenkins, and the common password provided, and you'll be able to run the deployment jobs that are set up there.

# Working with AWS
For sys admins on the project, sshing in to any of the EC2 instances can be done by using the user ubuntu and the pokering.pem identify file.

------------------------------------------------------------------------------

# Node Library Notes
1. We're using [`node-mysql`](https://github.com/felixge/node-mysql) for db connectivity and querying
2. For DB migrations, [`db-migrate`](https://github.com/kunklejr/node-db-migrate)
3. Integration and Unit Testing: [`mocha`](http://visionmedia.github.io/mocha/), [`nodeunit`](https://github.com/caolan/nodeunit), and [`supertest`](https://github.com/visionmedia/supertest)

# Sysadmin Notes

We're not going to use puppet or any sort of server admin automation tool yet.  But, tracking each server set up on EC2 here for now so it could happen at some point if need be.

utility (test server)
========
node
openssl
nginx
jenkins

1. Create EC2 instance using Ubuntu 14.04 LTS AMI
2. Used `pokering.pem` key file as set in the instance creation to SSH in: copy `pokering.pem` to `~/.ssh/`, then ssh in to the instance: `ssh -i ~/.ssh/pokering.pem ubuntu@[public DNS name]`
3. `sudo apt-get update`
4. `gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && curl -L get.rvm.io | bash -s stable && source ~/.rvm/scripts/rvm && rvm requirements`
5. `rvm install 2.1.1 && rvm use 2.1.1 --default`
6. `gem install rails -v 4.1.2`
7. `gem install passenger`
8. `rvmsudo passenger-install-nginx-module` and follow instructions to install any missing dependencies, re-run the above command after
9. `wget -O init-deb.sh http://library.linode.com/assets/660-init-deb.sh && sudo mv init-deb.sh /etc/init.d/nginx && sudo chmod +x /etc/init.d/nginx && sudo /usr/sbin/update-rc.d -f nginx defaults`
10. `sudo service nginx start`
11. Install Jenkins (reference https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu):
        
        wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
        sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
        sudo apt-get update && sudo apt-get install jenkins

Create deploy key for ubuntu user and add to github: `ssh-keygen -t rsa` no passphrase, copy the public key to github
Change Jenkins user to be ubuntu:ubuntu (http://blog.manula.org/2013/03/running-jenkins-under-different-user-in.html)

        # Update $JENKINS_USER and $JENKINS_GROUP to be ubuntu in /etc/default/jenkins
        sudo chown -R ubuntu:ubuntu /var/lib/jenkins
        sudo chown -R ubuntu:ubuntu /var/cache/jenkins
        sudo chown -R ubuntu:ubuntu /var/log/jenkins
        sudo service jenkins restart

12. Set security through Jenkins web interface
13. `sudo apt-get install git && sudo apt-get install libmysqlclient-dev && sudo apt-get install nodejs` 
Manually clone the repo on the ec2 instance, then copy to `/var/www/pokering`
14. Add the `pokering-test-deploy` job that will simply run `cd /var/www/pokering && git pull --rebase origin master && bundle install && RAILS_ENV=test bin/rake db:migrate`
15. Update nginx config:

        server {
            listen 80;
            server_name test.getpokering.com;
            passenger_enabled on;
            root /var/www/pokering/public;
        }

16. `sudo service nginx restart`


RDS
=========
Create RDS instance, straightforward, with database `pokering`.  Connect to it and run:

    ALTER DATABASE pokering DEFAULT COLLATE utf8_unicode_ci;
    ALTER DATABASE pokering DEFAULT CHARACTER SET utf8;

