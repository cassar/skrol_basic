class CreateContributors < ActiveRecord::Migration[5.0]
  def change
    create_table :contributors do |t|
      t.integer :user_id
      t.integer :language_id

      t.timestamps
    end

    add_index :contributors, [:user_id, :language_id]
  end
end
