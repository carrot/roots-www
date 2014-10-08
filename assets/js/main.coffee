$        = require('zepto-browserify').$
hljs     = require 'highlight.js'
Parallax = require 'parallax.js'

# code highlighting

hljs.initHighlightingOnLoad()

# plax

opts = { scalarX: 2, scalarY: 20 }

if $('#index').length
  new Parallax($('#header .trees')[0], opts)
  new Parallax($('#intro .trees')[0], opts)
  new Parallax($('#resources .trees')[0], opts)
else if $('.trees').length
  new Parallax($('nav .trees')[0], opts)
  new Parallax($('main .trees')[0], opts)

# analytics

if $('body#analytics').length
  client = new Keen
    projectId: '5252fe3d36bf5a4f54000008'
    readKey: 'c26d1b67ebe0f6b8f13441477cf324d84138abe6f79c4127bd2f318e57c94cc228cc102703d00b58cda6277e10d4b6aee1081def2701649dee56938774a5c4241450d382051c729b086370a4cba2dd9712a85814249864bd19942e523cac2116e5dc4c5f3f4276469da0180506b5bb5d'

  api_usage = new Keen.Query 'count',
    eventCollection: 'api'
    groupBy: 'name'
    timeframe: 'this_7_days'
    interval: 'daily'

  client.run(api_usage, console.log.bind(console))
