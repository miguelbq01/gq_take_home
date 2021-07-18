class Incentive < ApplicationRecord
    validates :code, presence: true, uniqueness: true

    def self.unredeemed
        where(redeemed: false)
    end
end
