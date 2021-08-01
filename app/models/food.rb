class Food < ApplicationRecord
  belongs_to :storage
  has_one :user, through: :storage, source: :user

  validates :fname, presence: true, null: false,
                    length: { maximum: 40 }
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 30 },
                       allow_blank: true, on: :create
  validates :quantity, numericality: { greater_than_or_equal_to: 0, less_than: 30 },
                       allow_blank: true, on: :update # 更新時は0も可
  validates :purchase, presence: true, null: false
  validate :purchasedate_earlier_than_not_today_possible,
          #  :expirationdate_before_inputdate_is_not_possible
          #  :noticedate_before_inputdate_is_not_possible,
          #  :noticedate_after_expirationdate_is_not_possible,
          #  :no_expirationdate_cannot_enter_noticedate
           
  # 入力日より先の購入日は入力不可
  def purchasedate_earlier_than_not_today_possible
    if purchase.present? && purchase > Date.today
      errors.add(:purchase, "に本日より先の日付は入力できません") 
    end
  end

  # 入力日以前の使い切り期限は入力不可
  # def expirationdate_before_inputdate_is_not_possible
  #   if expiration.present? && expiration <= Date.today
  #     errors.add(:expiration, "に本日または本日以前の日付は入力できません")
  #   end
  # end

  # # 入力日以前のお知らせ日は入力不可
  # def noticedate_before_inputdate_is_not_possible
  #   if notice.present? && notice <= Date.today
  #     errors.add(:notice, "に本日以前の日付は入力できません")
  #   end
  # end
  # # 使い切り期限より先のお知らせ日は入力不可
  # def noticedate_after_expirationdate_is_not_possible
  #   if notice.present? && notice > expiration
  #     errors.add(:notice, "に使い切り期限より先の日付は入力できません")
  #   end
  # end

  # # 使い切り期限が存在しない時、お知らせ日は入力不可
  # def no_expirationdate_cannot_enter_noticedate
  #   if notice.present? && expiration.nil?
  #     errors.add(:notice, "は入力できません。使い切り期限を指定してください")
  #   end
  # end
end
