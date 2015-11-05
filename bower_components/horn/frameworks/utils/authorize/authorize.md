# 验证服务 API

提供一套 API，用于内部第三方服务获取/销毁用户的验证状态，实现单点验证.

此 API 受 OAuth 保护，Scope 为 `Internal`（仅供内部服务使用）.


## 第三方服务敏感操作确认流程图

```
                            Kodo                       Account
                             +                            +
                             |                            |
                             |          Redirect          |
                             +---------------------------->
                             |                            |
                             |                            +---------+
                             |                            |         |
                             |                            |         | Verify by password/SMS/TOTP according to user settings
                             |                            |         |
                             |                            <---------+
                             |                            |
                             |                            |  Enter verified state
                             |        Redirect back       |
                             <----------------------------+
                             |                            |
   Before critical operation |                            |
                             |    Check verified state    |
                             +---------------------------->
                             |                            |
                      +------+                            |
Do critical operation |      |                            |
                      +------>                            |
                             |                            |
    After critical operation |                            |
                             |    Consume verified state  |
                             +---------------------------->
                             |                            |
                             |                            |  Enter unverified state
                             |                            |
                             +                            +

```

## 前端使用方法

请引入前端公共库horn中的 **/utils/authorize.coffee** ，然后调用 ``authorizeUtil.do(redirectUri, op, tips)``

* **redirectUri**: 必填，重定向链接（当验证成功后，重定向到传入的参数地址）
* **gaeaUrl**: 必填，account地址
* **op**: 可选，操作名称（鉴权页面会显示：您正在进行的操作 op 需要确认密码，请在下方输入您的登录密码）
* **tips**: 可选，操作提示（鉴权页面会在op下面提示一行灰色小字的tips）

## 后端使用方法

* 为了使filter可以注入，需要在providers.go中引入后端base库的gaea包（**"qbox.us/biz/component/providers/gaea"**）。
* 然后注册两个provider

```
tea.Provide(inject.Object{
    Name:  "GAEAOAuth",
    Value: account.UserOAuth(global.Env.Account.AuthHost),
})

tea.Provide(gaea.Verification(global.Env.Account.AuthHost, "GAEAOAuth"))
```
* 最后一步，在危险操作的route前，加入鉴权操作的filter，需要引入base库的gaea包（**"qbox.us/biz/component/filters/gaea"**），栗子：

```
import(
    "qbox.us/biz/component/filters/gaea"
)

...

Router("/bucket/drop",
    Filter(gaea.VerificationCheck),
    Filter(gaea.VerificationConsumeIfOK),
    Post(&bucket.Bucket{}).Action("Drop")),
```

## 获取验证状态

当且仅当验证状态为通过时，第三方服务才可允许用户调用敏感接口.

```
GET /api/oauth/verification/check
```

验证通过返回值:

```
{
    "code": 200
}
```

未验证通过或 OAuth 已过期返回值:

```
{
    "code": 401,
    "message": "unauthorized"
}
```

未找到用户信息或 Session 已过期:

```
{
    "code": 404,
    "message": "not found"
}
```


## 销毁验证状态

当第三方服务调用敏感接口结束后，调用此接口，销毁验证状态.

此接口会同时销毁密码、短信、TOTP 三种验证状态.

```
POST /api/oauth/verification/consume
```

正常返回值:

```
{
    "code": 200
}
```

OAuth 已过期返回值:

```
{
    "code": 401,
    "message": "unauthorized"
}
```

Session 已过期:

```
{
    "code": 404,
    "message": "not found"
}
```


## 参考链接

[七牛产品的危险操作确认流程](https://pm.qbox.me/issues/19975)
