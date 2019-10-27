class Image < ApplicationRecord
  mount_uploader :url, ImageUploader
  validates_presence_of :url
  has_one :slide, dependent: :destroy

  def make_cover
    images = Image.all
    images.each do |image|
      if image.is_cover == true
        image.is_cover = false
        image.save
      end
    end
    self.is_cover = true
    self.save
  end

  def remove_cover
    if self.is_cover == true
      self.is_cover = false
      self.save
    end
  end

end
