class Lists < ActiveRecord::Migration[5.2]
  def up
    create_table :lists do |t|
      t.string :name
    end
  end
 
  def down
    drop_table :lists
  end
end
