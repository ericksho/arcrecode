class CreatePackingTypes < ActiveRecord::Migration
  def change
    create_table :packing_types do |t|
      t.integer :amount
      t.string :measure
      t.integer :code

      t.timestamps
    end
  end
end
