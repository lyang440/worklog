angular.module 'app.filter'

.filter 'jobTransfer', ->
	return (job) ->
		jobUser = ''
		switch job
			when 1 then jobUser = '在校学生'
			when 2 then jobUser = '全职老师'
			when 3 then jobUser = '兼职老师'
