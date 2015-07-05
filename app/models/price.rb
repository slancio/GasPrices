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

class Price < ActiveRecord::Base
  validates :state_id,
            presence: true,
            uniqueness: {
              scope: :created_at,
              message: "State prices update once per day only"
            }
  validates :created_at,
            presence: true,
            uniqueness: {
              scope: :state_id,
              message: "State prices update once per day only" 
            }
  validates :price,
            presence: true,
            numericality: { greater_than: 0 },
            format: {
              with: /[0-9]+\.[0-9]{3}/,
              message: "Prices should contain three decimal precision."
            }

  belongs_to :state
end
