namespace :source do
  desc "Pulls code from the repository and performs necessary cleanup, install tasks after the pull"

  task pull_dev: :environment do
    sh 'git pull --rebase origin master && bundle install --without staging production && bin/rake db:migrate'
  end

  task deploy_staging: :environment do
    sh 'ssh -i ~/.ssh/pokering.pem ubuntu@54.208.252.9 "source ~/.bash_profile && cd /var/www/pokering &&
          git pull --rebase origin master && \
          bundle install --without development && \
          RAILS_ENV=staging bin/rake db:migrate && \
          RAILS_ENV=staging bin/rake db:migrate:status && \
          sudo service nginx restart && \
          touch tmp/restart.txt"'
  end

  task deploy_production: :environment do
    # not implemented yet
  end

end
