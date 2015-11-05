# 外部依赖：

+ ui-bootstrap ( dropdown )
+ iframe-resizer

# 使用方法：

## 1、安装依赖

1.1 bower.json 中引入

+ horn
+ ui-bootstrap (dropdown)
+ iframe-resizer : "~3.4.0"

```
    "dependencies": {
      "iframe-resizer": "~3.4.0",
      "horn": "git@github.com:qbox/horn.git",
      "angular-bootstrap": "~0.13.4"
    }
```

1.2 bower install

1.3 外部依赖引入

```
<script src="your_path/ui-bootstrap-tpls-version.js"></script>
<script src="your_path/iframeResizer.min.js"></script>
```

1.4 请在相应的 app.js、app.css 的构建配置中加入以下类似代码：

js

```

    src : [
        ……
        "bower_components/horn/frameworks/qiniu-menu/qiniu-menu.coffee"
        ……
    ]

```

css

```

    src : [
        ……
        "bower_components/horn/frameworks/qiniu-menu/qiniu-menu.less"
        ……
    ]

```

or sass


```

    src : [
        ……
        "bower_components/horn/frameworks/qiniu-menu/qiniu-menu.sass"
        ……
    ]

```


## 2、使用


在相应的 html 代码中插入以下代码：

```
   <qiniu-menu data-show-toggle-btn="menuToggle()" date-title="七牛开发者平台" data-gaea="gaea_host" logo-url="/image/logo.png" menu-theme="none" area-info="area-info">

```

#### 2.1 参数含义：

必须赋值的参数：

+ `data-gaea` : 必选，gaea 的 url ，建议在配置文件添加相应字段，前端通过 ajax 获取
+ `logo-url` :  必选，logo 的链接，可以相对路径也可以绝对路径


可选参数：

+ `data-show-toggle-btn`:   可选，一个控制侧边栏显示的函数，如 menuToggle() ，类似实现:

controller

```
  $rootScope.isMenuCollapse =  localStorageService.get('menu.collapse') || false
  $rootScope.menuToggle = ->
    $rootScope.isMenuCollapse = !$rootScope.isMenuCollapse
    localStorageService.add('menu.collapse', $rootScope.isMenuCollapse)
```

view

```
<body class="theme-white" ng-class="{'mmc': isMenuCollapse}">

```

+ `menu-theme` : 可选，给当前 menu 添加一个类名，以便进行样式覆盖或自定义
+ `data-title`  :  可选，logo 的 title、alt 文字
+ `area-info` :可选， 选择区域的链接及文字或交互行为的信息渲染,其格式如下：
+ (`current`代表当前空间在items里的序号)

**** area-info 类型1 文字+链接 ****


```
{
    "type": 1,
    "current": 0 //items的索引
    "items": [
        {
            "text": "华东一区",
            "link": "http://xxx.com"
        },{
            "text": "华北一区",
            "link": "http://xxx.com"
        },……
    ]
}
```

**** area-info 类型2 文字+路由 ****

```
{
    "type": 2,
    "current": 0 //items的索引
    "items": [
        {
            "text": "华东一区",
            "state": "state_name",
            "params": {
                "key_a": "val_a",
                ……
            }
        },  {
            "text": "华北一区",
            "state": "state_name",
            "params": {
                "key_a": "val_a",
                ……
            }
        },……
    ]
}
```

**** area-info 类型3 文字+事件 ****

```
{
    "type": 3,
    "current": 0 //items的索引
    "items": [
        {
            "text": "华东一区",
            "event": "event_name",
            "param": "paramA"
        },  {
            "text": "华北一区",
            "event": "event_name",
            "param": ["paramA","paramB"]
        },……
    ]
}
```

### 2.2插件注册的事件

插件在 $rootScope 注册了 3个事件回调 ， `reload_message_iframe`、`reload_product_iframe`、`reload_user_iframe`

作用如下：

+ `reload_message_iframe` : 重新加载 message iframe ，并重新获取未读消息数，适用于有消息更新时使用
+ `reload_product_iframe` : 重新加载 产品 dropdown iframe，适用于开通了fusion 、 evm 时使用
+ `reload_user_iframe` : 重新加载 user dropdown iframe，适用于 用户身份认证状态有变化时使用

使用时，只需要在 $rootScope $broadcast 对应事件即可
