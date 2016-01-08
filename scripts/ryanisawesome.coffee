# Commands:
#   hubot ryan - repspons with a nice message



module.exports = (robot) ->
  robot.respond /ryan/i, (msg) ->
    msg.send "Ryan is a gawd among programmers!"
