class AddColumnsToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :address, :string
    add_column :warehouses, :cep, :string
    add_column :warehouses, :description, :text
  end
end
