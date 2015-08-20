{MathComponent} = require '../lib/MathComponent'

class Test extends MathComponent
  icon: 'plus'
  constructor: ->
    super 'in0', 'in1', 'out'

  calculate: (a, b) ->
    if Number(a) && Number(b) then 1 else 0

exports.getComponent = -> new Test
