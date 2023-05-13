require 'dotenv/load'
require 'json'
require 'open-uri'

###
# Create an organizations.json file based on the Organizations
# referenced within each Service Account
###

def get_orgs
  accounts = JSON.parse(File.open("../_data/digital_service_accounts.json").read)

  orgs = []

  accounts.each do |account|
    orgs = orgs.concat(account["attributes"]["agencies"])
  end

  unique_orgs = orgs.uniq {|e| e["id"] }
  sorted_orgs = unique_orgs.sort_by { |org| org["name"]}

  File.open("../_data/organizations.json", "w") do |f|
    f << JSON.pretty_generate(sorted_orgs)
  end
end

get_orgs