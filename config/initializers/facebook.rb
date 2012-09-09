class FacebookConfig
  if Rails.env.production?
    API = "409153285798797"
  else
    API = "276245329152835"
  end
end
