class CreateEdges < ActiveRecord::Migration[5.1]
  def change
    create_table :edges do |t|
      t.integer :room_parent_id
      t.integer :room_child_id
      t.references :chapter, foreign_key: true

      t.timestamps
    end
  end
end
