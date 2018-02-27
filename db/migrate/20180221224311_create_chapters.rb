class CreateChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :chapters do |t|
      t.integer :number
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
