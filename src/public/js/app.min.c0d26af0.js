(function() {
  angular.module('app.constant', []);

  angular.module('app.controller', []);

  angular.module('app.directive', []);

  angular.module('app.filter', []);

  angular.module('app.routeFilter', []);

  angular.module('app.utils', []);

  angular.module('app.service', ['app.utils', 'ui.bootstrap']);

  angular.module('app', ['ui.router', 'ui.bootstrap', 'app.utils', 'app.constant', 'app.filter', 'app.controller', 'app.service', 'app.directive']);

}).call(this);

(function() {
  angular.module('app').config(['$sceProvider', function($sceProvider) {
    return $sceProvider.enabled(false);
  }]).run((['$rootScope', '$state', '$http', function($rootScope, $state, $http) {
    $http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
    return $rootScope.$state = $state;
  }]));

}).call(this);

(function() {
  var envProvider;

  angular.module('app').provider('env', envProvider = function() {
    this.env = {
      API_URL: ''
    };
    this.$get = function() {
      return this.env;
    };
    return this;
  });

}).call(this);

(function() {
  angular.module('app').config(['$stateProvider', '$urlRouterProvider', '$httpProvider', function($stateProvider, $urlRouterProvider, $httpProvider) {
    $urlRouterProvider.otherwise('/');
    return $stateProvider.state('layout', {
      url: '',
      abstract: true,
      controller: 'LayoutController',
      templateUrl: 'templates/layout.html'
    }).state('layout.home', {
      url: '/',
      controller: 'homeController',
      templateUrl: 'templates/home/index.html',
      data: {
        pageTitle: '工作日志'
      },
      filter: []
    });
  }]).run(['$rootScope', '$state', '$injector', 'templateService', 'notificationService', function($rootScope, $state, $injector, templateService, notificationService) {
    var currentParams, currentState, goState, isCached;
    currentState = '';
    currentParams = {};
    isCached = false;
    goState = function(toState, stateName, stateParams) {
      var filterCaller, filters, i;
      filters = toState.filter;
      if (filters && filters.length === 0) {
        currentState = stateName;
        currentParams = stateParams;
        $rootScope.$state.go(stateName, currentParams);
        return;
      }
      i = 0;
      filterCaller = function() {
        var filter, promise;
        filter = filters[i];
        if (!filter) {
          currentState = stateName;
          currentParams = stateParams;
          $rootScope.$state.go(stateName, currentParams);
          return;
        }
        promise = $injector.invoke(filter);
        promise.then(function(result) {
          if (result === false) {
            i++;
            return filterCaller();
          } else {
            return currentState = result;
          }
        });
        return promise["catch"] = function(err) {
          return notificationService.error('页面加载失败，请重试', '');
        };
      };
      return filterCaller();
    };
    return $rootScope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams) {
      var stateName, stateParams, templatePromise;
      stateName = toState.name;
      stateParams = toParams;
      if (stateName !== currentState) {
        event.preventDefault();
        if (isCached) {
          return goState(toState, stateName, stateParams);
        } else {
          templatePromise = templateService.cacheAll();
          templatePromise.then(function() {
            isCached = true;
            return goState(toState, stateName, stateParams);
          });
          return templatePromise["catch"](function(err) {
            return notificationService.error('模板加载失败，请重试', '');
          });
        }
      }
    });
  }]);

}).call(this);

(function() {
  angular.module('app.controller').controller('LayoutController', ['$scope', '$window', 'modalService', function($scope, $window, modalService) {
    $scope.today = function() {
      return $scope.dt = new Date();
    };
    $scope.maxDate = new Date(2020, 5, 22);
    $scope.opened = false;
    $scope.$watch('dt', function() {
      return console.log($scope.dt);
    });
    $scope.open = function(event) {
      event.preventDefault();
      event.stopPropagation();
      return $scope.opened = true;
    };
    $scope.dateOptions = {
      'year-format': "'yy'",
      'show-weeks': false
    };
    $scope.$on('$viewContentLoaded', function(event) {
      if (event.targetScope === $scope) {
        $window.PixelAdmin.start();
        $window.onload();
        return $scope.today();
      }
    });
    return $scope.addMyWorkLog = function() {
      var opt;
      modalService.customize;
      opt = {
        templateUrl: 'templates/home/createWorkLog.html',
        controller: 'createWorkLogController'
      };
      return modalService.customize(opt, $scope);
    };
  }]);

}).call(this);

