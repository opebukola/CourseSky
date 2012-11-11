require 'spec_helper'

describe "PracticePages" do
  subject {page}

  describe "course home page" do
  	# let(:course) { FactoryGirl.create(:course) }

  	# before { visit course_path(course) }

  	it { pending
  		should have_selector(:li, text: 'Practice') }
  end
end


 