namespace :source do
  desc "Pulls code from the repository and performs necessary cleanup, install tasks after the pull"

  task pull: :environment do
    sh 'git pull --rebase origin master && bundle install && bin/rake db:migrate'
  end

  task deploy_staging: :environment do
    sh 'ssh -i ~/.ssh/pokering.pem -t ubuntu@54.208.252.9 "cd /var/www/pokering && git pull --rebase origin master"'
  end

  task on_deploy: :environment do
    # sh 'bundle install --without development && RAILS_ENV=staging bin/rake db:migrate && sudo service nginx restart'
  end

end
