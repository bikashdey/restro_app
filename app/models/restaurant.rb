class Restaurant < ApplicationRecord
	belongs_to :user
  has_many :restaurant_dishes, dependent: :destroy
  has_many :dishes, through: :restaurant_dishes
	has_many :reviews, as: :reviewable


	enum :status, {"open" => 0, "close" => 1}
end