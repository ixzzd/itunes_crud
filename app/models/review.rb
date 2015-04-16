class Review < ActiveRecord::Base
	belongs_to :app

	self.per_page = 10
end
