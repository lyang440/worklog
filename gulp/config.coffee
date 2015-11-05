'use strict'

gutil = require 'gulp-util'

proxy = require 'proxy-middleware'
url = require 'url'

class options
  constructor: ->
    self = this
    @basePath = "src/front"
    @publicPath = 'src/public'
    @stylePath = "#{@.basePath}/styles"
    @resourcePath = "#{@.basePath}/resources"
    @libPath = "bower_components"
    @tempPath = "#{@.basePath}/temp"
    @hornPath = "#{@.libPath}/horn"
    @pixeladminPath = "#{@.hornPath}/frameworks/pixeladmin"

    @cdnDomain = ''

    @isProd = false
    @isWatch = false

    @lessOption =
      paths = []

    @coffeeOption =
      bare = true

    @minifierOption =
      minify: true
      collapseWhitespace: true
      conservativeCollapse: true
      minifyJS: true
      minifyCSS: true

    @annotateOption = single_quotes: true

    @templateOption =
      base: "#{@.basePath}/"
      selector: '#templates-container'
      unescape:
        '&lt;': '<'
        '&gt;': '>'
        '&apos;': '\''
        '&amp;': '&'
        '&quot;': '"'

    @revisionOption =
      dontGlobal: ['robots.txt', /fontawesome.*?/i]
      dontRenameFile: ['index.html']
      transformPath: (rev, source, path) ->
        if self.isProd then prefix = "#{self.cdnDomain}/" else prefix = '/'
        relativePathRegex = /(\.\.\/|\.\/|\/)?/

        if !self.isProd
          pathDoNotTransform = [
            '../image/logo.png'
            '../image/sprite.png'
            '../fonts/font-awesome/fontawesome-webfont.eot'
            '../fonts/font-awesome/fontawesome-webfont.svg'
            '../fonts/font-awesome/fontawesome-webfont.ttf'
            '../fonts/font-awesome/fontawesome-webfont.woff'
          ]

          for item in pathDoNotTransform
            if source is item then return rev

        if rev.indexOf('//') != 0 && relativePathRegex.test(rev) # replace ./ or ../ or / but not // and else
          return rev.replace relativePathRegex, prefix

        return rev # return origin value when nothing have change


    @browserSyncOption =
      open: false
      port: 3007
      server:
        baseDir: "./"
        middleware: [
          (req, res, next) ->
            referer = req.headers['referer']
            if referer
              req.headers['referer'] = referer.replace(':3007', ':3000')
            next()
          proxy(url.parse 'http://localhost:3000')
        ]

    @webserverOption =
      port: 3000
      path:'/'
      open: true
      proxies: [{
        source: '/apiServer'
        target: ''
        }]

    @errHandler = (err) ->
      gutil.beep()
      gutil.log err
      this.emit 'end'

opt = new options

module.exports = opt
