angular.module 'app.controller'

.controller 'LayoutController',
($rootScope, $scope, $window, homeService, modalService) ->
  $scope.$on '$viewContentLoaded', (event)->
    if event.targetScope == $scope
      $window.PixelAdmin.start()
      $window.onload()
      $scope.today()

  $scope.today = ->
    $scope.date = new Date()

  $scope.maxDate = new Date(2020, 5, 22)

  $scope.opened = false
  $scope.$watch 'date', ->
    $scope.$broadcast 'dateSelecteded', $scope.date
    # if $scope.date
    #   console.log $scope.date
    #   $rootScope.$state.go 'layout.home'

  $scope.open = (event) ->
    event.preventDefault()
    event.stopPropagation()
    $scope.opened = true

  $scope.dateOptions =
    'year-format': "'yy'"
    'show-weeks' : false

  $scope.getDepartments = ->
    homeService.list().then (departmentData) ->
      $scope.departments = departmentData
    , (err) ->
      notificationService.error '刷新错误', '提示'

  $scope.departmentSelected = (name) ->
    $scope.departmentName = name

  $scope.memberSelected = (name) ->
    $scope.memberName = name

  $scope.addMyWorkLog = ->
    modalService.customize
    opt =
      templateUrl: 'templates/home/createWorkLog.html'
      controller: 'createWorkLogController'

    modalService.customize opt, $scope

  $scope.getDepartments()



