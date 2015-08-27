class AddProductTypeToBatch < ActiveRecord::Migration
  def change
    add_reference :batches, :product_type, index: true
  end
end
