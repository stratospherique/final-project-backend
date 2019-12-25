Rails.application.config.middleware.insert_before 0, Rack::Cors do 
  allow do
    origins 'http://localhost:3000'
    origins 'https://clever-hugle-f515ec.netlify.com'

    resource '*',
      headers: :any,
      methods: [:post, :put, :patch, :delete, :options, :head, :get],
      credentials: true
  end
end