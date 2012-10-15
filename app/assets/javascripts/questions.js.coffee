jQuery ->
	$('.question-box').hide()
	$('#show-question').on 'click', (event) ->
  	$('.question-box, .prompt').toggle();
  	event.preventDefault()




