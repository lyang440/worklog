angular.module 'app.directive'

.directive 'mydatepicker', ->
  restrict: "E"
  templateUrl: 'templates/home/datepicker.html'
  scope:
    ngModel: "=ngModel"
    dateOptions: "="
    opened: "="

  link: ($scope, element, attrs) ->
    $scope.open = (event) ->
      console.log $scope.ngModel
      event.preventDefault()
      event.stopPropagation()
      $scope.opened = true

    $scope.clear = ->
      $scope.ngModel = null
    # element.datepicker()

