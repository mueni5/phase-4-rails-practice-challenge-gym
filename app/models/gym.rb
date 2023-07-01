class Gym < ApplicationRecord
    has_many :clients
    has_many :memberships, through: :clients

    validates :name, presence: true
    validates :age, presence: true, numericality: { greater_than_or_equal_to: 18 }

    validate :age_validation

    def age_validation
        if age.nil?
            errors.add(:age, "must be present" )
        end
    end
end
