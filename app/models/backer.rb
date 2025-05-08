class Backer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pledges, dependent: :destroy
  has_many :backed_projects, through: :pledges, source: :project
end
