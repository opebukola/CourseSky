# == Schema Information
#
# Table name: lesson_questions
#
#  id          :integer          not null, primary key
#  lesson_id   :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe LessonQuestion do
  pending "add some examples to (or delete) #{__FILE__}"
end
