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
	$('#tagButton').bind("mousedown mouseup", function() { handleTagClick('Riffing') });
	$('#tagButton').mouseout(function() { handleTagClick('Riffing', true )});
	$('#tagButton_2').click(function() { handleTagClick('Riffing') });
});