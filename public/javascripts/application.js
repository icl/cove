$(document).ready(function(){
  // jwplayer config for job work page
	jwplayer("jwplayer_container").setup({
		flashplayer: "/jwplayer/player.swf",
		file: coveTag.getFilepath(),
		height: 450,
		width: 800,
		controlbar: "none",
		events: {
			onPlay: function (event) {
				coveTag.setTotTime(jwplayer().getDuration());
            $("#pausePlay").attr("src", "/images/icons/pause.png");
			},
			onTime: function (event) {
				coveTag.jwTimeHandler(event);
            coveTag.moveProgress(event);
			},
			onComplete: function () { document.getElementById("progbar").innerHTML = "[COMPLETE]"; },
         onReady: function() { 	coveTag.setJwPlayer(jwplayer);
                                 coveTag.initPlayerContainer(); }
		}
	});


   $(".buttonTipTip").tipTip({maxWidth: "auto", edgeOffset: 10});

	// javascript events for job work page
	for (i=0; i<activeTag.length; i++) {
		var tagValue = activeTag[i][0];


		$('#tagButton_hold_' + tagValue).bind("mousedown mouseup", { vars: tagValue }, function() { coveTag.handleTagClick(tagValue) });
      $('#tagButton_hold_' + tagValue).mousedown(function() {
         $(this).pulse({
            opacity: [0.25, 1],
            backgroundColor: ['red', 'yellow', 'green', 'blue'],
         }, 1000, 9999, 'linear', function() {
            //woot
         });
      });
      $('#tagButton_hold_' + tagValue).mouseout(function() {
         $(this).css({'opacity': '1', 'background-color': '#dbdbdb'}).stop();
      });
      $('#tagButton_hold_' + tagValue).mouseup(function() {
         $(this).css({'opacity': '1', 'background-color': '#dbdbdb'}).stop();
      });
		$('#tagButton_hold_' + tagValue).mouseout(function() { coveTag.handleTagClick(tagValue, true) });

		$('#tagButton_toggle_' + tagValue).click( { vars: tagValue}, function() { coveTag.handleTagClick(tagValue) });

      $('#tagButton_toggle_' + tagValue).click(function() {
         if ($(this).val() != "") {
            $(this).val("");
            $(this).css({'opacity': '1', 'background-color': '#dbdbdb'}).stop();
         } else {
            $(this).val("pulsing");
         $(this).pulse({
            opacity: [0.25, 1],
            backgroundColor: ['red', 'yellow', 'green', 'blue'],
         }, 1000, 5, 'linear', function() {
            //woot
         });
         }
      });
  

	}
});
