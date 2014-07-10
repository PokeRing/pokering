PokeRing Web Application and API
================================

# To begin local development (may not work on Windows)
1. Install [node.js](http://nodejs.org/).  If you use [homebrew](http://brew.sh/) on OS X, you can simply run `brew install node`.
2. Clone this repository, navigate to your cloned repo root, then run `npm install`.
3. Run `npm start`.  This will start a development server on your machine, accessible at [http://localhost:3000/](http://localhost:3000/).
4. Frontend files, html, javascript, etc go in the `/public` directory.
5. If working on the API, the webapp and API within are built on the [expressjs web framework](http://expressjs.com/).

# Process used for setting up the Utility EC2 Instance
1. Create Amazon Linux AMI
2. Used `pokering.pem` key file as set in the instance creation to SSH in
3. `sudo yum update`
4. `sudo yum install nodejs npm --enablerepo=epel`
5. Follow instructions at [http://sanketdangi.com/post/62715793234/install-configure-jenkins-on-amazon-linux](http://sanketdangi.com/post/62715793234/install-configure-jenkins-on-amazon-linux) to install jenkins
6. `sudo npm install -g inherits && sudo npm install -g express && sudo npm install -g socket.io`

Some considerations:
Use an IOPS MongoDB install from AWS Marketplace for production DB: 250/month
