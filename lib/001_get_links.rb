require 'dotenv/load'
require 'json'
require 'open-uri'

#==============================================================================
@data_gov_api_key = ENV.fetch('DATA_GOV_API_KEY', "***DATA_GOV_API_KEY-GOES-HERE***")

def get_digital_service_accounts
  all_accounts = []

  # Gather 12 pages of 1000 records
  (1..12).each do |page|
    url = "https://api.gsa.gov/analytics/touchpoints/v1/digital_service_accounts.json?API_KEY=#{@data_gov_api_key}&page=#{page}&size=1000"
    response = URI.open(url).read
    json = JSON.parse(response)

    accounts = json["data"]

    all_accounts.concat accounts
    puts page
  end

  # Write the data to .json
  # and sort it by `service_url`
  File.open("../_data/digital_service_accounts.json", "w") do |f|
    f << JSON.pretty_generate(all_accounts.sort_by { |k,v| k["attributes"]["service_url"] })
  end
end

get_digital_service_accounts