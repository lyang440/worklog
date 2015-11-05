angular.module 'app'
.factory 'modalService',
($rootScope, $timeout, $modal, $q) ->
  @confirm = (message) ->
    $q (resolve, reject) ->
      bootbox.confirm message, (result) ->
        if result then resolve() else reject()

  @alert = (message) ->
      $q (resolve, reject) -> bootbox.alert message, resolve

  @customize = (opt, scope = $rootScope) ->
    opt.scope = scope
    opt.scope.$on '$destroy', -> modal.dismiss() # dismiss when scope destroy

    windowClass = 'custom-modal-' + Math.floor Math.random()*100000
    opt.windowClass = windowClass

    modal = $modal.open opt

    modal.opened.then ->
      $timeout ->
        inputs = angular.element(".#{windowClass} input")
        inputs.eq(0).trigger 'focus'
        inputs.on 'keydown', (event) ->
          e = event || $window.event
          if e.keyCode == KEY_CODE_ENTER then scope.$broadcast 'enterKeyDown'
      , 100

    return modal

  return @
