memeGenerator = require "hubot-meme/src/lib/memecaptain.coffee"

module.exports = (robot) ->

  robot.respond /(.+) (waka .+)/i, id: 'meme.the-waka', (msg) ->
    memeGenerator msg, 'mT1y5Q', msg.match[1], msg.match[2]
