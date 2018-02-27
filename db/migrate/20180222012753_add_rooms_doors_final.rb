class AddRoomsDoorsFinal < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :final, :boolean, default: false
    add_column :doors, :final, :boolean, default: false
  end
end
