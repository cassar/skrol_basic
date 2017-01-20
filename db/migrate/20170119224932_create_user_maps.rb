class CreateUserMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :user_maps do |t|
      t.integer :user_id
      t.integer :base_lang
      t.integer :target_lang
      t.integer :rank_num

      t.timestamps
    end
    remove_column :users, :base_lang, :integer
  end
end
