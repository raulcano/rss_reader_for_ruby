namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
	admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
	
	users = User.all(limit: 6)

    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
	 # Fill some data for the feed_source table
  url1 = "http://elmundo.feedsportal.com/elmundo/rss/portada.xml"
  title1 = "El Mundo"
  hashtags1 = "periodico, nacional"
  
  url2 = "http://feeds.weblogssl.com/elblogsalmon2"
  title2 = "El Blog Salmon"
  hashtags2 = "blog, economia, nacional"
  
  url3 = "http://feeds.weblogssl.com/elblogsalmon2"
  title3 = "El Blog Salmon"
  hashtags3 = "blog, economia, nacional"
	
   users = User.all(limit: 3)
   users.each do |user|
     user.feed_sources.create!(url: url1, title: title1, hashtags: hashtags1)
     user.feed_sources.create!(url: url2, title: title2, hashtags: hashtags2)
     user.feed_sources.create!(url: url3, title: title3, hashtags: hashtags3)
   end
  end
end