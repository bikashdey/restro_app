class Dish < ApplicationRecord
  	has_many :restaurant_dishes, dependent: :destroy
  	has_many :restaurants, through: :restaurant_dishes

	has_many :reviews, as: :reviewable
  		
end
