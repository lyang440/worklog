angular.module 'app.directive'

.directive 'slider',
($parse) ->
  restrict: 'E'
  template: '<div class="slider-container"></div>'
  replace: true
  link: (scope, element, attrs) ->
    range = attrs.range
    min = attrs.min
    max = attrs.max
    step = attrs.step
    model = attrs.model
    scopeString = attrs.scope

    if scopeString then targetScope = angular.element("##{scopeString}").scope()
    if !targetScope then targetScope = scope

    opt =
      range: range

    if step
      getter = $parse(step)
      value = getter()
      opt.step = if value && angular.isNumber(value) then value
      targetScope.$watch step, (newValue) -> element.slider 'option', 'step', newValue

    if min
      getter = $parse(min)
      value = getter()
      opt.min = if value && angular.isNumber(value) then value
      targetScope.$watch min, (newValue) -> element.slider 'option', 'min', newValue

    if max
      getter = $parse(max)
      value = getter()
      opt.max = if value && angular.isNumber(value) then value
      targetScope.$watch max, (newValue) -> element.slider 'option', 'max', newValue

    if model
      getter = $parse(model)
      setter = getter.assign
      value = getter()
      opt.value = if value && angular.isNumber(value) then value
      targetScope.$watch model, (value) -> element.slider value: value

      opt.slide = (event, ui) ->
        setter(targetScope, ui.value)
        targetScope.$apply()

    element.slider opt
