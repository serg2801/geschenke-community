CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS', 
    :aws_access_key_id      => 'AKIAIMGOPSUQN5PTDPBQ',
    :aws_secret_access_key  => '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',
    :region                 => 'eu-west-1'
  }
  config.fog_directory  = 'geschenkeheld-community'
  # config.fog_public     = true
end