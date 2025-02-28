# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true

  # Define roles
  ROLES = %w[admin creator backer].freeze

  validates :role, inclusion: { in: ROLES }

  # Helper methods to check roles
  def admin?
    role == "admin"
  end

  def creator?
    role == "creator"
  end

  def backer?
    role == "backer"
  end
end
