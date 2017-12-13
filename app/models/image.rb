class Image < ApplicationRecord
  belongs_to :event

  scope :sixteen_by_nine, -> { where(ratio: "16_9").where("url like ?", '%RETINA%') }
  scope :four_by_three, -> { where(ratio: "4_3").where("url like ?", '%CUSTOM%') }
end
