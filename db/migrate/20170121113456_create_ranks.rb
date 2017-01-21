class CreateRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :ranks do |t|
      t.integer :word_id
      t.float :lang_map_id
      t.integer :rank_num

      t.timestamps
    end
  end
end
