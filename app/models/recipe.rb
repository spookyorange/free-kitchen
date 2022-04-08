class Recipe < ApplicationRecord
  validates :title, presence: true, length: { minimum: 4, maximum: 20 }
  validates :about, presence: true, length: { minimum: 15, maximum: 250 }

  belongs_to :user
end
