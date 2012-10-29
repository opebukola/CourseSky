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

class SkillListing < ActiveRecord::Base
  attr_accessible :skill_id, :skilled_id, :skilled_type

  belongs_to :skill
  belongs_to :skilled, polymorphic: true
end
