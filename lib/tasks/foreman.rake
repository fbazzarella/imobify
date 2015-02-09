namespace :foreman do
  task export: :environment do
    sh "rvmsudo foreman export upstart /etc/init -a #{ENV['APP_NAME']}-#{Rails.env} -u #{ENV['APP_USER']}"
  end

  task restart: :environment do
    sh "sudo service #{ENV['APP_NAME']}-#{Rails.env} restart"
  end
end
