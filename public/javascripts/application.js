$(document).ready(function(){
  // jwplayer config for job work page
	jwplayer("jwplayer_container").setup({
		flashplayer: "/jwplayer/player.swf",
		file: filepath,
		height: 270,
		width: 480,
		controlbar: "none",
		events: {
			onTime: function (event) {
				jwTimeHandler(event);
			},
			onComplete: function () { document.getElementById("progbar").innerHTML = "[COMPLETE]"; }
		}
	});
	
	// javascript events for job work page
	for (i=0; i<activeTag.length; i++) {
		var tagValue = activeTag[i][0];

		$('#tagButton_hold_' + tagValue).bind("mousedown mouseup", { vars: tagValue }, function() { handleTagClick(tagValue) });
		$('#tagButton_hold_' + tagValue).mouseout(function() { destroyPartialTags() });
		$('#tagButton_toggle_' + tagValue).click( { vars: tagValue}, function() { handleTagClick(tagValue) });
	}
});