(function() {
  angular.module('app.directive').directive('mydatepicker', function() {
    return {
      restrict: "E",
      templateUrl: 'templates/home/datepicker.html',
      scope: {
        ngModel: "=ngModel",
        dateOptions: "=",
        opened: "="
      },
      link: function($scope, element, attrs) {
        $scope.open = function(event) {
          console.log($scope.ngModel);
          event.preventDefault();
          event.stopPropagation();
          return $scope.opened = true;
        };
        return $scope.clear = function() {
          return $scope.ngModel = null;
        };
      }
    };
  });

}).call(this);

(function() {
  angular.module('app.directive').directive('markDown', ['$filter', function($filter) {
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        var previewContent;
        previewContent = '';
        return element.markdown({
          iconlibrary: 'fa',
          onBlur: function(e) {
            previewContent = e.getContent();
            return scope.$emit('markdownContent', previewContent);
          }
        });
      }
    };
  }]);

}).call(this);

(function() {
  angular.module('app.directive').directive('slider', ['$parse', function($parse) {
    return {
      restrict: 'E',
      template: '<div class="slider-container"></div>',
      replace: true,
      link: function(scope, element, attrs) {
        var getter, max, min, model, opt, range, scopeString, setter, step, targetScope, value;
        range = attrs.range;
        min = attrs.min;
        max = attrs.max;
        step = attrs.step;
        model = attrs.model;
        scopeString = attrs.scope;
        if (scopeString) {
          targetScope = angular.element("#" + scopeString).scope();
        }
        if (!targetScope) {
          targetScope = scope;
        }
        opt = {
          range: range
        };
        if (step) {
          getter = $parse(step);
          value = getter();
          opt.step = value && angular.isNumber(value) ? value : void 0;
          targetScope.$watch(step, function(newValue) {
            return element.slider('option', 'step', newValue);
          });
        }
        if (min) {
          getter = $parse(min);
          value = getter();
          opt.min = value && angular.isNumber(value) ? value : void 0;
          targetScope.$watch(min, function(newValue) {
            return element.slider('option', 'min', newValue);
          });
        }
        if (max) {
          getter = $parse(max);
          value = getter();
          opt.max = value && angular.isNumber(value) ? value : void 0;
          targetScope.$watch(max, function(newValue) {
            return element.slider('option', 'max', newValue);
          });
        }
        if (model) {
          getter = $parse(model);
          setter = getter.assign;
          value = getter();
          opt.value = value && angular.isNumber(value) ? value : void 0;
          targetScope.$watch(model, function(value) {
            return element.slider({
              value: value
            });
          });
          opt.slide = function(event, ui) {
            setter(targetScope, ui.value);
            return targetScope.$apply();
          };
        }
        return element.slider(opt);
      }
    };
  }]);

}).call(this);

(function() {
  angular.module('app.directive').directive('waterflowLoading', function() {
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        var callback, slefWindow, windowHeight;
        callback = element.waterflowLoading;
        slefWindow = $(window);
        windowHeight = slefWindow.height();
        slefWindow.on('resize', function() {
          return windowHeight = slefWindow.height();
        });
        return slefWindow.on('scroll', function() {
          var elementHeight, invisibleHeight, ratio, scrollTop;
          elementHeight = element.height();
          invisibleHeight = element.height() - windowHeight;
          ratio = invisibleHeight / elementHeight;
          scrollTop = slefWindow.scrollTop();
          if (scrollTop / elementHeight >= ratio) {
            scope.$emit('scrollInBottom');
            return scope.$broadcast('scrollInBottom');
          }
        });
      }
    };
  });

}).call(this);

