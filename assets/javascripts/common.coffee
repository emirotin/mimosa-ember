requirejs.config
  shim:
    handlebars:
      deps: []
      exports: "Handlebars"
    ember:
      deps: ["handlebars", "jquery"]
      exports: "Ember"
  paths:
    jquery: "vendor/jquery/jquery"
    handlebars: "vendor/handlebars/handlebars"
    ember: "vendor/ember-shim/ember"
