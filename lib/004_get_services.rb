require 'json'
require 'open-uri'

#==============================================================================

def get_service_providers
  url = "https://www.performance.gov/cx/data/service_providers.json"
  response = URI.open(url).read
  json = JSON.parse(response)

  service_providers = json["data"]

  # Write the data to .json
  File.open("../_data/service_providers.json", "w") do |f|
    f << JSON.pretty_generate(service_providers)
  end
end

def get_services
  url = "https://www.performance.gov/cx/data/services.json"
  response = URI.open(url).read
  json = JSON.parse(response)

  services = json["data"]

  # Write the data to .json
  File.open("../_data/services.json", "w") do |f|
    f << JSON.pretty_generate(services)
  end
end

get_service_providers
get_services