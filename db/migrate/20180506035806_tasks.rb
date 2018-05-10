class Tasks < ActiveRecord::Migration[5.2]
  def up
    create_table :tasks do |t|
      t.string :name
      t.references :list, foreign_key: true
    end
  end
 
  def down
    drop_table :tasks
  end
end
