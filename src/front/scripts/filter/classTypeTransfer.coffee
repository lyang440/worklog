angular.module 'app.filter'

.filter 'classTypeTransfer',
->
	return (classType) ->
		switch classType
			when "1" then classTransfer = '钢琴'
			when "2" then classTransfer = '声乐'
			when "3" then classTransfer = '小提琴'
			when "4" then classTransfer = '吉他'
			when "5" then classTransfer = '架子鼓'
			when "6" then classTransfer = '古筝'
			else classTransfer = ' '

		return classTransfer
