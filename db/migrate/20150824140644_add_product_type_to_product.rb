class AddProductTypeToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :product_type, index: true
  end
end
