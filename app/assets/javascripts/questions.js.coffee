jQuery ->
  $('div.quiz-area:not(:first)').hide();
  $('a.finish-quiz').hide();
  $('a.next-question').on 'click', (event) ->
    event.preventDefault();
    current_question = $('div.quiz-area:visible')
    event.preventDefault();
    current_question.hide();
    next_question = current_question.next('div.quiz-area')
    next_question.show();
    if next_question.next('div.quiz-area').size() is 0
      $(this).hide();
      $('a.previous-question').show();
      $('a.finish-quiz').show();


