# == Schema Information
#
# Table name: prices
#
#  id         :integer          not null, primary key
#  price      :decimal(4, 3)    not null
#  state_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
