class RenameWeigthToWeightInProductModels < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_models, :weigth, :weight
  end
end
