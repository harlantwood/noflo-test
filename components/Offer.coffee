noflo = require 'noflo'

exports.getComponent = ->
  c = new noflo.Component
  c.inPorts.add 'in',
    datatype: 'object'
  c.outPorts.add 'existing',
    datatype: 'array'
  c.outPorts.add 'new',
    datatype: 'object'
