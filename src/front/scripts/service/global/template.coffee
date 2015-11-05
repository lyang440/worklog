angular.module 'app.service'

.factory 'templateService',
($http, $q, $log, $templateCache) ->
  self = @

  @fetchAll = ->
    $q (resolve, reject) ->
      url = angular.element('#angular-templates').attr 'href'
      $http.get url
      .success (res) ->
        resolve res
      .error (res, status) ->
        res = code: status
        $log.log 'fetch templates failed: ', res.code
        reject res

  @cacheAll = ->
    $q (resolve, reject) ->
      self.fetchAll().then (templateData) ->
        templates = $(templateData).find('script[type="text/ng-template"]')
        templatesLength = templates.length

        if templatesLength == 0
          resolve()
        else
          templates.each (index) ->
            id = $(this).attr 'id'
            content = $(this).text()
            $templateCache.put id, content
            if index == templatesLength - 1 then resolve()
      , (err) ->
        reject err

  return @