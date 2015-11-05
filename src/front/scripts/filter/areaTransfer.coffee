angular.module 'app.filter'

.filter 'areaTransfer',
->
    return (areaNum) ->
        switch areaNum
            when '021001' then areaName = "浦东新区"
            when '021002' then areaName = "黄浦区"
            when '021003' then areaName = "虹口区"
            when '021004' then areaName = "杨浦区"
            when '021005' then areaName = "闸北区"
            when '021006' then areaName = "普陀区"
            when '021007' then areaName = "长宁区"
            when '021008' then areaName = "静安区"
            when '021009' then areaName = "徐汇区"
            when '021010' then areaName = "闵行区"
            when '021011' then areaName = "奉贤区"
            when '021012' then areaName = "金山区"
            when '021013' then areaName = "松江区"
            when '021014' then areaName = "青浦区"
            when '021015' then areaName = "嘉定区"
            when '021016' then areaName = "宝山区"

        return areaName