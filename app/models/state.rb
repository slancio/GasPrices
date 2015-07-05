# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  price      :decimal(4, 3)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class State < ActiveRecord::Base
end
