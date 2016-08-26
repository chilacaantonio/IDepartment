class CreateResps < ActiveRecord::Migration[5.0]
  def change
    create_table :resps do |t|
      t.string :cual
      t.integer :user_id

      t.timestamps
    end
  end
end
