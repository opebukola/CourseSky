jQuery ->
  $('.hint').hide()
  $('.show-hint').on 'click', (event) ->
  	event.preventDefault();
  	$('.hint').toggle();






