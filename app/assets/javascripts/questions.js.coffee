jQuery ->
  $('a.question-pjax').pjax('[question-pjax-container]');
  hint = $('.prompt').data('hint')
  $('#show-hint').on 'click', (event) ->
  	$('.prompt').append hint




