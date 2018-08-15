class AddActiveToBookers < ActiveRecord::Migration[5.2]
  def change
    add_column :bookers, :active, :boolean
  end
end
