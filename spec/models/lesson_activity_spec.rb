# == Schema Information
#
# Table name: lesson_activities
#
#  id            :integer          not null, primary key
#  position      :integer
#  lesson_id     :integer
#  activity_type :string(255)
#  activity_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe LessonActivity do
	let(:lesson) {FactoryGirl.create(:lesson)}
  before do
    @activity = LessonActivity.new(activity_id: 1,
    															activity_type: 'Type',
    														 position: 1)
    @activity.lesson = lesson
  end

  subject {@activity}

  it { should respond_to(:lesson) }
  it { should respond_to(:position) }
  it { should respond_to(:activity_type) }
  it { should be_valid }

  describe "without a lesson" do
  	before { @activity.lesson = nil }
  	it { should_not be_valid }
  end

end
