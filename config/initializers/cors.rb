Rails.application.config.middleware.insert_before 0, Rack::Cors do 
  allow do
    origins 'http://localhost:3000'

    resource '*',
      headers: :any,
      methods: [:post, :put, :patch, :delete, :options, :head, :get],
      credentials: true
  end

  allow do
    origins 'https://real-estate-mania.netlify.app'

    resource '*',
      headers: :any,
      methods: [:post, :put, :patch, :delete, :options, :head, :get],
      credentials: true
  end
end