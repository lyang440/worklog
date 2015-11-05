angular.module "horn.menu",["ui.bootstrap","ui.router"]

.factory "menuService", ($q,$http)->

  @getUnreadMessageNum = (gaeaHost)->
    $q (resove ,reject)->
      $http.jsonp "#{gaeaHost}/api/internal_message/unread_number?callback=JSON_CALLBACK"
      .then (data)->
        resove data.data
      , (data)->
        reject data.data

  @getEmailHash = (gaeaHost)->

    $q (resove ,reject)->
      $http.jsonp "#{gaeaHost}/api/user/emailhash?callback=JSON_CALLBACK"
      .then (data)->
        resove data.data
      , (data)->
        reject data.data

  return @

.directive "qiniuMenu", ($state, $rootScope, $sce, $timeout, $window, menuService) ->
  restrict: "E"
  scope:
    "gaeaHost": "=gaea"
    "areaInfo": "=areaInfo"
    "toggleBtn": "&showToggleBtn"
  template: '
  <div id="main-navbar" class="navbar navbar-inverse " role="navigation">
    <!-- Main menu toggle -->
    <button type="button" id="main-menu-toggle" ng-show="isShowToggleBtn" ng-click="toggleBtn()">
      <i class="navbar-icon fa fa-bars icon"></i><span class="hide-menu-text">隐藏菜单</span>
    </button>

    <div class="navbar-inner">
        <!-- Main navbar header -->
        <div class="navbar-header">
          <a class="navbar-brand logo-fixed" ng-if="!isShowProductDropdown || !hasLoadedProductIframe" href="/#/">
            <div class="logo-area">
              <img ng-title="{{title}}" class="logo" ng-alt="{{title}}" ng-src="{{logoUrl}}">
            </div>
          </a>
          <!-- Logo -->
          <ul class="nav pull-left">
            <li dropdown id="product-dropdown" class="dropdown un-visible" ng-show="isShowProductDropdown">
              <a class="navbar-brand dropdown-toggle user-menu" dropdown-toggle>
                <div class="logo-area">
                  <img ng-title="{{title}}" class="logo" ng-alt="{{title}}" ng-src="{{logoUrl}}">
                  <i class="nav-icon fa  fa-caret-up"></i>
                  <i class="nav-icon fa  fa-caret-down"></i>
                </div>
              </a>
              <div class="dropdown-menu">
                <iframe class="product" ng-show="loadProductIframe" ng-src="{{productUrl}}" frameborder="0" id="product-iframe">
                </iframe>
              </div>
            </li>
          </ul>

          <!-- Main navbar toggle -->

          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar-collapse" ng-show="isShowProductDropdown">
            <i class="navbar-icon fa fa-bars"></i>
          </button>

        </div> <!-- / .navbar-header -->

        <div id="main-navbar-collapse" class="collapse navbar-collapse main-navbar-collapse">
          <div>
            <div class="right clearfix">
              <ul class="nav navbar-nav pull-right right-navbar-nav">
                <li dropdown class="nav-icon-btn dropdown  un-visible"  ng-show="isShowProductDropdown">
                  <a class="user-menu" dropdown-toggle>
                    <span class="label" ng-if="unreadNumber">
                      {{unreadNumber}}
                    </span>
                    <i class="nav-icon fa fa-bell"></i>
                  </a>
                  <div class="dropdown-menu message-box no-padding" special-dropdown>
                    <iframe ng-src="{{messageUrl}}" ng-show="loadUserIframe" frameborder="0" id="message-iframe">
                    </iframe>
                  </div>
                </li>

                <li dropdown class="dropdown area" ng-if="isShowAreaDropdown">
                  <a class="user-menu" dropdown-toggle>
                    <i class="fa fa-map-marker">
                      <span ng-bind="currentZone.text"></span>
                    </i>
                  </a>
                  <div class="dropdown-menu no-padding">
                    <ul ng-class="{ active: currentIndex === $index }" ng-if="areaInfo.type == 1">
                      <li ng-click="goLink(item.link, $index)" ng-repeat="item in areaInfo.items">
                        <a>
                          <span class="fa fa-map-marker"></span>
                          <span ng-bind="item.text"></span>
                          <span class="fa fa-check" ng-show="currentIndex === $index"></span>
                        </a>
                      </li>
                    </ul>
                    <ul ng-if="areaInfo.type == 2">
                      <li ng-click="jump(item.state,item.params,$index)" ng-class="{ active: currentIndex === $index }" ng-repeat="item in areaInfo.items">
                        <a>
                          <span class="fa fa-map-marker"></span>
                          <span ng-bind="item.text"></span>
                          <span class="fa fa-check" ng-show="currentIndex === $index"></span>
                        </a>
                      </li>
                    </ul>
                    <ul ng-if="areaInfo.type == 3">
                      <li ng-click="trigger(item.event,item.param,$index)" ng-class="{ active: currentIndex === $index }" ng-repeat="item in areaInfo.items">
                        <a>
                          <span class="fa fa-map-marker"></span>
                          <span ng-bind="item.text"></span>
                          <span class="fa fa-check" ng-show="currentIndex === $index"></span>
                        </a>
                      </li>
                    </ul>
                  </div>
                </li>
                <li  ng-show="isShowProductDropdown">
                  <a href="{{gaeaHost}}/#/user/key">
                    <i class="fa fa-key"></i>
                    <span class="small-screen-text">密钥管理</span>
                  </a>
                </li>
                <li  ng-show="isShowUserDropdown">
                  <a target="_blank" href="http://support.qiniu.com/hc/">
                    <i class="fa fa-headphones"></i>
                    <span class="small-screen-text">工单列表</span>
                  </a>
                </li>
                <li dropdown id="user-dropdown" class="dropdown un-visible"  ng-show="isShowUserDropdown">
                  <a class="dropdown-toggle user-menu"  dropdown-toggle>
                    <img class="nav-avatar" ng-src="{{avatarUrl}}">
                  </a>
                  <div class="dropdown-menu">
                    <iframe ng-src="{{userCardUrl}}" ng-show="loadUserIframe" frameborder="0" id="user-card-iframe">
                    </iframe>
                  </div>
                </li>
              </ul> <!-- / .navbar-nav -->
            </div> <!-- / .right -->
          </div>
        </div> <!-- / #main-navbar-collapse -->
    </div> <!-- / .navbar-inner -->
  </div>'
  link: (scope, element, attrs) ->
    avatarHost = "https://dn-qiniu-avatar.qbox.me/avatar/"

    scope.stateName = $state.current.name

    scope.isShowToggleBtn =  attrs.showToggleBtn != undefined

    scope.logoUrl = attrs.logoUrl
    scope.title = attrs.title
    scope.hasLoadedProductIframe = false
    angular.element document.querySelector('#main-navbar')
      .addClass attrs.menuTheme 

    if scope.areaInfo
      scope.currentIndex = scope.areaInfo.current
      scope.currentZone = scope.areaInfo.items[scope.currentIndex]

      currentZoneChange = (current) ->
        scope.currentZone = scope.areaInfo.items[current]
        scope.currentIndex = current

      scope.$watch 'areaInfo', (newValue, oldValue) ->
        if oldValue.current != newValue.current
          if scope.areaInfo.type == 3
            item = scope.areaInfo.items[newValue.current]
            scope.trigger item.event, item.param, newValue.current
      , true 

      scope.trigger = (event_name, event_param, current) ->
        $rootScope.$broadcast event_name,event_param
        currentZoneChange current
        return

      scope.goLink = (link, current) ->
        currentZoneChange current
        window.location.href = link
        return

      scope.jump = (state_name, state_params, current) ->
        $state.go state_name,state_params
        currentZoneChange current
        return

    isFirefox = ()->
      return navigator.userAgent.indexOf("Firefox") isnt -1

    isIE = ()->
      return navigator.userAgent.indexOf('MSIE') isnt -1 || navigator.appVersion.indexOf('Trident/') > 0

    scope.$on "$stateChangeSuccess",(event, toState, toParams, fromState, fromParams)->
      scope.stateName = toState.name

    $rootScope.$on "reload_user_iframe" ,()->
      time =  new Date().getTime()
      scope.userCardUrl = $sce.trustAsResourceUrl scope.gaeaHost + "/?#{time}#/user-card"

    $rootScope.$on "reload_product_iframe" ,()->
      time =  new Date().getTime()
      scope.productUrl = $sce.trustAsResourceUrl scope.gaeaHost + "/?#{time}#/product"

    $rootScope.$on "reload_message_iframe" ,()->
      getUnreadMessageNum()
      time =  new Date().getTime()
      scope.messageUrl = $sce.trustAsResourceUrl scope.gaeaHost + "/?#{time}#/user-message"

    # ifrmae 加载完成才显示 顶栏，避免点击 dropdown 后显示 loading 状态
    element.find("iframe").bind "load",()->
      angular.element(this).parent().parent().removeClass("un-visible")
      if angular.element(this).attr("id") is "product-iframe"
        scope.hasLoadedProductIframe = true

      # 在 ifrmae 加载完成后，根据 iframe 内容动态调整 dropdown 和 iframe 的宽高
      # 依赖 https://github.com/davidjbradshaw/iframe-resizer
      iFrameResize
        sizeHeight : true
        sizeWidth : true
        maxHeight : 500
        resizedCallback : (obj)->
          parentEle = obj.iframe.parentElement
          borderWidth =  parentEle.style.borderWidth || window.getComputedStyle(parentEle,null).getPropertyValue("border-width")
          borderWidth =  parseInt borderWidth, 10
          height =  Number(obj.height) + (borderWidth * 2)
          width =  Number(obj.width) + (borderWidth * 2)
          parentEle.style.height = height  + 'px'
          parentEle.style.width = width  + 'px'
      , this

    getUnreadMessageNum = ()->
      menuService.getUnreadMessageNum(scope.gaeaHost).then (data)->
        scope.unreadNumber =  data || undefined
      , (data)->
        scope.unreadNumber =  undefined

    isInAllowOrigin = (origin)->
      if  !origin then return false
      allowOrigin = ["qiniu.com","qiniu.io","localhost","127.0.0.1"] #TODO 做成配置
      for allow in allowOrigin
        if origin.indexOf allow  != -1
          return true
      return false

    # 获取来自子 iframe 的 message ，减少未读消息数
    window.addEventListener "message",(event)->
      if isInAllowOrigin(event.origin) then getUnreadMessageNum()


    notShowProductDropdownState = [
      "layout.signin"
      "layout.oauthSignin"

      "layout.signup"
      "layout.signup.register"
      "layout.signup.activateEmail"
      "layout.user.confirmEmailSuccess"
      "layout.user.securityEmailSuccess"
      "layout.signup.confirmEmailFailed"
      "layout.signup.bindMobile"
      "layout.signup.profile"

      "layout.resetPwd"
      "layout.forgetPwd"
    ]

    notShowUserDropdownState = [
      "layout.signin"
      "layout.oauthSignin"

      "layout.signup"
      "layout.signup.register"
      "layout.user.confirmEmailSuccess"
      "layout.signup.confirmEmailFailed"

      "layout.resetPwd"
      "layout.forgetPwd"
    ]

    hasInitLoadUserIframe =  false
    hasInitLoadProductIframe =  false

    scope.$watchGroup ["gaeaHost","stateName","areaInfo"], ()->

      gaeaHost = scope.gaeaHost

      scope.isShowProductDropdown = notShowProductDropdownState.indexOf(scope.stateName) is -1
      scope.isShowUserDropdown =  notShowUserDropdownState.indexOf(scope.stateName) is -1

      scope.loadProductIframe =  scope.isShowProductDropdown && gaeaHost
      scope.loadUserIframe =  scope.isShowUserDropdown && gaeaHost

      scope.isShowAreaDropdown =  scope.isShowProductDropdown && scope.areaInfo

      time =  new Date().getTime()
      if scope.loadUserIframe && !hasInitLoadUserIframe
        hasInitLoadUserIframe = true
        if isFirefox() || isIE()
          # Firefox/IE 不加载url格式如 http://gaea.staging.io/#/product 的iframe
          # 但可以加载 http://gaea.staging.io/?random_str#/product
          # http://stackoverflow.com/questions/21893361/force-iframe-to-reload-document-when-only-src-hash-changes

          scope.userCardUrl = $sce.trustAsResourceUrl gaeaHost + "/?#{time}#/user-card"
          scope.messageUrl = $sce.trustAsResourceUrl gaeaHost + "/?#{time}#/user-message"
        else
          scope.userCardUrl = $sce.trustAsResourceUrl gaeaHost + "/#/user-card"
          scope.messageUrl = $sce.trustAsResourceUrl gaeaHost + "/#/user-message"

        menuService.getEmailHash(gaeaHost).then (data)->
          scope.avatarUrl  =   avatarHost+ data
        , (data)->
          # default avatarUrl
          scope.avatarUrl =  avatarHost

      if scope.loadProductIframe && !hasInitLoadProductIframe
        hasInitLoadProductIframe = true
        if isFirefox() || isIE()
          scope.productUrl = $sce.trustAsResourceUrl gaeaHost + "/?#{time}#/product"
        else
          scope.productUrl = $sce.trustAsResourceUrl gaeaHost + "/#/product"

        getUnreadMessageNum()

.directive "specialDropdown", ()->
  link : (scope, element, attrs)->
    element.on "click", (e)->
      e.stopPropagation()

    element.find("iframe").on "mousewheel DOMMouseScroll", (ev)->
      ev.stopPropagation()
      ev.preventDefault()
