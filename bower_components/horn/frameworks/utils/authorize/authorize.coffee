angular.module 'horn.authorize',[]

.factory 'authorizeUtil', ($rootScope, $window) ->
  @do = (redirectUri, gaeaUrl = 'https://account.qiniu.com', op, info) ->
    if !redirectUri then return

    gaeaAuthorizeConfirmUrl = "#{gaeaUrl}/#/authorize/confirm"

    uriEncoded = encodeURIComponent(decodeURIComponent(redirectUri))
    url = "#{gaeaAuthorizeConfirmUrl}?redirect_uri=#{uriEncoded}"

    if op
      opEncoded = encodeURIComponent(decodeURIComponent(op))
      url += "&op=#{opEncoded}"

    if info
      infoEncoded = encodeURIComponent(decodeURIComponent(info))
      url += "&info=#{infoEncoded}"

    $window.location.href = url

  return @
