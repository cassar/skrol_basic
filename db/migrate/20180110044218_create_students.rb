class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.integer :user_id
      t.integer :current_speed
      t.boolean :base_hidden
      t.boolean :paused

      t.timestamps
    end

    rename_column :enrolments, :user_id, :student_id
  end
end
