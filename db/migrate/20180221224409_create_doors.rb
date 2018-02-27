class CreateDoors < ActiveRecord::Migration[5.1]
  def change
    create_table :doors do |t|
      t.string :img

      t.timestamps
    end
  end
end
