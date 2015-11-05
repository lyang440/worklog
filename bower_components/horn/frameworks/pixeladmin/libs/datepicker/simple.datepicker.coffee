'use strict'

###*
 # @ngdoc directive
 # @name app.directive:simple-datepicker
 # @description
 # # Depends:
 # #   DatePicker 1.0.0
 # #   http://foxrunsoftware.github.com/DatePicker/
 # #
 # # simple-datepicker
 # #   <div simple-datepicker range="range" label-fomart="'yyyy-MM-dd'" visible="true" submit="submit"></div>
 # #   range: [Date1, Date2]
 # #   label-fomart: 'yyyy年MM月dd日', 'yyyy-MM-dd'... Default 'yyyy-MM-dd'
 # #   submit: function(range)
###
angular.module('ngSimpleDatepicker', []).directive 'simpleDatepicker', [

  '$filter'
  ($filter) ->

    dateFormat = (date)->
      $filter('date')(date, "yyyy-MM-dd")

    restrict: 'EA'

    template: """
      <div class="simple-datepicker-range">
        <div class="btn btn-outline date-range-label" ng-click="toggle()" ng-class="{active: visible}">
          <span>{{ range[0] | date: labelFomart }} - {{ range[1] | date: labelFomart }}</span>
          <span class="caret"></span>
        </div>

        <div class="datepicker-calendar-menu" ng-show="visible">
          <div class="datepicker-calendar">
            <div class="datepicker-head">
              <span>时间范围:</span>
              <input type="text" class="date-input" placeholder="开始时间" data-ng-model="startDate">
              <span class="date-separator">至</span>
              <input type="text" class="date-input" placeholder="结束时间" data-ng-model="endDate">
              <button class="date-apply-button btn btn-sm btn-default" ng-click="setDate()">应用</button>
            </div>
          </div>
        </div>
      </div>
    """

    replace: true

    scope:
      range: '='
      submit: '='
      visible: '='
      labelFomart: '='

    link: (scope, element, attrs) ->
      scope.startDate = dateFormat(scope.range[0] || new Date())
      scope.endDate   = dateFormat(scope.range[1] || new Date())

      scope.labelFomart = scope.labelFomart || 'yyyy-MM-dd'

      $calendar = $(element).find('.datepicker-calendar')

      DatePicker = $calendar.DatePicker
        inline: true
        date: scope.range
        calendars: 3
        mode: 'range'

        locale:
          daysMin: ["日", "一", "二", "三", "四", "五", "六"]
          months: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
          monthsShort: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]

        onChange: (dates, el) ->
          scope.startDate = dateFormat(dates[0])
          scope.endDate   = dateFormat(dates[1])
          scope.$apply()

        onRenderCell: (el, date) ->
          result = {}
          result.disabled = true if date > new Date()
          result


      $(document).on 'click', ->
        scope.visible = false
        scope.$apply()


      $(element).click (event) ->
        event.stopPropagation()


      scope.$watch 'range', (newRange, oldRange) ->
        scope.startDate = dateFormat(newRange[0])
        scope.endDate = dateFormat(newRange[1])
        range = [scope.startDate, scope.endDate]
        $calendar.DatePickerSetDate(range, false)


      scope.$watch 'startDate', (newDate, oldDate) ->
        range = [dateFormat(scope.startDate), dateFormat(scope.endDate)]
        $calendar.DatePickerSetDate(range, false)


      scope.$watch 'endDate', (newDate, oldDate) ->
        range = [dateFormat(scope.startDate), dateFormat(scope.endDate)]
        $calendar.DatePickerSetDate(range, false)


      scope.toggle = ->
        scope.visible = !scope.visible


      scope.setDate = ->
        scope.range = [scope.startDate, scope.endDate]
        scope.visible = false
        scope.submit(scope.range) if scope.submit

]
