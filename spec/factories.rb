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

	factory :answer do |a|
		a.content "Answer"
	end

	factory :question do |q|
		q.question_type  "Enter Response"
		q.question_text  "What is 1 + 1?"
		q.difficulty  1
		# q.answers  FactoryGirl.create(:answer, content: "Content")
	end

	
end