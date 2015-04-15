class AddAppIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :app_id, :integer
  end
end
