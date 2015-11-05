'use strict'

globalOpt = require '../config.coffee'
wacthOpt = require './watch_config.coffee'

appTask = require './app.coffee'

gulp = require 'gulp'
browserSync = require 'browser-sync'

webServer = require 'gulp-webserver'
proxy = require 'proxy-middleware'

runSequence = require('run-sequence').use gulp

module.exports =
  browserSync: ->
    browserSync globalOpt.browserSyncOption

  watch: ->
    gulp.watch wacthOpt.style, -> runSequence 'app-style', 'revision'
    gulp.watch wacthOpt.script, -> runSequence 'app-script', 'revision'
    gulp.watch wacthOpt.template, -> runSequence 'app-template', 'revision'

  webServer: ->
  	gulp.src('src/public/')
      .pipe webServer globalOpt.webserverOption
