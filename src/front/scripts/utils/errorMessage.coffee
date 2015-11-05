(->
  angular.module 'app.utils'

  .factory 'errorMsgUtil',
  (errorConstants) ->

    @ofCode = (code) ->
      code ?= 0

      msg = errorConstants[code]
      msg = '未知错误' unless msg

      return "[#{code}] #{msg}"

    return @
)()
