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
      headers:
        'User-Agent': 'Request-Promise'
      json: true
      if locationOrig == 'my ass'
        msg.send('It\'s hot and moist out today.')
      else
        rp(locationOptions)
          .then( (data) ->
            if data.results[0].geometry
              latitude = data.results[0].geometry.location.lat
              longitude = data.results[0].geometry.location.lng
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
                  dailyData = data.daily.data[0]
                  maxTemp = dailyData.temperatureMax
                  minTemp = dailyData.temperatureMin
                  deg = '°F'
                  msg.send('Current Temp: ' + currentTemp + deg  + '\n' +
                          'Max Temp:         ' + maxTemp + deg + '\n' +
                          'Min Temp:         ' + minTemp + deg )
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
