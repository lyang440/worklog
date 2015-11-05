angular.module 'app.directive'

.directive 'waterflowLoading', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
  	callback = element.waterflowLoading
  	slefWindow = $(window)
  	windowHeight = slefWindow.height()

  	slefWindow.on 'resize', -> windowHeight = slefWindow.height()

  	slefWindow.on 'scroll', ->
  		elementHeight = element.height()
  		invisibleHeight = element.height() - windowHeight
  		ratio = invisibleHeight / elementHeight
  		scrollTop = slefWindow.scrollTop()

  		if scrollTop / elementHeight >= ratio
  			scope.$emit 'scrollInBottom'
  			scope.$broadcast 'scrollInBottom'

