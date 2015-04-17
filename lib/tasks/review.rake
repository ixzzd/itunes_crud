namespace :review do
  desc "import"
  task :import, [:app_id] => :environment do |t, args|

  	puts '!!!0'
  	app=App.find(args[:app_id])
  	response = HTTParty.get("https://itunes.apple.com/ru/rss/customerreviews/id=#{app.itunes_id}/sortBy=mostRecent/json")
	body = JSON.parse(response.body)

	puts '!!!1'
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
