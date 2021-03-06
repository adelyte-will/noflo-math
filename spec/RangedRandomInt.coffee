noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  Random = require '../components/RangedRandomInt.coffee'
else
  Random = require 'noflo-math/components/RangedRandomInt.js'

describe 'RangedRandomInt component', ->
  c = null
  bang = null
  lower = null
  upper = null
  result = null
  beforeEach ->
    c = Random.getComponent()
    bang = noflo.internalSocket.createSocket()
    lower = noflo.internalSocket.createSocket()
    upper = noflo.internalSocket.createSocket()
    result = noflo.internalSocket.createSocket()
    c.inPorts.in.attach bang
    c.inPorts.lower.attach lower
    c.inPorts.upper.attach upper
    c.outPorts.out.attach result

  describe 'when instantiated', ->

    it 'should generate number between lower and upper', (done) ->
      result.once 'data', (res) ->
        chai.expect(res).to.be.within(1, 6)
        done()
      lower.send 1
      upper.send 6
      bang.send null

    it 'should generate an integer number', (done) ->
      result.once 'data', (res) ->
        chai.expect(res).to.equal(Math.floor res)
        done()
      lower.send 1
      upper.send 6
      bang.send null

    it 'should generate handle mixed lower and upper', (done) ->
      result.once 'data', (res) ->
        chai.expect(res).to.be.within(1, 6)
        done()
      lower.send 6
      upper.send 1
      bang.send null


