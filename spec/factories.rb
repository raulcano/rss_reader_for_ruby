FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
  factory :feed_source do
    title "Test Feed Source"
    url "http://feeds.weblogssl.com/elblogsalmon2"
    hashtags "blog, economia"
    folder_id 0
    user
  end
  
  factory :feed_entry do
    name "Que nos intervengan ya"
    summary "La conclusion que saco de esto es que nos tienen que intervenir ya"
    url "http://www.elblogsalmon.com/historia-de-la-economia/que-alternativa-viable-al-capitalismo-se-os-ocurre"
    feed_source_url "http://feeds.weblogssl.com/elblogsalmon2"
    published_at "2012-05-14 01:09:00.000000"
    guid "http://www.elblogsalmon.com/historia-de-la-economia/que-alternativa-viable-al-capitalismo-se-os-ocurre"
  end
end