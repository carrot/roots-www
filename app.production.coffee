axis            = require 'axis'
rupture         = require 'rupture'
autoprefixer    = require 'autoprefixer-stylus'
jeet            = require 'jeet'
browserify      = require 'roots-browserify'
dynamic_content = require 'dynamic-content'
yaml            = require 'roots-yaml'

module.exports =
  ignores: ['readme.md', '**/*layout.*', '**/_*', '.gitignore', '.editorconfig', 'ship.conf']

  locals:
    title: 'Roots: Enlightened Static Sites'
    author: 'Jeff Escalante'
    description: 'Roots: a modern, powerful, and open source static site generator'

  extensions: [
    dynamic_content(),
    browserify(files: 'assets/js/main.coffee', out: 'js/build.js', minify: true),
    yaml()
  ]

  stylus:
    use: [axis(), rupture(), jeet(), autoprefixer()]
