# Commands:
#   hubot kait disapproves - Kait disapproves!



module.exports = (robot) ->

  robot.respond /kait disapproves/i, (msg) ->
    msg.send "https://goo.gl/cTmPh7"

  robot.respond /ben stir(?=s| |$) (.+)/i, (msg) ->
    msg.send "https://goo.gl/hl6DcH"
