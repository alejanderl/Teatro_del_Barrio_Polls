RSpec.configure do |config|
 
 config.include Devise::TestHelpers, :type => :controller

 config.mailer_sender = "info@teatrodelbarrio.com"
 config.secret_key = 'ebcae5eed9dcb4a1989d50d13c649d875626abfd3be2999377d2b29f208706c5046f0d2e74e4bfbe5d867723f7c6971cfe417724eda21cfd96ae352c1ee0a6'
  # Time interval you can reset your password with a reset password key.
  # Don't put a too small interval or your users won't have the time to
  # change their passwords.
  config.reset_password_within = 25.hours

 end