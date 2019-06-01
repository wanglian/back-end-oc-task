class AddIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :chapters, :active
    add_index :rooms, :number
    add_index :edges, :room_parent_id
  end
end
