# == Schema Information
#
# Table name: concept_skills
#
#  id         :integer          not null, primary key
#  concept_id :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ConceptSkill < ActiveRecord::Base
  attr_accessible :concept_id, :skill_id
  belongs_to :concept
  belongs_to :skill
end
