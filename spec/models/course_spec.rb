# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  cover_image    :string(255)
#  description    :text
#  published      :boolean          default(FALSE)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  featured       :boolean          default(FALSE)
#  subject_id     :integer
#  grade_level_id :integer
#

require 'spec_helper'

describe	Course do
	let(:user) {FactoryGirl.create(:user)}
	before do
	  @course = Course.new(title: "Course 1", description: "Description")
	  @course.user = user
	end

	subject {@course}

	it { should respond_to(:units) }
	it { should respond_to(:user) }
	its(:user) { should == user }
	it { should respond_to(:cover_image) }
	it { should respond_to(:description) }
	it { should respond_to(:skills) }
	it { should respond_to(:lessons) }
	it { should respond_to(:lesson_items) }

	it { should be_valid }

	describe "#progress(user)" do
		it "should return nothing if user is not enrolled" do
			@course.progress(user).should be_nil
		end
	end

	describe "#lessons_completed_by(user)" do
		it "should return lessons in course that user has finished" do
			unit = FactoryGirl.create(:unit)
		  lesson1 = FactoryGirl.create(:lesson, unit: unit)
		  lesson2 = FactoryGirl.create(:lesson, unit: unit)
		  @course.units << unit
		  @course.save

		end
	end

	describe "#practiced_skills(user)" do
		it "should return list of skills in course user has worked on" do
			skill = FactoryGirl.create(:skill)
			question = FactoryGirl.create(:question)
			skill.questions << question
			@course.skills << skill
			@course.save

			quiz = FactoryGirl.create(:quiz)
			attempt1 = quiz.attempts.build
			attempt1.user = user
			attempt1.question = question
			attempt1.correct = false
			attempt1.save

			@course.practiced_skills(user).should_not be_empty
			@course.practiced_skills(user).size == 1

		end
		
	end
end