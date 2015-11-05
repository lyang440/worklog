'use strict'

globalOpt = require '../config.coffee'
opt = require './lib_config.coffee'

# common
gulp = require 'gulp'
gutil = require 'gulp-util'
concat = require 'gulp-concat'
minifier = require 'gulp-minifier'
plumber = require 'gulp-plumber'

# for less
less = require 'gulp-less'

# for coffee
coffee = require 'gulp-coffee'

module.exports =
  style: (isReload) ->
    name = opt.style.name
    src = opt.style.src
    dest = opt.style.dest

    minifierOption = globalOpt.minifierOption
    errHandler = globalOpt.errHandler
    isProd = globalOpt.isProd

    gulp.src src
      .pipe plumber errorHandler: errHandler
      .pipe concat name
      .pipe if isProd then minifier minifierOption else gutil.noop()
      .pipe gulp.dest dest
      .pipe if isReload then reload stream: true else gutil.noop()

  script: (isReload) ->
    name = opt.script.name
    src = opt.script.src
    dest = opt.script.dest

    minifierOption = globalOpt.minifierOption
    errHandler = globalOpt.errHandler
    isProd = globalOpt.isProd

    gulp.src src
      .pipe plumber errorHandler: errHandler
      .pipe concat name
      .pipe if isProd then minifier minifierOption else gutil.noop()
      .pipe gulp.dest dest
      .pipe if isReload then reload stream: true else gutil.noop()
