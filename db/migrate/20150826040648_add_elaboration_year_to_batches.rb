class AddElaborationYearToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :elaboration_year, :integer
  end
end
