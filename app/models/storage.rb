class Storage < ApplicationRecord
  belongs_to :user
  has_many :foods, dependent: :destroy

  validates :name, presence: true, null: false,
                   length: { maximum: 20 }, uniqueness: true
end
