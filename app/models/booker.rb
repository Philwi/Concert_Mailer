class Booker < ApplicationRecord
  belongs_to :user
  has_many :audit_table_for_Bookers
  after_update :save_to_audit_after
  validates :stadt, presence: true;
  validates :club, presence: true;
  validates :email, presence: true;
  validates :land, presence: true;

  def save_to_audit_before
    @audit = AuditTableForBookers.new
    @audit.stadt_old = self.stadt
    @audit.club_old = self.club
    @audit.homepage_old = self.homepage
    @audit.email_old = self.email
    @audit.telefon_old = self.telefon
    @audit.bundesland_old = self.bundesland
    @audit.land_old = self.land
    @audit.plz_old = self.plz
    @audit.active_old = self.active
    @audit.booker_id = self.id
    @audit.user_id = self.user_id
    if self.active == false
      @audit.action = 'Delete'
      @audit.kommentar = self.kommentar
    end
    @audit.save!
  end
  private

  def save_to_audit_after
    @audit = AuditTableForBookers.last
    @audit.stadt_new = self.stadt
    @audit.club_new = self.club
    @audit.homepage_new = self.homepage
    @audit.email_new = self.email
    @audit.telefon_new = self.telefon
    @audit.bundesland_new = self.bundesland
    @audit.land_new = self.land
    @audit.plz_new = self.plz
    @audit.active_new = self.active
    @audit.save
  end
end