(function() {
  angular.module('app.filter').filter('areaTransfer', function() {
    return function(areaNum) {
      var areaName;
      switch (areaNum) {
        case '021001':
          areaName = "浦东新区";
          break;
        case '021002':
          areaName = "黄浦区";
          break;
        case '021003':
          areaName = "虹口区";
          break;
        case '021004':
          areaName = "杨浦区";
          break;
        case '021005':
          areaName = "闸北区";
          break;
        case '021006':
          areaName = "普陀区";
          break;
        case '021007':
          areaName = "长宁区";
          break;
        case '021008':
          areaName = "静安区";
          break;
        case '021009':
          areaName = "徐汇区";
          break;
        case '021010':
          areaName = "闵行区";
          break;
        case '021011':
          areaName = "奉贤区";
          break;
        case '021012':
          areaName = "金山区";
          break;
        case '021013':
          areaName = "松江区";
          break;
        case '021014':
          areaName = "青浦区";
          break;
        case '021015':
          areaName = "嘉定区";
          break;
        case '021016':
          areaName = "宝山区";
      }
      return areaName;
    };
  });

}).call(this);

(function() {
  angular.module('app.filter').filter('classTypeTransfer', function() {
    return function(classType) {
      var classTransfer;
      switch (classType) {
        case "1":
          classTransfer = '钢琴';
          break;
        case "2":
          classTransfer = '声乐';
          break;
        case "3":
          classTransfer = '小提琴';
          break;
        case "4":
          classTransfer = '吉他';
          break;
        case "5":
          classTransfer = '架子鼓';
          break;
        case "6":
          classTransfer = '古筝';
          break;
        default:
          classTransfer = ' ';
      }
      return classTransfer;
    };
  });

}).call(this);

(function() {
  angular.module('app.filter').filter('jobTransfer', function() {
    return function(job) {
      var jobUser;
      jobUser = '';
      switch (job) {
        case 1:
          return jobUser = '在校学生';
        case 2:
          return jobUser = '全职老师';
        case 3:
          return jobUser = '兼职老师';
      }
    };
  });

}).call(this);

(function() {
  angular.module('app.filter').filter('priseTransfer', function() {
    return function(prise) {
      if (prise < 0) {
        return '-';
      }
      return prise;
    };
  });

}).call(this);

(function() {
  angular.module('app.filter').filter('scoreTransfer', function() {
    return function(score) {
      if (score === 5) {
        return 60;
      } else {
        return parseFloat(score) / 5 * 100;
      }
    };
  });

}).call(this);

(function() {
  angular.module('app.filter').filter('teachModelTransfer', function() {
    return function(model) {
      switch (model) {
        case 1:
          return '体验课';
        case 2:
          return '学生上门';
        case 3:
          return '老师上门';
      }
    };
  });

}).call(this);

(function() {
  (function() {
    return angular.module('app.utils').factory('errorMsgUtil', ['errorConstants', function(errorConstants) {
      this.ofCode = function(code) {
        var msg;
        if (code == null) {
          code = 0;
        }
        msg = errorConstants[code];
        if (!msg) {
          msg = '未知错误';
        }
        return "[" + code + "] " + msg;
      };
      return this;
    }]);
  })();

}).call(this);

(function() {
  angular.module('app.controller').controller('createWorkLogController', ['$rootScope', '$scope', '$window', 'homeService', 'modalService', 'notificationService', function($rootScope, $scope, $window, homeService, modalService, notificationService) {
    $scope.date = '';
    $scope.logDetail = '';
    $scope.mood = 0;
    $scope.$on('markdownContent', function(e, result) {
      return $scope.logDetail = result;
    });
    $scope.today = function() {
      return $scope.myDate = new Date();
    };
    $scope.today();
    $scope.maxDate = new Date(2020, 5, 22);
    $scope.myOpened = false;
    $scope.$watch('myDate', function() {
      return console.log($scope.myDate);
    });
    $scope.open = function(event) {
      event.preventDefault();
      event.stopPropagation();
      return $scope.myOpened = true;
    };
    $scope.dateOptions = {
      'year-format': "'yy'",
      'show-weeks': false
    };
    return $scope.addWorkLog = function() {
      return homeService.add($scope.date, $scope.mood, $scope.logDetail).then(function(workLogList) {
        return $scope.workLogList = workLogList;
      }, function(err) {
        return notificationService.error('添加错误', '提示');
      });
    };
  }]);

}).call(this);

