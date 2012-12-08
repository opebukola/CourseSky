FactoryGirl.define  do

	factory :user do |u|
		u.fname										"Test"
		u.sequence(:email)				{|n| "user#{n}@example.com"}
		u.lname										"User"
		# u.email 									{Factory.next(:email)} 
		u.password								"password"
		u.password_confirmation		"password"
	end

	factory :grade_level do |g|
		g.name	"Grade 1"
	end


	factory :course do |c|
		c.title "Course 1"
		c.description { Faker::Lorem.paragraphs(1) }

		grade_level
		user	
	end

	factory :unit do |u|
		u.title "Unit 1"

		course
	end

	factory :lesson do |l|
		l.title	"Lesson 1"

		unit
	end

	factory :lesson_item do |l|
		l.skills	{|s| [s.association(:skill)]}

		lesson
	end

	factory :answer do |a|
		a.content "Content"
	end

	factory :skill do |s|
		s.description "Description"
	end

	factory :question do |q|
		q.question_type		"Enter Response"
		q.question_text		"What is 1 + 1?"
		q.difficulty			1
		q.hint						"hint"
		q.answers				{|a| [a.association(:answer)]}		
		q.skills				{|s| [s.association(:skill)]}
	end


	factory :quiz do |q|
		user
		course
		lesson
	end

end