# == Schema Information
#
# Table name: skill_listings
#
#  id           :integer          not null, primary key
#  skill_id     :integer
#  skilled_id   :integer
#  skilled_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class SkillListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
