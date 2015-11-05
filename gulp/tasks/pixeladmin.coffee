'use strict'

globalOpt = require '../config.coffee'
opt = require './pixeladmin_config.coffee'

# common
gulp = require 'gulp'
gutil = require 'gulp-util'
concat = require 'gulp-concat'
minifier = require 'gulp-minifier'
plumber = require 'gulp-plumber'
del = require 'del'

# for less
less = require 'gulp-less'

# for coffee
coffee = require 'gulp-coffee'

module.exports =
  style: ->
    name = opt.style.name
    src = opt.style.src
    dest = opt.style.dest

    minifierOption = globalOpt.minifierOption
    errHandler = globalOpt.errHandler
    isProd = globalOpt.isProd

    gulp.src src
      .pipe plumber errorHandler: errHandler
      .pipe less()
      .pipe concat name
      .pipe if isProd then minifier minifierOption else gutil.noop()
      .pipe gulp.dest dest

  script: ->
    name = opt.script.name
    src = opt.script.src
    dest = opt.script.dest

    coffeeOption = globalOpt.coffeeOption
    errHandler = globalOpt.errHandler

    gulp.src src
      .pipe plumber errorHandler: errHandler
      .pipe coffee coffeeOption
      .pipe concat name
      .pipe gulp.dest dest

    name = opt.lib.name
    src = opt.lib.src
    dest = opt.lib.dest

    gulp.src src
      .pipe plumber errorHandler: errHandler
      .pipe concat name
      .pipe gulp.dest dest

  build: ->
    name = opt.build.name
    src = opt.build.src
    dest = opt.build.dest

    minifierOption = globalOpt.minifierOption
    isProd = globalOpt.isProd

    gulp.src src
      .pipe concat name
      .pipe if isProd then minifier minifierOption else gutil.noop()
      .pipe gulp.dest dest

  clean: ->
    tempDir = globalOpt.tempPath
    del tempDir
