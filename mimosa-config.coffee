exports.config =
  minMimosaVersion:"2.0.0"
  modules:[
    'jshint'
    'csslint'
    'server'
    'require'
    'minify-js'
    'minify-css'
    'live-reload'
    'copy'
    'emblem'
    'coffeescript'
    'sass']
  emblem:
    lib: require('emblem')
    handlebars: require('handlebars')
    emberPath: 'ember'