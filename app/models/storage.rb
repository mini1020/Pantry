class Storage < ApplicationRecord
  
  belongs_to :user
  has_many :foods, dependent: :destroy

  validates :place, presence: true, null: false,
                   length: { maximum: 20 }

  validate :same_user_same_place_cannot_registered

  def same_user_same_place_cannot_registered
    if user_id.present? && Storage.exists?(user_id: user_id)
      if place.present? && Storage.exists?(place: place)
        debugger
        errors.add(:place, "は既に登録済みです。他の場所を登録して下さい")
      end
    end
  end
  
end
