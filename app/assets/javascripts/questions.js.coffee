jQuery ->
	$("#hint").hide();
	$("#show-hint").click (event) ->
		$("#hint").show();
		event.preventDefault();


