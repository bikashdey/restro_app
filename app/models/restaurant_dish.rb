class RestaurantDish < ApplicationRecord
	belongs_to :restaurant, optional: true
	belongs_to :dish, optional: true
end
