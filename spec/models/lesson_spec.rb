# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  document   :text
#  unit_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Lesson do
	let(:unit) {FactoryGirl.create(:unit)}
	let (:user) { FactoryGirl.create(:user)}
	before { @lesson = unit.lessons.build(title: "Lorem Ipsum") }

	subject {@lesson}

	it { should respond_to(:title) }
	it { should respond_to(:unit) }	
	it { should respond_to(:position) }
	it { should respond_to(:course) }
	it { should respond_to(:lesson_activities) }
	it { should respond_to(:concepts) }
	it { should respond_to(:questions) }
	it { should respond_to(:skills) }

	it { should be_valid }

	describe "without a unit" do
		before { @lesson.unit_id = nil }
  	it { should_not be_valid }
	end

  describe "when title is not present" do
  	before { @lesson.title = nil }
  	it { should_not be_valid }
  end

  describe "#cfu_questions" do
    it "should return cfus only" do
      q1 = FactoryGirl.create(:question, lesson: @lesson)
      q2 = FactoryGirl.create(:question, lesson: @lesson)
      q3 = FactoryGirl.create(:question)

      @lesson.cfu_questions.should_not be_empty
      @lesson.cfu_questions.should include(q1)
      @lesson.cfu_questions.size == 2
    end
  end

  describe "#cfu_attempted(user)" do
    it "should return questions user has attempted" do
      q1 = FactoryGirl.create(:question, lesson: @lesson)
      q2 = FactoryGirl.create(:question, lesson: @lesson)
      a1 = user.attempts.build
      a1.question = q1
      a1.save
      a2 = user.attempts.build
      a2.question = q2 

      @lesson.cfu_attempted(user).should_not be_empty
      @lesson.cfu_attempted(user).should include(q1)
      @lesson.cfu_attempted(user).size == 2
    end
  end

  describe "#cfu_correct(user)" do
    it "should return cfus answered correctly" do
      q1 = FactoryGirl.create(:question, lesson: @lesson)
      q2 = FactoryGirl.create(:question, lesson: @lesson)
      a1 = user.attempts.build
      a1.correct = true
      a1.question = q1
      a1.save 
      a2 = user.attempts.build
      a2.question = q2

      @lesson.cfu_correct(user).should_not be_empty
      @lesson.cfu_correct(user).should include(q1)
      @lesson.cfu_correct(user).size == 1
    end
  end

  describe "#progress(user)" do
    it "should return share of questions attempted" do
      q1 = FactoryGirl.create(:question, lesson: @lesson)
      q2 = FactoryGirl.create(:question, lesson: @lesson)
      a1 = user.attempts.build
      a1.correct = true
      a1.question = q1
      a1.save 

      @lesson.progress(user).should_not be_nil
      @lesson.progress(user).should == 50
    end

    it "should return 0 if no attempts" do
      q1 = FactoryGirl.create(:question, lesson: @lesson)
      q2 = FactoryGirl.create(:question, lesson: @lesson)

      @lesson.progress(user).should_not be_nil
      @lesson.progress(user).should == 0
    end
  end


  describe "#completed_by?(user)" do
  	it "should be false if user has not attempted some cfus" do
  		q1 = FactoryGirl.create(:question, lesson: @lesson)
  		q2 = FactoryGirl.create(:question, lesson: @lesson)
  		a1 = user.attempts.build
  		a1.question = q1
  		a1.correct = true
  		a1.save
  		@lesson.completed_by?(user).should_not be_true
  	end

    it "should be true if user has attempted all lesson cfus" do
      q1 = FactoryGirl.create(:question, lesson: @lesson)
      q2 = FactoryGirl.create(:question, lesson: @lesson)
      a1 = user.attempts.build
      a1.question = q1
      a1.correct = true
      a1.save
      a2 = user.attempts.build
      a2.question = q2
      a2.save

      @lesson.completed_by?(user).should be_true
    end
  end

  describe "#lesson_score(user)" do
    it "should calculate share of cfu's answered correctly" do
      q1 = FactoryGirl.create(:question, lesson: @lesson)
      q2 = FactoryGirl.create(:question, lesson: @lesson)

      @lesson.lesson_score(user).should == 0

      a1 = user.attempts.build
      a1.question = q1
      a1.save
      a2 = user.attempts.build
      a2.question = q2
      a2.save

      @lesson.lesson_score(user).should == 0

      a1.correct = true
      a1.save
      @lesson.lesson_score(user).should == 50
    end 
  end

  describe "#status" do
    it "should return lesson status" do
      q1 = FactoryGirl.create(:question, lesson: @lesson)
      q2 = FactoryGirl.create(:question, lesson: @lesson)

      @lesson.status(user).should == 'not started'

      a1 = user.attempts.build
      a1.question = q1
      a1.save

      @lesson.status(user).should == 'in progress'

      a2 = user.attempts.build
      a2.question = q2
      a2.save

      @lesson.status(user).should == 'completed'
    end
  end
end
