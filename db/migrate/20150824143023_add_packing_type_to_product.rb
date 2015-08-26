class AddPackingTypeToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :packing_type, index: true
  end
end
