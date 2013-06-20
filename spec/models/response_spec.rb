# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  body        :text
#  proposal_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  read        :boolean          default(FALSE)
#

require 'spec_helper'

describe Response do
end
