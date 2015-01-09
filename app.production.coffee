axis            = require 'axis'
rupture         = require 'rupture'
autoprefixer    = require 'autoprefixer-stylus'
jeet            = require 'jeet'
browserify      = require 'roots-browserify'
dynamic_content = require 'dynamic-content'

module.exports =
  ignores: ['readme.md', '**/*layout.*', '**/_*', '.gitignore']

  locals:
    title: 'Roots: Enlightened Static Sites'
    author: 'Jeff Escalante'
    description: 'Roots: a modern, powerful, and open source static site generator'

  extensions: [
    dynamic_content(),
    browserify(files: 'assets/js/main.coffee', out: 'js/build.js', minify: true)
  ]

  stylus:
    use: [axis(), rupture(), jeet(), autoprefixer()]
