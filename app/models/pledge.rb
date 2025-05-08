class Pledge < ApplicationRecord
  belongs_to :backer
  belongs_to :project
  belongs_to :reward, optional: true # Reward is optional — some pledges might not choose a tier

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
