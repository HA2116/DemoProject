class Image < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :image

  belongs_to :imageable, polymorphic: true
end
