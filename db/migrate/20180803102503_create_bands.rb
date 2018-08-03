class CreateBands < ActiveRecord::Migration[5.2]
  def change
    create_table :bands do |t|
      t.string :name
      t.string :ort
      t.string :bandcamp
      t.string :website
      t.date :gründung
      t.string :email
      t.string :telefon
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
