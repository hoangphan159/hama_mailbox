namespace :hamachat do
  desc "Generate 10 users"
  task :generate_users => :environment do
    url = 'https://randomuser.me/api?results=10'

    HTTParty.get(url).parsed_response['results'].each do |person|
      User.create!(
        name: "#{person['name']['first']} #{person['name']['last']}",
        email: "#{person['email']}",
        image_url: "#{person['picture']['medium']}",
        password: "#{person['login']['password']}"
      )
    end
  end
end
