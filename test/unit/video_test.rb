# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  start_time :integer
#  end_time   :integer
#  transcript :text
#  lesson_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
