jQuery ->
  $('#lessons-list').sortable(
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  );

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.answer').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(".answer-list").append($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  
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

  $('a.prev-section').on 'click', (event) ->
    current = $('div.content-box:visible')
    event.preventDefault();
    current.hide();
    previous_activity = current.prev()
    previous_activity.show();
    if previous_activity.prev().size() is 0
      $(this).hide()
    $('a.next-section').show();










  

