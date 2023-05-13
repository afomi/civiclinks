require 'dotenv/load'
require 'json'
require 'open-uri'
require 'pry'

###
# Create a digital_service_accounts_by_org.json file based on digital_service_accounts.json
#
# Each Service Account has one or more Agencies
#
# This file creates individual rows for each Service Account agency
#
# For example, if a Service Account has EPA and NOAA
# Then 2 entries are created; one for EPA and one for NOAA
#
# This is to make it easy to list Service Accounts for an Agency
###

def split_accounts_by_org
  accounts = JSON.parse(File.open("../_data/digital_service_accounts.json").read)

  @accounts_by_organization = []

  accounts.each do |account|
    agencies = account["attributes"]["agencies"]
    agencies.each do |agency|
      account_with_org = account["attributes"]
      account_with_org.merge!({
        "organization_id" => agency["id"],
        "organization_name" => agency["name"],
        "organization_abbreviation" => agency["abbreviation"],
        "organization_url" => agency["url"],
        "id" => account["id"],
      })
      account_with_org.delete("agencies")
      @accounts_by_organization = @accounts_by_organization << account_with_org
    end
  end

  File.open("../_data/digital_service_accounts_by_org.json", "w") do |f|
    f << JSON.pretty_generate(@accounts_by_organization)
  end
end

split_accounts_by_org