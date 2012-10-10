jQuery ->
  $('a.question-pjax').pjax('[question-pjax-container]');
  hint_request_count = 0;
  hint1 = $('.prompt').data('hint1')
  hint2 = $('.prompt').data('hint2')
  $('#show-hint').on 'click', (event) ->
  	hint_request_count++
  	if hint_request_count is 1
      $('.prompt').append hint1
      console.log(hint_request_count)
    else if hint_request_count is 2
    	console.log(hint_request_count)
    	$('.prompt').append hint2
    else if hint_request_count is 3
    	$.ajax
    		url:'questions/<%=@question.id%>/reveal'
    		type: 'post'




