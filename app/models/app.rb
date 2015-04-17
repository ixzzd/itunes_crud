class App < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	
	validates :name, :presence => true
	validates :itunes_id, :presence => true, :format => { :with => /\d{9}/, :message => "iTunes id has wrong format" }
	validate :image_itunes_id

	before_save :save_image


	def get_image_url
		response = HTTParty.get("https://itunes.apple.com/ru/rss/customerreviews/id=#{self.itunes_id}/sortBy=mostRecent/json")
		body = JSON.parse(response.body)
		image_url = body['feed']['entry'][0]['im:image'][1]['label'] if body['feed']['entry']
	end	

	def image_itunes_id
		errors.add(:itunes_id, 'Invalid iTunes ID') unless self.get_image_url
	end	

	def save_image
		self.image_url = self.get_image_url
	end	

end
