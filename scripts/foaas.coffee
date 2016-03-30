
module.exports = (robot) ->
  namePattern = /name:(\S\w+)/i
  # subset of operations defined at http://foaas.com/operations
  operations = [
    '/off/:name/:from',
    '/you/:name/:from',
    '/donut/:name/:from',
    '/shakespeare/:name/:from',
    '/linus/:name/:from',
    '/king/:name/:from',
    '/chainsaw/:name/:from',
    '/outside/:name/:from',
    '/madison/:name/:from',
    '/nugget/:name/:from',
    '/yoda/:name/:from',
    '/bus/:name/:from',
    '/xmas/:name/:from',
    '/bday/:name/:from',
    '/shutup/:name/:from'
  ]

  FOAAS = 'http://foaas.com'

  robot.respond /foaas (.*)/i, (res) ->
    name = namePattern.exec res.match[0]
    name = name[1]
    from = res.message.user.name.toLowerCase()

    if name
      endpoint = FOAAS + operations[Math.floor(Math.random() * operations.length)]
      endpoint = endpoint.replace(":name",name).replace(":from",from)
      robot.http(endpoint).header("Accept", "text/plain").get() (err, res, body) ->
        res.send body
    else
      res.send "I didn't understand that"
