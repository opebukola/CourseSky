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
end
