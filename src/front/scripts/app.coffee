angular.module 'app'

.config(
	($sceProvider) ->
  $sceProvider.enabled false
  # localStorageServiceProvider.setPrefix 'app'
)

.run (
	($rootScope, $state, $http) ->
		$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'
		$rootScope.$state = $state
)
