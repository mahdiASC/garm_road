class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :name
      t.string :condition
      t.string :item_type
      t.string :desc
      t.string :img
      t.integer :current_possessor_user_id
    end
  end
end
