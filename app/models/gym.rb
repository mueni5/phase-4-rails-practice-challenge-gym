class Gym < ApplicationRecord
    has_many :clients
    has_many :memberships, through: :clients

    validates :name, presence: true
    validates :memberships, presence: true

    validate :membership_validation

    def membership_validation
        if memberships.empty?
          errors.add(:memberships, "gym not found")
        end
      end
      
end
