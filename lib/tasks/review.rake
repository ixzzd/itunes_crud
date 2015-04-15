namespace :review do
  desc "import"
  task import: :environment do

  	response = HTTParty.get('https://itunes.apple.com/ru/rss/customerreviews/id=540328259/sortBy=mostRecent/json')
	body = JSON.parse(response.body)
	itunes_reviews = body['feed']['entry'].drop(1)

	itunes_reviews.each do |review|
		author = review['author']['name']['label'] 
		im_version = review['im:version']['label']
		im_rating = review['im:rating']['label']
		itunes_id = review['id']['label']
		title  = review['title']['label'] 
		content = review["content"]['label']

		Review.create(:author => author,
							:im_version => im_version,
							:im_rating => im_rating,
							:itunes_id => itunes_id,
							:title => title,
							:content => content)
	end	

  end

end