(function() {
  angular.module('app.controller').controller('homeController', ['$rootScope', '$scope', '$window', 'homeService', 'modalService', 'notificationService', function($rootScope, $scope, $window, homeService, modalService, notificationService) {
    $scope.name = '';
    $scope.department = '';
    $scope.logDetail = '';
    $scope.mood = 0;
    $scope.oneAtATime = false;
    $scope.getWorkLogList = function() {
      return homeService.list().then(function(workLogList) {
        return $scope.workLogList = workLogList;
      }, function(err) {
        return notificationService.error('刷新错误', '提示');
      });
    };
    $scope.addWorkLog = function() {
      return homeService.add(data).then(function(workLogList) {
        return $scope.workLogList = workLogList;
      }, function(err) {
        return notificationService.error('添加错误', '提示');
      });
    };
    return $scope.getWorkLogList();
  }]);

}).call(this);


/*

notification service 封装了 jquery growl 插件

用法:

[
  'notificationService'

  (notification) ->
     * 右上角弹出默认的提示框，一段时间(3.2s)后消失
    notification.notify 'some message'

     * 右上角弹出默认的提示框，永久显示，要手动关闭
    notification.notify 'some message', true

     * 直接传入 growl 具体配置
    notification.notify
      title: 'You Need To Know!'
      message: 'some message'
      type: 'error'
      size: 'large'
      location: 'bc'
]
 */

(function() {
  (function() {
    return angular.module('app.service').factory('notificationService', function() {
      var LONG_DURATION, wrappeOption;
      LONG_DURATION = 9999 * 9999;
      wrappeOption = function(opt, title, isStatic) {
        var option;
        option = {
          title: '',
          message: ''
        };
        if (typeof opt === 'string') {
          option.title = title;
          option.message = opt;
        } else {
          option = opt;
        }
        if (isStatic) {
          option.duration = LONG_DURATION;
        }
        return option;
      };
      this.notify = function(msg, title, isStatic) {
        if (title == null) {
          title = '提示';
        }
        if (isStatic == null) {
          isStatic = false;
        }
        return $.growl(wrappeOption(msg, title, isStatic));
      };
      this.success = function(msg, title, isStatic) {
        if (title == null) {
          title = '成功';
        }
        if (isStatic == null) {
          isStatic = false;
        }
        return $.growl.notice(wrappeOption(msg, title, isStatic));
      };
      this.error = function(msg, title, isStatic) {
        if (title == null) {
          title = '失败';
        }
        if (isStatic == null) {
          isStatic = false;
        }
        return $.growl.error(wrappeOption(msg, title, isStatic));
      };
      this.warning = function(msg, title, isStatic) {
        if (title == null) {
          title = '警告';
        }
        if (isStatic == null) {
          isStatic = false;
        }
        return $.growl.warning(wrappeOption(msg, title, isStatic));
      };
      return this;
    });
  })();

}).call(this);

