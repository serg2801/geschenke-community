CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAJCJ7ZRT45QMM6GPA',
      :aws_secret_access_key  => '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',
      # :endpoint               => "https://s3.amazonaws.com",
      # :host                   => 's3.amazonaws.com',
      :region                 => 'eu-central-1'
  }

  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory  = 'geschenkeheld'
  config.fog_public     = true

end