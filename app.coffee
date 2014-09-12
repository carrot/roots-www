axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
jeet         = require 'jeet'
browserify   = require 'roots-browserify'

module.exports =
  ignores: ['readme.md', '**/*layout.*', '**/_*', '.gitignore']

  extensions: [
    browserify(files: 'assets/js/main.coffee', out: 'js/build.js', minify: true)
  ]

  stylus:
    use: [axis(), rupture(), jeet(), autoprefixer()]

  server:
    clean_urls: true
