# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  started_at  :datetime
#  ended_at    :datetime
#  correct     :boolean
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Attempt do 
	it "has a valid factory"
	it "has an associated user"
	it "has an associated quiz"
end
