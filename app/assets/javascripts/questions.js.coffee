jQuery ->
	$('.question-box').hide()
	$('#show-question').on 'click', (event) ->
  	$('.question-box').modal('toggle')
  	event.preventDefault()
  $('#hint').hide()
  $('#show-hint').on 'click', (event) ->
  	$('#hint').toggle();
  	event.preventDefault();





