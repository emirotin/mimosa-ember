exports.config =
  minMimosaVersion:"1.0.0"
  compilers:
    libs:
      handlebars: require('handlebars')
  template:
    handlebars:
      helpers: ["app/template/handlebars-helpers"]
      ember:
        enabled: true
        path: "ember"