class AddNameToFlavors < ActiveRecord::Migration[5.2]
  def change
    add_column :flavors, :name, :string
  end
end
