class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :task
      t.integer :user_id
      t.integer :list_id

      t.timestamps null: false
    end
  end
end
