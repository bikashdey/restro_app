class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :phone_number
      t.string :restro_type
      t.references :user
      t.integer :status

      t.timestamps
    end
  end
end
