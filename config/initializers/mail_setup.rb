ActionMailer::Base.smtp_settings = {
    :address              => "smtp.mandrillapp.com",
    :port                 => 587,
    :user_name            => 'propiedadabiertaoviedo@gmail.com',
    :password             => ENV["MANDRILL_API_KEY"],
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :authentication => 'plain', # Mandrill supports 'plain' or 'login'
    :domain => 'teatrodelbarrio.herokuapp.com' # your domain to identify your server when connecting
 }

ActionMailer::Base.default_url_options[:host] = "teatrodelbarrio.herokuapp.com"




