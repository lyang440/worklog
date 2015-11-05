angular.module 'app.controller'

.controller 'homeController',
($rootScope, $scope, $window, homeService, modalService, notificationService) ->

  $scope.logDetail = ''
  $scope.mood = 0
  $scope.oneAtATime = false
  $scope.showByDate = true
  $scope.date = new Date()
  $scope.department = if $scope.$parent.departmentName then $scope.$parent.departmentName else ''
  $scope.member = if $scope.$parent.memberName then $scope.$parent.memberName else ''

  $scope.$on 'dateSelecteded', (e, result) ->
    $scope.date = result
    $scope.getDepartmentWorkLogList()

  $scope.getDepartmentWorkLogList = ->
    if !$scope.department
      homeService.listByDate($scope.date).then (workLogList) ->
        $scope.workLogList = workLogList
        $scope.showByDate = true
        # for workLog in workLogList
          # $scope.mood_lovely
          # $scope.mood_smile
          # $scope.mood_sad
          # $scope.mood_pain
        console.log workLogList
      , (err) ->
        notificationService.error '刷新错误', '提示'
    else
      homeService.listByDate($scope.date).then (workLogList) ->
        $scope.workLogList = workLogList
        $scope.showByDate = true

        console.log workLogList
      , (err) ->
        notificationService.error '刷新错误', '提示'

  $scope.addWorkLog = ->
    homeService.add(data).then (workLogList) ->
      $scope.workLogList = workLogList
    , (err) ->
      notificationService.error '添加错误', '提示'

  $scope.getDepartmentWorkLogList()