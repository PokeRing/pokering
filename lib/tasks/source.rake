namespace :source do
  desc "Pulls code from the repository and performs necessary cleanup, install tasks after the pull"

  task pull_dev: :environment do
    sh 'git pull --rebase origin master && bundle install --without staging production && bin/rake db:migrate'
  end

  task deploy_staging: :environment do
    sh 'ssh -i ~/.ssh/pokering.pem ubuntu@54.208.252.9 "source ~/.bash_profile && cd /var/www/pokering &&
          git pull --rebase origin master && \
          RAILS_ENV=staging bin/rake source:on_deploy && \
          bundle install --without development && \
          RAILS_ENV=staging bin/rake db:migrate && sudo service nginx restart"'
  end

end
