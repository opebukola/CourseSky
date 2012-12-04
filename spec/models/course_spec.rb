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
end
