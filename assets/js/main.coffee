$    = require('zepto-browserify').$
hljs = require 'highlight.js'
Parallax = require 'parallax.js'

# code highlighting
hljs.initHighlightingOnLoad()

# plax
opts = { scalarX: 2, scalarY: 20 }
new Parallax($('#header .trees')[0], opts)
new Parallax($('#intro .trees')[0], opts)
new Parallax($('#resources .trees')[0], opts)
