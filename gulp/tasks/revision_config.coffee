'use strict'

globalOpt = require '../config.coffee'

module.exports =
  revision:
    src: ["#{globalOpt.resourcePath}/**/*"]
    dest: "#{globalOpt.publicPath}/"
