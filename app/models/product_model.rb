class ProductModel < ApplicationRecord
  before_validation :generate_identifier, on: :create

  validates :name, :weight, :width, :height, :depth, :identifier, :supplier,
            :category, :description, presence: true

  validates :identifier, length: { is: 10}
  validates :identifier, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }

  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items

  private

  def generate_identifier
    self.identifier = SecureRandom.alphanumeric(10)
  end
end
