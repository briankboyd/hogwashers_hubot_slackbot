
# Commands:
#   hubot weather <address> - Weather info for the specified address

rp = require('request-promise')

module.exports = (robot) ->
  robot.respond /weather (.*)/i, (msg) ->
    location = escape(msg.match[1]) or "Kansas City"
    locationOptions =
      uri: 'http://maps.googleapis.com/maps/api/geocode/json',
      qs:
        address: location
      headers:
          'User-Agent': 'Request-Promise'
    json: true

    rp(locationOptions)
      .then( (data) ->
        latitude = data.geometry.location.lat
        longitude = data.geometry.location.lng
        latlng = latitude + ',' + longitude
        forecastOptions =
          uri: 'https://api.forecast.io/forecast/' + process.env.FORECAST_KEY + '/' + latlng
          qs:
            units: 'us'
          headers:
            'User-Agent': 'Request-Promise'
          json: true

      rp(forecastOptions)
        .then((data) ->
          currentTemp = data.currently.temperature
          summary = data.currently.summary
          icon = data.currently.icon
          feelsLike = data.currently.apparentTemperature
          dailyData = data.daily[0]
          maxTemp = dailyData.temperatureMax
          minTemp = dailyData.temperatureMin
          msg.send('Current Temp: ' + currentTemp + '\n' +
                  'Max Temp:      ' + maxTemp + '\n' +
                  'Min Temp:      ' + minTemp +)
        )
        .catch( (err) ->
          msg.send('Error in forecast call.\n' + err)
        )
    )
    .catch( (err) ->
      msg.send("Error in google geocode call.\n" +  err )
    )
