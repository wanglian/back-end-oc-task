class Door < ApplicationRecord

  has_many :rooms

  mount_uploader :img, DoorUploader

  def self.all_ids
    self.pluck(:id)
  end

  def thumbnail
    if self.final
      self.img.last_thumb.to_s
    else
      self.img.thumb.to_s
    end
  end

end
