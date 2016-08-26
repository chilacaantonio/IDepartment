class AddResToResps < ActiveRecord::Migration[5.0]
  def change
    add_column :resps, :res, :string
  end
end
