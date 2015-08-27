class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :batches, :elaboration_date, :elaboration_day
  end
end
