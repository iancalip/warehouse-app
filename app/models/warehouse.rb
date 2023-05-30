class Warehouse < ApplicationRecord
    validates :name, :code, :city, :state, :area, :address, :cep, :description, presence: true
    validates :code, length: { is: 3 }
    validates :state, length: { is: 2 }
    validates :name, :code, uniqueness: true

    has_many :stock_products

    def full_description
        "#{code} | #{name}"
    end
end
