PokeRing Web Application and API
================================

# Overview
The PokeRing web application is built on node.js and the expressjs web framework.  

The frontend is just a single page app.  Express is used to render the single html page at `/`, but aside from that, there are no node/express dependencies for or restrictions on frontend development.

The node/express backend's other and larger use is for serving the API resources under various routes within `/api/`.

# To begin local development
1. Install [node.js](http://nodejs.org/).  If you use [homebrew](http://brew.sh/) on OS X (recommended) you can simply run `brew install node`.
2. Clone this repository, navigate to your cloned repo root, then run `npm install`.
3. Run `npm run debug`.  This will start a development server on your machine, accessible at [http://localhost:3000/](http://localhost:3000/).
4. Frontend files such as html, css, images, and javascript live in the `/public` directory.
5. If working on the backend and/or API, the webapp and API within are built on the [expressjs web framework](http://expressjs.com/).

# Sysadmin stuff

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
5. `sudo npm install -g inherits && sudo npm install -g forever`
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
10. Add the `pokering-test-deploy` job that will simply run `cd /srv/pokering && git pull --rebase origin master && npm install && forever restartall`
11. Update the /etc/nginx/nginx.conf file and restart

http://devblog.daniel.gs/2014/01/deploying-node-apps-on-aws-ec2-with.html

Some considerations:
MongoDB?  Use an IOPS MongoDB install from AWS Marketplace for production DB: 250/month
