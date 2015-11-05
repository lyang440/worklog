###

notification service 封装了 jquery growl 插件

用法:

[
  'notificationService'

  (notification) ->
    # 右上角弹出默认的提示框，一段时间(3.2s)后消失
    notification.notify 'some message'

    # 右上角弹出默认的提示框，永久显示，要手动关闭
    notification.notify 'some message', true

    # 直接传入 growl 具体配置
    notification.notify
      title: 'You Need To Know!'
      message: 'some message'
      type: 'error'
      size: 'large'
      location: 'bc'
]

###

(->
  angular.module 'app.service'

  .factory 'notificationService',
  ->
    LONG_DURATION = 9999 * 9999

    wrappeOption = (opt, title, isStatic) ->
      option =
        title: ''
        message: ''

      if typeof opt is 'string'
          option.title = title
          option.message = opt
      else
        option = opt

      option.duration = LONG_DURATION if isStatic

      return option

    # shorthand of growl default
    @notify = (msg, title = '提示', isStatic = false) ->
      $.growl wrappeOption msg, title, isStatic

    # shorthand of growl.notice
    @success = (msg, title = '成功', isStatic = false) ->
      $.growl.notice wrappeOption msg, title, isStatic

    # shorthand of growl.error
    @error = (msg, title = '失败', isStatic = false) ->
      $.growl.error wrappeOption msg, title, isStatic

    # shorthand of growl.warning
    @warning = (msg, title = '警告', isStatic = false) ->
      $.growl.warning wrappeOption msg, title, isStatic

    return @
)()
