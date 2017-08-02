noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.inPorts.add 'in',
    datatype: 'object'
  c.outPorts.add 'existing',
    datatype: 'array'
  c.outPorts.add 'new',
    datatype: 'object'

  noflo.helpers.WirePattern c,
    out: ['existing', 'new']
    async: true
  , (data, groups, out, callback) ->
    unless data.state?.projects?.length
      # No local projects, pass
      out.new.send data
      do callback
      return

    existing = data.state.projects.filter (project) ->
      project.gist is data.payload.graph
    unless existing.length
      out.new.send data
      do callback
      return

    out.existing.send [
      'project'
      existing[0].id
      existing[0].main
    ]
    do callback
