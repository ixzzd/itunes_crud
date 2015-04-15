class App < ActiveRecord::Base
	has_many :reviews
	validates :name, :presence => true
	validates :itunes_id, :presence => true
	validates :itunes_id, :with => /\d{9}/
end