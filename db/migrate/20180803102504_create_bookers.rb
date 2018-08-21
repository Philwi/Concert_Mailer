class CreateBookers < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:bookers)
      create_table :bookers do |t|
      t.string :stadt
      t.string :club
      t.string :homepage
      t.string :name
      t.string :email
      t.string :telefon
      t.string :bundesland
      t.string :land
      t.string :plz
      t.float :lat
      t.float :lng
      t.timestamps
      end
    end
  end
end
