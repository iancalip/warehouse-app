class AddColumnsToProductModel < ActiveRecord::Migration[7.0]
  def change
    add_column :product_models, :description, :text
    add_column :product_models, :category, :string
    add_column :product_models, :image, :string
  end
end
