Apipie.configure do |config|
  config.app_name                = "Pokering HTTP API"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/api/v1/docs"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.app_info                = "The Pokering HTTP API is a RESTful JSON API designed to provide an data interface for any and all Pokering client applications."
  config.markup                   = Apipie::Markup::Markdown.new
end
