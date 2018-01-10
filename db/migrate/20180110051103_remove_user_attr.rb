class RemoveUserAttr < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :current_speed, :integer
    remove_column :users, :base_hidden, :boolean
    remove_column :users, :paused, :boolean
  end
end
