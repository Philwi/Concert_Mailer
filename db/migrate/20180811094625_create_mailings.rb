class CreateMailings < ActiveRecord::Migration[5.2]
  def change
    create_table :mailings do |t|
      t.string :subject
      t.text :body
      t.integer :veranstalter, array: true
      t.belongs_to :user, index: true, optional: true
      t.timestamps
    end
  end
end
