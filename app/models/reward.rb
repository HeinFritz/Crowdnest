class Reward < ApplicationRecord
  belongs_to :project
  validates :name, :amount, :delivery_date, presence: true
  has_one_attached :image
end
