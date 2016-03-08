# Commands:
#   hubot kait disapproves - Kait disapproves!
#   hubot ben stir* - Ben is sexy coffee



module.exports = (robot) ->

  robot.respond /kait disapproves/i, (msg) ->
    msg.send "https://goo.gl/cTmPh7"

  robot.respond /ben stir(.+)/i, (msg) ->
    msg.send "https://goo.gl/hl6DcH"

  robot.listen /pretty bird/i, (msg) ->
    msg.send "http://www.urbandictionary.com/define.php?term=Boyd"
