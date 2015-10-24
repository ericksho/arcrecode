class AddEnglishNameToProductTypes < ActiveRecord::Migration
  def change
    add_column :product_types, :englishName, :string
  end
end
