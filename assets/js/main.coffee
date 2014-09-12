$ = require('zepto-browserify').$
hljs = require 'highlight.js'

console.log 'hello there'
console.log $('pre')

hljs.initHighlightingOnLoad()
