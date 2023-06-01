class RenameSkuInProductModel < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_models, :sku, :identifier
  end
end
