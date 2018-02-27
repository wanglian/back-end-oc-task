class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :number
      t.references :chapter, foreign_key: true
      t.references :door, foreign_key: true
      t.timestamps
    end
  end
end
