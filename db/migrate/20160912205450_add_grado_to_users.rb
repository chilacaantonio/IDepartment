class AddGradoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :grado, :string
  end
end
