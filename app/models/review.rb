class Review < ActiveRecord::Base
	belongs_to :app
	validates_uniqueness_of :itunes_id, :scope => :app_id
	self.per_page = 10
end
