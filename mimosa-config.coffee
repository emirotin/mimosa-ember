exports.config =
  minMimosaVersion:"0.14.14"
  template:
    handlebars:
      lib: require('handlebars')
      helpers: ["app/template/handlebars-helpers"]
      ember:
        enabled: true
        path: "ember"