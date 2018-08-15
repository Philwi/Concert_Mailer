class CreateAuditTableForBookers < ActiveRecord::Migration[5.2]
  def change
    create_table :audit_table_for_bookers do |t|
      t.string :stadt_new
      t.string :stadt_old
      t.string :club_new
      t.string :club_old
      t.string :homepage_new
      t.string :homepage_old
      t.string :email_new
      t.string :email_old
      t.string :telefon_new
      t.string :telefon_old
      t.string :bundesland_new
      t.string :bundesland_old
      t.string :land_new
      t.string :land_old
      t.string :plz_new
      t.string :plz_old
      t.boolean :active_new
      t.boolean :active_old
      t.string :action
      t.string :kommentar
      t.belongs_to :booker, index: true, optional: true
      t.belongs_to :user, index: true, optional: true
      t.timestamps
    end
  end
end
