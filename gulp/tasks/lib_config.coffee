'use strict'

globalOpt = require '../config.coffee'

cssName = 'libs.min.css'
jsName = 'libs.min.js'

module.exports =
  style:
    name: cssName
    src: [
      "#{globalOpt.libPath}/bootstrap/dist/css/bootstrap.min.css"
      "#{globalOpt.libPath}/angular-bootstrap/ui-bootstrap-tpls.css"
    ]
    dest: "#{globalOpt.resourcePath}/css/"

  script:
    name: jsName
    src: [
      "#{globalOpt.libPath}/jquery/dist/jquery.js"

      "#{globalOpt.libPath}/bootstrap/dist/js/bootstrap.min.js"
      "#{globalOpt.libPath}/angular/angular.js"
      "#{globalOpt.libPath}/angular-ui-router/release/angular-ui-router.min.js"
      "#{globalOpt.libPath}/angular-bootstrap/ui-bootstrap-tpls.min.js"
      "#{globalOpt.libPath}/bootstrap-datepicker/js/bootstrap-datepicker.js"

    ]
    dest: "#{globalOpt.resourcePath}/js/"
