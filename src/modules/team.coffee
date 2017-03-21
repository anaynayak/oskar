OskarTexts = require '../content/oskarTexts'

class Team
  constructor: (statuses) ->
    @statuses = statuses

  status: () ->
    s = @teamStatus()
    teamMemberStatus = @teamMemberStatus()
    return {
      status: s
      teamMemberStatus: teamMemberStatus
      statusString: OskarTexts.statusText[s]
    }

  teamMemberStatus: () ->
    seriesData = @statuses.map (status) ->
      series = status.all_feedback.map (f) -> return [f.timestamp, parseInt(f.status)]
      return {name: status.name, data: series}
    return JSON.stringify(seriesData)

  teamStatus: () ->
    teamStatus = 0
    if @statuses.length
      @statuses.forEach (status) ->
        if status.feedback isnt null
          teamStatus += parseInt(status.feedback.status)
    return Math.round(teamStatus / @statuses.length)

module.exports = Team