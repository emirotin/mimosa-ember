exports.config =
  minMimosaVersion:"0.12.6"  # 0.12.6 required for handlebars lib switching
  template:
    handlebars:
      lib: require('handlebars')
      helpers: ["app/template/handlebars-helpers"]
      ember:
        enabled: true
        path: "ember"