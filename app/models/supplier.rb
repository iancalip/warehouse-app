class Supplier < ApplicationRecord
    has_many :product_models
    validates :corporate_name, :brand_name, :registration_number, :email, presence: true
    validates :registration_number, length: { is: 13 }
    validates :registration_number, uniqueness: true

    def full_description
        "#{corporate_name} | #{registration_number}"
    end
end
