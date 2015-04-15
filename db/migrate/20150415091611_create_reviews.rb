class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :author
      t.string :im_version
      t.integer :im_rating
      t.integer :itunes_id
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
