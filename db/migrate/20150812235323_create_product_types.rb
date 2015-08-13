class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.boolean :organic
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
