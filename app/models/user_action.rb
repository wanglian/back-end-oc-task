class UserAction < ApplicationRecord

  validates :user   , presence: true
  validates :chapter, presence: true
  validates :room   , presence: true

end
