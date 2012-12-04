# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  course_id  :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Unit do
  let(:course) { FactoryGirl.create(:course) }
  before	{ @unit = course.units.build(title: "Lorem Ipsum") }

  subject { @unit }

  it { should respond_to(:title) }
  it { should respond_to(:course_id) }
  it { should respond_to(:course) }
  its(:course) { should == course }
  it { should respond_to(:position) }

  it { should be_valid }

  describe "when course_id is not present" do
  	before { @unit.course_id = nil }
  	it { should_not be_valid }	
  end

  describe "when title is not present" do
  	before { @unit.title = nil }
  	it { should_not be_valid }
  end


end

