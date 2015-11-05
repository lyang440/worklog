'use strict'

globalOpt = require '../config.coffee'
revisionOpt = require './revision_config.coffee'

gulp = require 'gulp'
gutil = require 'gulp-util'
RevAll = require 'gulp-rev-all'
browserSync = require 'browser-sync'
reload = browserSync.reload

module.exports =
  revision: ->
    src = revisionOpt.revision.src
    dest = revisionOpt.revision.dest
    isWatch = globalOpt.isWatch

    revAll = new RevAll globalOpt.revisionOption
    gulp.src src
      .pipe revAll.revision()
      .pipe gulp.dest dest
      .pipe revAll.versionFile()
      .pipe gulp.dest dest
      .pipe if isWatch then reload stream: true else gutil.noop()
      .pipe revAll.manifestFile()
      .pipe gulp.dest dest
