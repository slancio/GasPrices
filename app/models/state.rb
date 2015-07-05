# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class State < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :prices, dependent: :destroy

  def self.current_prices
    Price.where('created_at = ?', Date.today)
  end

  def current_price
    prices.where('created_at = ?', Date.today).first
  end

end
