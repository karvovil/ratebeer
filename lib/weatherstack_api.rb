class WeatherstackApi

  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query=#{city}"

    weather = HTTParty.get(url).parsed_response["current"]
  end

  def self.key
    return nil if Rails.env.test? # testatessa ei apia tarvita, palautetaan nil
    raise 'WEATHERSTACK_APIKEY env variable not defined' if ENV['WEATHERSTACK_APIKEY'].nil?

    ENV.fetch('WEATHERSTACK_APIKEY')
  end
end
