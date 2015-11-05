angular.module 'app.filter'

.filter 'priseTransfer', ->
	return (prise) ->
		if prise < 0
			return '-'
		return prise
