require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
# == Schema Information
#
# Table name: lessons
#
#  id                         :integer         not null, primary key
#  title                      :string(255)
#  document                   :string(255)
#  video_url                  :string(255)
#  course_id                  :integer
#  user_id                    :integer
#  document_ipaper_id         :integer
#  document_ipaper_access_key :string(255)
#  position                   :integer
#  created_at                 :datetime        not null
#  updated_at                 :datetime        not null
#

