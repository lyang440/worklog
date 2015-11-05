angular.module 'app.directive'

.directive 'markDown', ($filter) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    previewContent = ''

    element.markdown(
      iconlibrary: 'fa'
      onBlur: (e) ->
        previewContent = e.getContent()
        scope.$emit 'markdownContent', previewContent
    )



