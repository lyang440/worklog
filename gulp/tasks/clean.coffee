'use strict'

globalOpt = require '../config.coffee'
appOpt = require './app_config.coffee'
libOpt = require './lib_config.coffee'
revisionOpt = require './revision_config.coffee'
pixeladminOpt = require './pixeladmin_config.coffee'

gulp = require 'gulp'
del = require 'del'

module.exports =
  clean: (callback) ->
    pixelAdminMinJs = "#{pixeladminOpt.build.dest}#{pixeladminOpt.build.name}"
    pixelAdminMinCss = "#{pixeladminOpt.style.dest}#{pixeladminOpt.style.name}"
    libMinJs = "#{libOpt.script.dest}#{libOpt.script.name}"
    libMinCss = "#{libOpt.style.dest}#{libOpt.style.name}"
    appMinJs = "#{appOpt.script.dest}#{appOpt.script.name}"
    appMinCss = "#{appOpt.style.dest}#{appOpt.style.name}"
    appAngularTemplate = "#{appOpt.template.dest}#{appOpt.template.name}"
    built = "#{revisionOpt.revision.dest}"

    files = []
    files = files.concat pixelAdminMinJs, pixelAdminMinCss, libMinJs, libMinCss, appMinJs, appMinCss, appAngularTemplate, built

    del files, callback
