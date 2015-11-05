'use strict'

globalOpt = require '../config.coffee'

cssName = 'app.min.css'
jsName = 'app.min.js'
templateName = 'templates.html'

module.exports =
  style:
    name: cssName
    src: ["#{globalOpt.basePath}/styles/app.less"]
    dest: "#{globalOpt.resourcePath}/css/"

  script:
    name: jsName
    src: [
      "#{globalOpt.basePath}/scripts/**/*.coffee"
    ]
    dest: "#{globalOpt.resourcePath}/js/"

  # TODO: image compress
  image:
    src: ["#{globalOpt.resourcePath}/image/*.png"]
    dest: "#{globalOpt.resourcePath}/image/compressed/"

  template:
    name: templateName
    src: ["#{globalOpt.basePath}/templates/**/*.html", "!#{globalOpt.basePath}/templates/#{templateName}"]
    dest: "#{globalOpt.resourcePath}/"
    templateSrc: "#{globalOpt.basePath}/templates/#{templateName}"
