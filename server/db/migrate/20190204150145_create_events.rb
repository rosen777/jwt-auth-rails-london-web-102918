class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.integer :capacity
      t.string :image
      t.datetime :date
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
