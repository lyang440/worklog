'use strict'

globalOpt = require '../config.coffee'
opt = require './app_config.coffee'

# common
gulp = require 'gulp'
gutil = require 'gulp-util'
concat = require 'gulp-concat'
minifier = require 'gulp-minifier'
rename = require 'gulp-rename'
plumber = require 'gulp-plumber'
_ = require 'lodash'

# for less
less = require 'gulp-less'
prefix = require 'gulp-autoprefixer'

# for coffee
coffee = require 'gulp-coffee'

# for image compress

# for angular
angularAnnotate = require 'gulp-ng-annotate'
angularTemplateConcater = require 'gulp-inline-angular-templates'

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
      .pipe prefix("last 20 version", "> 1%", "ie 8", "ie 7")
      .pipe concat 'app.css'
      .pipe if isProd then minifier minifierOption else gutil.noop()
      .pipe rename name
      .pipe gulp.dest dest

  script: ->
    name = opt.script.name
    src = opt.script.src
    dest = opt.script.dest

    minifierOption = globalOpt.minifierOption
    annotateOption = globalOpt.annotateOption
    coffeeOption = globalOpt.coffeeOption
    errHandler = globalOpt.errHandler
    isProd = globalOpt.isProd

    gulp.src src
      .pipe plumber errorHandler: errHandler
      .pipe coffee coffeeOption
      .pipe concat 'app.js'
      .pipe angularAnnotate annotateOption
      .pipe if isProd then minifier minifierOption else gutil.noop()
      .pipe rename name
      .pipe gulp.dest dest

  image: ->
    src = opt.image.src
    dest = opt.image.dest

  template: ->
    src = opt.template.src
    dest = opt.template.dest
    templateSrc = opt.template.templateSrc
    templateOption = _.cloneDeep globalOpt.templateOption

    gulp.src src
      .pipe angularTemplateConcater templateSrc, templateOption
      .pipe gulp.dest dest
