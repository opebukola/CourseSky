FactoryGirl.define  do

	factory :user do |u|
		u.email 									"test@example.com"
		u.password								"password"
		u.password_confirmation		"password"
	end

	factory :course do |c|
		c.title "Course 1"
		c.description { Faker::Lorem.paragraphs(1) }
		user
	end
	
end