(function() {
  angular.module('app.service').factory('templateService', ['$http', '$q', '$log', '$templateCache', function($http, $q, $log, $templateCache) {
    var self;
    self = this;
    this.fetchAll = function() {
      return $q(function(resolve, reject) {
        var url;
        url = angular.element('#angular-templates').attr('href');
        return $http.get(url).success(function(res) {
          return resolve(res);
        }).error(function(res, status) {
          res = {
            code: status
          };
          $log.log('fetch templates failed: ', res.code);
          return reject(res);
        });
      });
    };
    this.cacheAll = function() {
      return $q(function(resolve, reject) {
        return self.fetchAll().then(function(templateData) {
          var templates, templatesLength;
          templates = $(templateData).find('script[type="text/ng-template"]');
          templatesLength = templates.length;
          if (templatesLength === 0) {
            return resolve();
          } else {
            return templates.each(function(index) {
              var content, id;
              id = $(this).attr('id');
              content = $(this).text();
              $templateCache.put(id, content);
              if (index === templatesLength - 1) {
                return resolve();
              }
            });
          }
        }, function(err) {
          return reject(err);
        });
      });
    };
    return this;
  }]);

}).call(this);

(function() {
  angular.module('app.service').factory('homeService', ['$http', '$q', 'env', function($http, $q, env) {
    this.list = function() {
      return $q(function(resolve, reject) {
        return $http.get("").success(function(res) {
          res = {
            data: [
              {
                '销售部': [
                  {
                    'name': 'xiaoliu',
                    'mood': '0',
                    'diary': 'qwerrtyuio'
                  }
                ]
              }, {
                '财务部': [
                  {
                    'name': 'xiaoliu',
                    'mood': '0',
                    'diary': 'qwerrtyuio'
                  }
                ]
              }, {
                '市场部': [
                  {
                    'name': 'xiaoliu',
                    'mood': '0',
                    'diary': 'qwerrtyuio'
                  }
                ]
              }, {
                '存储部': [
                  {
                    'name': 'xiaoliu',
                    'mood': '0',
                    'diary': 'qwerrtyuio'
                  }
                ]
              }, {
                '研发部': [
                  {
                    'name': 'xiaoliu',
                    'mood': '0',
                    'diary': 'qwerrtyuio'
                  }
                ]
              }, {
                '人力资源部': [
                  {
                    'name': 'xiaoliu',
                    'mood': '0',
                    'diary': 'qwerrtyuio'
                  }
                ]
              }, {
                '质量保证部': [
                  {
                    'name': 'xiaoliu',
                    'mood': '0',
                    'diary': 'qwerrtyuio'
                  }
                ]
              }, {
                '运维部': [
                  {
                    'name': 'xiaoliu',
                    'mood': '0',
                    'diary': 'qwerrtyuio'
                  }
                ]
              }
            ]
          };
          resolve(res.data);
          return console.log(res);
        });
      });
    };
    this.add = function(date, mood, log) {
      return $q(function(resolve, reject) {
        return $http.post("" + env.API_URL, {
          date: date,
          mood: mood,
          log: log
        }).success(function(res) {
          return resolve(res);
        });
      });
    };
    return this;
  }]);

}).call(this);

(function() {
  angular.module('app').factory('modalService', ['$rootScope', '$timeout', '$modal', '$q', function($rootScope, $timeout, $modal, $q) {
    this.confirm = function(message) {
      return $q(function(resolve, reject) {
        return bootbox.confirm(message, function(result) {
          if (result) {
            return resolve();
          } else {
            return reject();
          }
        });
      });
    };
    this.alert = function(message) {
      return $q(function(resolve, reject) {
        return bootbox.alert(message, resolve);
      });
    };
    this.customize = function(opt, scope) {
      var modal, windowClass;
      if (scope == null) {
        scope = $rootScope;
      }
      opt.scope = scope;
      opt.scope.$on('$destroy', function() {
        return modal.dismiss();
      });
      windowClass = 'custom-modal-' + Math.floor(Math.random() * 100000);
      opt.windowClass = windowClass;
      modal = $modal.open(opt);
      modal.opened.then(function() {
        return $timeout(function() {
          var inputs;
          inputs = angular.element("." + windowClass + " input");
          inputs.eq(0).trigger('focus');
          return inputs.on('keydown', function(event) {
            var e;
            e = event || $window.event;
            if (e.keyCode === KEY_CODE_ENTER) {
              return scope.$broadcast('enterKeyDown');
            }
          });
        }, 100);
      });
      return modal;
    };
    return this;
  }]);

}).call(this);
