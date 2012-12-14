# == Schema Information
#
# Table name: concepts
#
#  id          :integer          not null, primary key
#  lesson_id   :integer
#  video_url   :string(255)
#  video_start :integer
#  video_end   :integer
#  doc         :text
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Concept do
  let(:lesson) { FactoryGirl.create(:lesson) }
  before do
    @concept = lesson.concepts.build(title: 'Concept',
    						video_url: "http://www.youtube.com/watch?v=2_QdgNsopkM",
    						doc: 'Some doc')
    skill = FactoryGirl.create(:skill)
    @concept.skills << skill
  end

  subject { @concept }

  it { should respond_to(:title) }
  it { should respond_to(:lesson_id) }
  it { should respond_to(:video_url) }
  it { should respond_to(:video_start) }
  it { should respond_to(:video_end) }
  it { should respond_to(:doc) }
  it { should respond_to(:lesson) }
  it { should respond_to(:lesson_activity) }
  it { should respond_to(:skills) }

  it { should be_valid }

  describe "without lesson id" do
  	before { @concept.lesson_id = nil }
  	it { should_not be_valid }
  end

  describe "without title" do
  	before { @concept.title = nil }
  	it { should_not be_valid }
  end

  describe "without video url" do
  	before { @concept.video_url = nil }
  	it { should_not be_valid }
  end

  describe "without doc" do
  	before { @concept.doc = nil }
  	it { should_not be_valid }
  end

  describe "without valid video url" do
  	before { @concept.video_url = "www.facebook.com" }
  	it { should_not be_valid }
  end

  describe "without skills" do
  	before { @concept.skills = [] }
  	it { should_not be_valid }
  end

  describe "after saving" do
  	it "should create lesson activity" do
  		concept = FactoryGirl.create(:concept)

  		concept.lesson_activity.should_not be_nil
  	end
  end

  describe "before deletiing" do
  	it "should delete lesson activity" do
  		concept = FactoryGirl.create(:concept)
  		concept.destroy

  		concept.lesson_activity.should be_nil
  	end
  end
end
