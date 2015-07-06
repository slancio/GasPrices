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
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true

  has_many :prices, dependent: :destroy

  attr_reader :current_price

  def self.current_prices
    Price.where('created_at = ?', Date.today)
  end

  def current_price
    prices.where('created_at = ?', Date.today).first
  end

  def slug_candidates
    [
      Madison.get_abbrev(self.name),
    ]
  end

end
