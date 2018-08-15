class AuditTableForBookers < ApplicationRecord
  belongs_to :booker
  belongs_to :user
end
