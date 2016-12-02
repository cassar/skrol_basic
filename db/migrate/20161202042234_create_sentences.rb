class CreateSentences < ActiveRecord::Migration[5.0]
  def change
    create_table :sentences do |t|
      t.string :entry
      t.integer :script_id
      t.integer :group_id

      t.timestamps
    end
  end
end
