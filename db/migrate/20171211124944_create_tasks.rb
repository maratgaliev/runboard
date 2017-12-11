class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.references :user, foreign_key: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
