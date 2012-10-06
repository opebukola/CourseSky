jQuery ->
  $('a.qustion-pjax').pjax('[question-pjax-container]');
  hint_request_count = 0;
  hint1 = $('.prompt').data('hint1')
  hint2 = $('.prompt').data('hint2')
  $('#show-hint').on 'click', (event) ->
  	hint_request_count++
  	if hint_request_count = 1
      $('.prompt').append hint1
    else $('.prompt').append hint2 if hint_request_count = 2





