class AddUserBandsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :user_bands do |t|
      t.belongs_to :user, index: true, optional: true
      t.belongs_to :band, index: true, optional: true
      t.timestamps
    end

    Band.all.each do |b|
      ub = UserBand.new(user_id: b.user_id, band_id: b.id)
      ub.save
    end
  end

  def down
    drop_table :user_bands
  end
end
