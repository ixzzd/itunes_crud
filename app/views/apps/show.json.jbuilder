json.extract! @app, :itunes_id, :name
json.reviews @app.reviews, :id, :author, :im_version, :im_rating,  :itunes_id, :title, :content