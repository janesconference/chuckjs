# ChucK type library
define("chuck/types", ->
  module = {}

  class ChuckType
    constructor: (name, parent, opts, constructorCb) ->
      @name = name
      @parent = parent
      @_constructor = constructorCb
      @_opts = opts || {}

      @_constructParent(parent, @_opts)

      if constructorCb
        constructorCb.call(@, @_opts)

    isOfType: (otherType) =>
      if @name == otherType.name
        return true

      parent = @parent
      while parent?
        if parent.isOfType(otherType)
          return true
        parent = parent.parent

      return false

    _constructParent: (parent, opts) =>
      if !parent?
        return

      opts = _(parent._opts).extend(opts)
      @_constructParent(parent.parent, opts)
      if parent._constructor?
        parent._constructor.call(@, opts)

  constructObject = ->
  module.Object = new ChuckType("Object", undefined, preConstructor: constructObject, (opts) ->
    @hasConstructor = opts.preConstructor?
    @preConstructor = opts.preConstructor
    @size = opts.size
  )
  class OscData
    constructor: ->
      @num = 0.0
      @freq = 220.0
      @sync = 0
      @width = 0.5
      @srate =
      @phase = 0.0

  module.UGen = new ChuckType("UGen", module.Object, size: 8, numIns: 1, numOuts: 1, preConstructor: undefined, (opts) ->
    @ugenNumIns = opts.numIns
    @ugenNumOuts = opts.numOuts
  )
  constructOsc = ->
    @data = new OscData()
  module.Osc = new ChuckType("Osc", module.UGen, numIns: 1, numOuts: 1, preConstructor: constructOsc)
  module.SinOsc = new ChuckType("SinOsc", module.Osc, preConstructor: undefined)
  module.UGenStereo = new ChuckType("Ugen_Stereo", module.UGen, numIns: 2, numOuts: 2, preConstructor: undefined)
  module.Dac = new ChuckType("Dac", module.UGenStereo, preConstructor: undefined)
  module.Int = new ChuckType("Int", undefined, size: 8, preConstructor: undefined)
  module.Time = new ChuckType("Time", undefined, size: 8, preConstructor: undefined)
  module.Dur = new ChuckType("Dur", undefined, size: 8, preConstructor: undefined)

  return module
)
