class Project < ApplicationRecord
  belongs_to :creator
  has_one_attached :image
  has_many :rewards, inverse_of: :project, dependent: :destroy
  has_many :pledges, dependent: :destroy
  accepts_nested_attributes_for :rewards, allow_destroy: true, reject_if: :all_blank
end
