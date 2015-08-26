class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.integer :elaboration_date
      t.integer :lifespan
      t.integer :daily_batch
      t.integer :intern_use_1
      t.integer :intern_use_2
      t.integer :verify_digit
      t.string :description

      t.timestamps
    end
  end
end
