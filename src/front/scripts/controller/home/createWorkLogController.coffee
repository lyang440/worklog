angular.module 'app.controller'

.controller 'createWorkLogController',
($rootScope, $scope, $window, homeService, modalService, notificationService) ->
  $scope.date = ''
  $scope.logDetail = ''
  $scope.mood = 0

  $scope.$on 'markdownContent', (e, result) ->
    $scope.logDetail = result

  $scope.today = ->
    $scope.myDate = new Date()

  $scope.today()

  $scope.maxDate = new Date(2020, 5, 22)

  $scope.myOpened = false
  $scope.$watch 'myDate', ->
    console.log $scope.myDate

  $scope.open = (event) ->
    event.preventDefault()
    event.stopPropagation()
    $scope.myOpened = true

  $scope.dateOptions =
    'year-format': "'yy'"
    'show-weeks' : false

  $scope.addWorkLog = ->
    homeService.add($scope.date, $scope.mood, $scope.logDetail).then (workLogList) ->
      $scope.workLogList = workLogList
    , (err) ->
      notificationService.error '添加错误', '提示'

