namespace :review do
  desc "import"
  task :import, [:app_id] => :environment do |t, args|

  	app=App.find(args[:app_id])
  	response = HTTParty.get("https://itunes.apple.com/ru/rss/customerreviews/id=#{app.itunes_id}/sortBy=mostRecent/rel=first/json")
	body = JSON.parse(response.body)

	if body['feed']['entry']

	puts body['feed']['entry']
		itunes_reviews = body['feed']['entry'].drop(1)

		itunes_reviews.each do |review|
			
			Review.create(:author => review['author']['name']['label'],
								:im_version => review['im:version']['label'],
								:im_rating => review['im:rating']['label'],
								:itunes_id => review['id']['label'],
								:title => review['title']['label'],
								:content => review["content"]['label'],
								:app_id => app.id)
		end	
	end	

  end

end
