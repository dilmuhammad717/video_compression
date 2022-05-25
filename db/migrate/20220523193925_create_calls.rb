class CreateCalls < ActiveRecord::Migration[7.0]
  def change
    create_table :calls do |t|
      t.string :customer_name

      t.timestamps
    end
  end
end
