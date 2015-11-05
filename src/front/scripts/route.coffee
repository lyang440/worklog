angular.module 'app'

.config ($stateProvider, $urlRouterProvider, $httpProvider) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider.state 'layout',
    url: ''
    abstract: true
    controller: 'LayoutController'
    templateUrl: 'templates/layout.html'

  .state 'layout.home',
    url: '/'
    controller: 'homeController'
    templateUrl: 'templates/home/index.html'
    data:
      pageTitle: '工作日志'
    filter: []

.run(
  ($rootScope, $state, $injector, templateService, notificationService) ->
    currentState = ''
    currentParams = {}
    isCached = false
    goState = (toState, stateName, stateParams) ->
      filters = toState.filter

      if filters && filters.length == 0
        currentState = stateName
        currentParams = stateParams
        $rootScope.$state.go stateName, currentParams
        return

      i = 0

      filterCaller = ->
        filter = filters[i]

        if !filter
          currentState = stateName
          currentParams = stateParams
          $rootScope.$state.go stateName, currentParams # continue statue finally
          return

        promise = $injector.invoke filter

        promise.then (result) ->
          if result == false
            i++
            filterCaller()
          else
            currentState = result

        promise.catch = (err) -> notificationService.error '页面加载失败，请重试', ''

      filterCaller()

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      stateName = toState.name
      stateParams = toParams

      if stateName != currentState
        event.preventDefault()

        if isCached
          goState toState, stateName, stateParams
        else
          templatePromise = templateService.cacheAll()
          templatePromise.then ->
            isCached = true
            goState toState, stateName, stateParams
          templatePromise.catch (err) -> notificationService.error '模板加载失败，请重试', ''
)
