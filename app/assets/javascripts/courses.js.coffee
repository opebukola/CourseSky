jQuery ->
	$('#course-sections a').on 'click', (event) ->
		event.preventDefault();
		$(this).tab('show');



