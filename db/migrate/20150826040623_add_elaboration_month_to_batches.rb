class AddElaborationMonthToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :elaboration_month, :integer
  end
end
