namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_courses
    make_lessons
    make_featured
  end
end

def make_users
  5.times do |n|
    username = "example-user#{n+1}"
    email = "example-#{n+1}@example.com"
    password = "password"
    User.create!(username:    username,
                email:        email,
                password:     password,
                password_confirmation: password,
                remember_me:  true )
  end
end


def make_courses
  users = User.all
  2.times do |n|
    title = Faker::Lorem.sentence(1)
    description = Faker::Lorem.paragraphs(1)
    users.each { |user| user.courses.create!(title: title, 
                            description: description,
                            published: true)}
  end
end

def make_lessons
  courses = Course.all
  4.times do |n|
    title = Faker::Lorem.sentence(1)
    ipaper_id = 101072330 
    ipaper_key = "key-1v0tyd70e4py9qvtcd5q" 
    video_url = 'http://www.youtube.com/watch?v=p_o4aY7xkXg'
    courses.each { |course| course.lessons.create!(title: title,
                            document_ipaper_id: ipaper_id,
                            document_ipaper_access_key: ipaper_key,
                            video_url: video_url,
                            user_id: course.user.id)}
  end
end

def make_featured
  courses = Course.all(limit:5)
  courses.each do |course|
    course.toggle!(:featured)
  end
end