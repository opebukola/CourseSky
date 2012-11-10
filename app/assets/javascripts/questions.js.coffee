jQuery ->
  $('div.content-box:not(:first)').hide();
  $('a.prev-section').hide();
  $('a.next-section').on 'click', (event) ->
    current = $('div.content-box:visible')
    event.preventDefault();
    current.hide();
    next_activity = current.next()
    next_activity.show();
    if next_activity.next().size() is 0 
      $(this).hide()
    $('a.prev-section').show();
  $('#review').modal('toggle');



