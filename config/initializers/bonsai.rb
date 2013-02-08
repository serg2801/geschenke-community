if Rails.env.production?
  ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']
  Tire.configure do
    url "http://index.bonsai.io"
  end
else
  Tire.configure do 
    url "http://127.0.0.1:9200"
  end
end

