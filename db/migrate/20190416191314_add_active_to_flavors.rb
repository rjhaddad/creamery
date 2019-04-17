class AddActiveToFlavors < ActiveRecord::Migration[5.2]
  def change
    add_column :flavors, :active, :boolean
  end
end
