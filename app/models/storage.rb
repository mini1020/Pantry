class Storage < ApplicationRecord
  belongs_to :user
  has_many :foods, dependent: :destroy

  validates :place, presence: true, null: false,
                   length: { maximum: 20 }

  validate :same_user_same_place_cannot_registered

  def same_user_same_place_cannot_registered
    debugger
    if id.nil?
      if user_id.present? && place.present?
        if Storage.exists?(user_id: user_id, place: place)
          errors.add(:place, "は既に登録済みです。他の場所を登録して下さい")
        end
      end
    end
  end
  
end
