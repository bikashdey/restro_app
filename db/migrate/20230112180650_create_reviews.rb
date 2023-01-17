class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.belongs_to :user, null: false, foreign_key: true
      t.references :reviewable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
