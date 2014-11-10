namespace :tests do
  desc "Runs all tests"
  task run: :environment do
    sh 'RAILS_ENV=tests bin/rake test'
  end

end
