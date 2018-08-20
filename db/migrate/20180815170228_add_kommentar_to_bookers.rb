class AddKommentarToBookers < ActiveRecord::Migration[5.2]
  def change
    add_column :bookers, :kommentar, :text
    add_reference :bookers, :user, foreign_key: true
  end
end
