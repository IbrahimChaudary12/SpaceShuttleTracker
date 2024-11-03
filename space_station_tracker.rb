require 'httparty'

class ISSLocationTracker
  API_URL = 'http://api.open-notify.org/iss-now.json'.freeze

 
  def self.fetch_iss_location
    response = HTTParty.get(API_URL)

    if response.success?
      
      latitude = response.dig('iss_position', 'latitude')
      longitude = response.dig('iss_position', 'longitude')
      { latitude: latitude, longitude: longitude }
    else
     
      { error: "Failed to retrieve ISS location. Status code: #{response.code}" }
    end
  end

  
  def self.display_location
    location = fetch_iss_location

    if location[:error]
      puts location[:error]
    else
      puts "The ISS is currently at Latitude: #{location[:latitude]}, Longitude: #{location[:longitude]}"
    end
  end
end


ISSLocationTracker.display_location
