class AddGrossWeightToPackingTypes < ActiveRecord::Migration
  def change
    add_column :packing_types, :gross_weight, :integer
  end
end
