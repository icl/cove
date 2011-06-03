$(document).ready(function(){
  // Javascript to handle autosubmitting the form when things change
  $('#filter_form select').bind("change", function(){
    console.log($(this).attr("value"));
    $('#filter_form').submit();
  });
  //This javascript will handle ajax updating of the filtered search results
  $('#filter_form').bind("ajax:success", function(event, response, status) {  
    $('#result_container').html(response);
  });

  $('#filter_form').bind("ajax:failure", function(event, response, status) {  
    $('#result_container').html("An Error Occured");
  });
  
  // jwplayer config for job work page
	jwplayer("jwplayer_container").setup({
		flashplayer: "/jwplayer/player.swf",
		file: coveTag.getFilepath(),
		height: 270,
		width: 480,
		controlbar: "none",
		events: {
			onPlay: function (event) {
				coveTag.setTotTime(jwplayer().getDuration());
			},
			onTime: function (event) {
				coveTag.jwTimeHandler(event);
			},
			onComplete: function () { document.getElementById("progbar").innerHTML = "[COMPLETE]"; }
		}
	});

	// set the jwplayer reference in our coveTag object
	coveTag.setJwPlayer(jwplayer);

	// javascript events for job work page
	for (i=0; i<activeTag.length; i++) {
		var tagValue = activeTag[i][0];

		$('#tagButton_hold_' + tagValue).bind("mousedown mouseup", { vars: tagValue }, function() { coveTag.handleTagClick(tagValue) });
		$('#tagButton_hold_' + tagValue).mouseout(function() { coveTag.handleTagClick(tagValue, true) });
		$('#tagButton_toggle_' + tagValue).click( { vars: tagValue}, function() { coveTag.handleTagClick(tagValue) });
	}


});
