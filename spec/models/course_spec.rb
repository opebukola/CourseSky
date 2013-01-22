# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  cover_image :string(255)
#  description :text
#  published   :boolean          default(FALSE)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cover_video :string(255)
#

require 'spec_helper'

describe	Course do
	let(:user) {FactoryGirl.create(:user)}
	let(:unit) {FactoryGirl.create(:unit)}
	before do
	  @course = Course.new(title: "Course 1", 
	  										description: "Description",
	  										cover_video: "http://www.youtube.com/watch?v=2_QdgNsopkM")
	  @course.user = user
	  @course.units << unit
	end

	subject {@course}

	it { should respond_to(:title) }
	it { should respond_to(:cover_image) }
	it { should respond_to(:cover_video) }
	it { should respond_to(:description) }
	it { should respond_to(:units) }
	it { should respond_to(:user) }
	its(:user) { should == user }
	it { should respond_to(:lessons) }
	it { should respond_to(:concepts) }
	it { should respond_to(:skills) }

	it { should be_valid }

	describe "without title" do
		before { @course.title = nil  }
		it { should_not be_valid }
	end

	describe "without description" do
		before { @course.description = nil }
		it { should_not be_valid }
	end

	describe "without user" do
		before { @course.user = nil }
		it { should_not be_valid }
	end

	describe "without cover_video" do
		before { @course.cover_video = nil }
		it { should_not be_valid }
	end

	describe "#questions_attempted(user)" do
		it "should return all course questions user has tried" do
			unit = FactoryGirl.create(:unit)
		  lesson1 = FactoryGirl.create(:lesson, unit: unit)
		  @course.units << unit
		  @course.save


			q1 = FactoryGirl.create(:question, lesson: lesson1)	
      q2 = FactoryGirl.create(:question, lesson: lesson1)
      q3 = FactoryGirl.create(:question, lesson: lesson1)
      a1 = user.attempts.build
      a1.question = q1
      a1.save
      a2 = user.attempts.build
      a2.question = q2
      a2.save 
      a3 = user.attempts.build
      a3.question = q1
      a3.save

      @course.save

      @course.questions_attempted(user).should_not be_empty
      @course.questions_attempted(user).should include (q1)
      @course.questions_attempted(user).size == 2
		end
	end

	describe "#completed_lessons(user)" do
		it "should return lessons in course user has finished" do

			unit = FactoryGirl.create(:unit)
		  lesson1 = FactoryGirl.create(:lesson, unit: unit)
		  lesson2 = FactoryGirl.create(:lesson, unit: unit)
		  @course.units << unit
		  @course.save

		  lesson1.completed_by?(user) == true

			@course.completed_lessons(user).should_not be_empty
			@course.completed_lessons(user).should include(lesson1)
			
		end
	end

	# describe "#progress(user)" do
	# 	it "should return nothing if user is not enrolled" do
	# 		@course.progress(user).should be_nil
	# 	end
	# end

	describe "completed_by?(user)" do
		it "should be true if user has finished all course lessons" do
			unit = FactoryGirl.create(:unit)
		  lesson1 = FactoryGirl.create(:lesson, unit: unit)
		  lesson2 = FactoryGirl.create(:lesson, unit: unit)
		  @course.units << unit
		  @course.save

		  lesson1.completed_by?(user) == true
		  lesson2.completed_by?(user) == true

		  pp @course.completed_lessons(user)

		  @course.completed_by?(user).should be_true

		  lesson3 = FactoryGirl.create(:lesson, unit: unit)
		  @course.completed_by?(user).should_not be_true

		end
	end

	# describe "#practiced_skills(user)" do
	# 	it "should return list of skills in course user has worked on" do
	# 		skill = FactoryGirl.create(:skill)
	# 		question = FactoryGirl.create(:question)
	# 		skill.questions << question
	# 		@course.skills << skill
	# 		@course.save

	# 		quiz = FactoryGirl.create(:quiz)
	# 		attempt1 = quiz.attempts.build
	# 		attempt1.user = user
	# 		attempt1.question = question
	# 		attempt1.correct = false
	# 		attempt1.save

	# 		@course.practiced_skills(user).should_not be_empty
	# 		@course.practiced_skills(user).size == 1

	# 	end
		
	# end
end
