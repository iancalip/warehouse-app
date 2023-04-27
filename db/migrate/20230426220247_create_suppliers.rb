class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :registration_number
      t.text :address
      t.string :state
      t.string :city
      t.string :email
      t.string :telephone

      t.timestamps
    end
  end
end
