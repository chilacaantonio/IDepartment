class AddNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :paterno, :string
    add_column :users, :materno, :string
    add_column :users, :escuela, :string
    add_column :users, :edad, :datetime
    add_column :users, :admin, :integer
  end
end
