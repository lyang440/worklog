angular.module 'app'

.provider 'env', envProvider = ->
  @env =
    API_URL: ''

  @$get = -> @env

  @