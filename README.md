PokeRing Web Application and API
================================

# Overview
The PokeRing web application is built on node.js and the expressjs web framework.  

The frontend is just a single page app.  Express is used to render the single html page at `/`, but aside from that, there are no node/express dependencies for or restrictions on frontend development.

The node/express backend's other and larger use is for serving the API resources under various routes within `/api/`.

# To begin local development
1. Install [node.js](http://nodejs.org/).  If you use [homebrew](http://brew.sh/) on OS X (recommended) you can simply run `brew install node`.
2. Install mysql.  Again this is easiest to do through homebrew: `brew install mysql`.  Ensure that mysql is started and is started on startup (easy to follow instructions included at the end of the `brew install`).
3. Run the following from the command line `mysql -uroot -e "CREATE DATABASE pokering" && mysql -uroot -e "CREATE USER 'pokering'@'localhost' IDENTIFIED BY 'p0kerings'" && mysql -uroot -e "GRANT ALL PRIVILEGES ON pokering.* TO 'pokering'@'localhost'" && mysql -uroot -e "FLUSH PRIVILEGES"`.  If you already had mysql installed, and have a root password set, you'll just need to include that password in each of these calls, like `mysql -uroot -p12345 -e "CREATE DATABASE..."`
4. Clone this repository, navigate to your cloned repo root, then run `npm install && npm run migrate`.
5. Run `npm run debug`.  This will start a development server on your machine, accessible at [http://localhost:3000/](http://localhost:3000/).
6. When you need to pull changes from the github repo, there's an npm convenience script `npm run pull` that will fetch, pull, npm prune and install all for you in a single command.
7. Frontend files such as html, css, images, and javascript live in the `/public` directory.
8. If working on the backend and/or API, the webapp and API within are built on the [expressjs web framework](http://expressjs.com/).

# Writing and Running Tests
To run tests, simple execute `npm run test`.  For more info on actually writing and working with tests, check out [this resource](http://devcenter.wercker.com/articles/languages/nodejs/getting-started-express-and-mocha.html).

# Deployments
Test and Production servers are hosted at AWS.  We're making use of [Jenkins CI](http://jenkins-ci.org/) to manage some automation of deployment needs.  After pushing changes to this repo, simply go to http://54.208.252.9:8080, log in with the creds ec2-user, and the common password provided, and you'll be able to run the deployment jobs that are set up there.

# Working with AWS
For sys admins on the project, sshing in to any of the EC2 instances can be done by using the user ec2-user and the pokering.pem identify file.

------------------------------------------------------------------------------

# Node Library Notes
1. We're using [`node-mysql`](https://github.com/felixge/node-mysql) for db connectivity and querying
2. For DB migrations, [`db-migrate`](https://github.com/kunklejr/node-db-migrate)
3. Integration and Unit Testing: [`mocha`](http://visionmedia.github.io/mocha/), [`nodeunit`](https://github.com/caolan/nodeunit), and [`supertest`](https://github.com/visionmedia/supertest)

# Sysadmin Notes
We're not going to use puppet or any sort of server admin automation tool yet.  But, tracking each server set up on EC2 here for now so it could happen at some point if need be.

utility
========
node
openssl
nginx
jenkins

1. Create Amazon Linux AMI
2. Used `pokering.pem` key file as set in the instance creation to SSH in
3. `sudo yum update`
4. `sudo yum install nodejs npm git --enablerepo=epel`
5. `sudo npm install -g inherits`
6. `sudo yum update && sudo yum install nginx && sudo sudo chkconfig nginx on && sudo service nginx start`
7. Install Jenkins (reference [http://sanketdangi.com/post/62715793234/install-configure-jenkins-on-amazon-linux](http://sanketdangi.com/post/62715793234/install-configure-jenkins-on-amazon-linux)):
        
        sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
        sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
        sudo yum install jenkins
        sudo service jenkins start
        sudo chkconfig jenkins on

8. Create deploy key for the jenkins user and add it as a deploy key on Github
        
        sudo -su jenkins
        ssh-keygen -t rsa
        
9. Manually clone the repo as jenkins user on the ec2 instance, then copy to `/srv/`
10. Add the `pokering-test-deploy` job that will simply run `cd /srv/pokering && npm run pull && ./node_modules/forever/bin/forever restartall`
11. One time run directly on the server `cd /srv/pokering && npm start`
12. Update the /etc/nginx/nginx.conf file and restart

http://devblog.daniel.gs/2014/01/deploying-node-apps-on-aws-ec2-with.html

Some considerations:
MongoDB?  Use an IOPS MongoDB install from AWS Marketplace for production DB: 250/month
