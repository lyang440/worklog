angular.module 'app.constant', []

angular.module 'app.controller', []

angular.module 'app.directive', []

angular.module 'app.filter', []

angular.module 'app.routeFilter', []

angular.module 'app.utils', []

angular.module 'app.service', ['app.utils', 'ui.bootstrap']

angular.module 'app', [
    'ui.router'
    'ui.bootstrap'

    'app.utils'
    'app.constant'
    'app.filter'
    'app.controller'
    'app.service'
    'app.directive'
]
