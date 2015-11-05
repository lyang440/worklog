angular.module 'app.filter'

.filter 'teachModelTransfer', ->
	return (model) ->
		switch model
			when 1 then return '体验课'
			when 2 then return '学生上门'
			when 3 then return '老师上门'


