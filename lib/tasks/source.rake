namespace :source do
  desc "Pulls code from the repository and performs necessary cleanup, install tasks after the pull"
  task pull: :environment do
    sh 'git pull --rebase origin master && bundle install && bin/rake db:migrate'
  end

end
