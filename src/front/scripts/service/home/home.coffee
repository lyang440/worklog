angular.module 'app.service'

.factory 'homeService',
($http, $q, env) ->
  @list = ->
    $q (resolve, reject) ->
      $http.get ""
      .success (res) ->
        res = {
          data:[{
            'depar_name': '销售部'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '财务部'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '市场部'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '存储部'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '研发部'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '人力资源部'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'depar_name': '财务部'
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '质量保证部'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '运维部'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          }]
        }

        resolve res.data
      # .error (res) ->
      #   reject res

  @listByDate = (date) ->
    $q (resolve, reject) ->
      $http.get "",
        params:
          date: date
      .success (res) ->
        res = {
          data:[{
            'depar_name': '销售部'
            'topic': 'qwerrtyyuuuiu'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '财务部'
            'topic': 'qwerrtyyuuuiu'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '市场部'
            'topic': 'qwerrtyyuuuiu'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '存储部'
            'topic': 'qwerrtyyuuuiu'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '研发部'
            'topic': 'qwerrtyyuuuiu'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '人力资源部'
            'topic': 'qwerrtyyuuuiu'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            },{
              'depar_name': '财务部'
              'topic': 'qwerrtyyuuuiu'
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '质量保证部'
            'topic': 'qwerrtyyuuuiu'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          },{
            'depar_name': '运维部'
            'topic': 'qwerrtyyuuuiu'
            'members': [{
              'name':'xiaoliu'
              'mood':'0'
              'diary':'qwerrtyuio'
            }]
          }]
        }

        resolve res.data
      # .error (res) ->
      #   reject res

  @add = (date, mood, log) ->
    $q (resolve, reject) ->
      $http.post "#{env.API_URL}",
        date: date
        mood: mood
        log: log
      .success (res) ->
        resolve res
      # .error (res) ->
      #   reject res

  return @
