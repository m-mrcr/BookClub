class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :headline
      t.text :body
      t.integer :rating
      t.string :username

      t.timestamps
    end
  end
end
