if Rails.env.production?
  Airbrake.configure do |config|
    config.api_key = 'cfa6d751ca173fecd29cea9fb030fef2'
  end
end