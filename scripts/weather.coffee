# Commands:
#   hubot weather - Weather info for the specified address

rp = require('request-promise')

module.exports = (robot) ->
  robot.respond /weather (.*)/i, (msg) ->
    locationOrig = msg.match[1]
    location = escape(msg.match[1]) or 'Kansas City'
    locationOptions =
      uri: 'http://maps.googleapis.com/maps/api/geocode/json'
      qs:
        address: location
      headers: 'User-Agent': 'Request-Promise'
      json: true

    if locationOrig == 'my ass'
      msg.send('It\'s hot and moist out today.')
    else
      rp(locationOptions)
        .then( (data) ->
          if data.results[0].geometry
            geo = data.results[0]
            latitude = geo.geometry.location.lat
            longitude = geo.geometry.location.lng
            latlng = latitude + ',' + longitude
            address = geo.formatted_address
            forecastOptions =
              uri: 'https://api.forecast.io/forecast/' + process.env.FORECAST_KEY + '/' + latlng
              qs:
                units: 'us'
              headers: 'User-Agent': 'Request-Promise'
              json: true

            rp(forecastOptions)
              .then((data) ->
                currentTemp = data.currently.temperature
                summary = data.currently.summary
                icon = data.currently.icon
                feelsLike = data.currently.apparentTemperature
                dailyData = data.daily.data[0]
                maxTemp = dailyData.temperatureMax
                minTemp = dailyData.temperatureMin
                deg = '°F'
                msg.send(address + '\n' +
                        'Currently:   ' + Math.round(currentTemp) + deg  + '\n' +
                        'High:             ' + Math.round(maxTemp) + deg + '\n' +
                        'Low:              ' + Math.round(minTemp) + deg )
              )
              .catch( (err) ->
                msg.send('No weather today. Stay indoors and don\'t look outside.')
              )
          else
            msg.send('Nope. Sorry. Not happening.')
      )
      .catch( (err) ->
        msg.send('Whoops something went wrong.')
    )
