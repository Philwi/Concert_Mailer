class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.string :link
      t.text :bands
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :band, index: true
      t.timestamps
    end
  end
end
