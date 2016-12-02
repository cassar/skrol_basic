class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :entry
      t.integer :script_id

      t.timestamps
    end
  end
end
