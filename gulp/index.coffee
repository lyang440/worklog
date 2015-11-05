'use strict'

globalOpt = require './config.coffee'

appTask = require './tasks/app.coffee'
libTask = require './tasks/lib.coffee'
pixeladminTask = require './tasks/pixeladmin.coffee'
revisionTask = require './tasks/revision.coffee'
cleanTask = require './tasks/clean.coffee'
watchTask = require './tasks/watch.coffee'

gulp = require 'gulp'
runSequence = require('run-sequence').use gulp

module.exports = ->
  gulp.task 'web-server', -> watchTask.webServer()

  #for pixel-admin
  gulp.task 'pixel-script', -> pixeladminTask.script()
  gulp.task 'pixel-style', -> pixeladminTask.style()
  gulp.task 'pixel-build', -> pixeladminTask.build()
  gulp.task 'pixel-clean', -> pixeladminTask.clean()

  # for libs
  gulp.task 'lib-style', -> libTask.style()
  gulp.task 'lib-script', -> libTask.script()

  # for app
  gulp.task 'app-script', -> appTask.script()
  gulp.task 'app-style', -> appTask.style()
  gulp.task 'app-image', -> appTask.image()
  gulp.task 'app-template', -> appTask.template()

  # else
  gulp.task 'revision', -> revisionTask.revision()
  gulp.task 'clean', -> cleanTask.clean()

  # global
  gulp.task 'watch', ->
    globalOpt.isWatch = true
    gulp.task 'browser-sync', -> watchTask.browserSync()
    gulp.task 'watch-app', -> watchTask.watch()
    runSequence 'clean', 'pixel-script', 'pixel-style', 'pixel-build', 'pixel-clean', 'lib-style', 'lib-script', 'app-script', 'app-style', 'app-image', 'app-template', 'revision', 'web-server', 'browser-sync', 'watch-app'

  gulp.task 'prod', ->
    globalOpt.isProd = true
    runSequence 'clean', 'pixel-script', 'pixel-style', 'pixel-build', 'pixel-clean', 'lib-style', 'lib-script', 'app-script', 'app-style', 'app-image', 'app-template', 'revision'

  gulp.task 'default', ->
    runSequence 'clean', 'pixel-script', 'pixel-style', 'pixel-build', 'pixel-clean', 'lib-style', 'lib-script', 'app-script', 'app-style', 'app-image', 'app-template', 'revision'
