'use strict'

globalOpt = require '../config.coffee'

module.exports =
  style: [
    "#{globalOpt.stylePath}/**/*.less"
    "!#{globalOpt.stylePath}/pixel-admin.less"
  ]

  script: [
    "#{globalOpt.basePath}/scripts/**/*.coffee"
    "#{globalOpt.basePath}/scripts/app.coffee"
    "#{globalOpt.basePath}/scripts/route.coffee"
  ]

  template: ["#{globalOpt.basePath}/templates/**/*.html"]

