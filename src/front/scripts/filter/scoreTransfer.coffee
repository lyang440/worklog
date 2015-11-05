angular.module 'app.filter'

.filter 'scoreTransfer', ->
	return (score) ->
		if score == 5 then return 60 else return parseFloat(score) / 5 * 100