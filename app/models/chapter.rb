class Chapter < ApplicationRecord

  attr_accessor :rooms_count

  has_many :rooms
  has_many :edges

  validate :uniq_active

  before_create :generate_rooms_and_edges

  scope :active, -> { where(active: true).first }

  def self.active
    where(active: true).last
  end

  def generate_rooms_and_edges
    #TODO
  end

  def uniq_active
    if self.active && Chapter.where(active: true).first
      errors.add(:active, 'only 1 active chapter may exists in the system')
    end
  end
end
