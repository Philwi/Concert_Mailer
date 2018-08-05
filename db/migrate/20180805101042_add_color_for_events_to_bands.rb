class AddColorForEventsToBands < ActiveRecord::Migration[5.2]
  def change
    add_column :bands, :event_color, :string
  end
end
