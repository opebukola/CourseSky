jQuery ->
  $('div.quiz-question:not(:first)').hide();
  $('a.prev-question').hide();
  $('a.finish-quiz').hide();
  $('a.next-question').on 'click', (event) ->
    current_question = $('div.quiz-question:visible')
    event.preventDefault();
    current_question.hide();
    next_question = current_question.next('div.quiz-question')
    next_question.show();
    if next_question.next('div.quiz-question').size() is 0
      $(this).hide();
      $('a.previous-question').show();
      $('a.finish-quiz').show();


