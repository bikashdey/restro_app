class CreateRestaurantDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_dishes do |t|
      t.belongs_to :restaurant
      t.belongs_to :dish
      t.timestamps
    end
  end
end
