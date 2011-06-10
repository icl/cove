$(document).ready(function(){
  // jwplayer config for job work page
	jwplayer("jwplayer_container").setup({
		flashplayer: "/jwplayer/player.swf",
		file: coveTag.getFilepath(),
		height: 450,
		width: 640,
		controlbar: "none",
		events: {
			onPause: function (event) {
            /* Enable/Disable tagging buttons when paused */
				coveTag.changeButtonState();

            /* Change the pause button to a play button */
				$("#pausePlay").attr("src", "/images/icons/play.png");
			},
			onPlay: function (event) {
            /* Enable/Disable tagging buttons when paused */
				coveTag.changeButtonState();

            /* Change the play button to a pause button */
				$("#pausePlay").attr("src", "/images/icons/pause.png");
			},
			onTime: function (event) {
            /* Update the current / total time display */
				coveTag.jwTimeHandler(event);

            /* Move the progress indicator along */
				coveTag.moveProgress(event);
			},
     		onReady: function() {
            /* Send the jwplayer reference to the coveTag library */
		 		coveTag.setJwPlayer(jwplayer);

            /* Resize all of the custom controls etc... */
        		coveTag.initPlayerContainer(); 

            /* Disable our buttons by default */
            coveTag.changeButtonState();
	},
		}
	});

   // Change our titles to cool tipTip tool-tips
   $(".buttonTipTip").tipTip({maxWidth: "auto", edgeOffset: 10});

   /* Pause/Play subscriptions */
   amplify.subscribe("pausePlay", function () {
      coveTag.togglePausePlay();
   });

   /* Rewind subscriptions */
   amplify.subscribe("coveSeek", function ( data ) {
      if (data.mode == "rewind") {
            jwplayer().seek(jwplayer().getPosition()-10);
      }

      if (data.mode == "fixed") {
         jwplayer().seek(data.time);
      }
   });

   /* Volume subscriptions */
   amplify.subscribe("volume", function ( data ) {
      if (data.mode == "up") {
            coveTag.handleVolume(5);
      }

      if (data.mode == "down") {
         coveTag.handleVolume(-5);
      }
   });

   /* Call the coveTag click handler function */
   amplify.subscribe( "tagClicked", function ( data ) {
      coveTag.handleTagClick(data.tagValue, data.abandon, data.evtSource);
   });

	// javascript events for job work page, per tag
   $.each(tagSetJSON, function() {
      /* Publish Click Events */
      var tagValue = this.name;

		$('#tagButton_toggle_' + this.name).bind("click", 
         function(e) { 
            amplify.publish( "tagClicked", { tagValue: tagValue, evtSource: e.type} )
          }
      );

		$('#tagButton_hold_' + this.name).bind("mousedown mouseup",
         function(e) { 
            amplify.publish( "tagClicked", { tagValue: tagValue, evtSource: e.type} ) 
         }
      );

      $('#tagButton_hold_' + this.name).mouseout(
         function(e) { 
            amplify.publish( "tagClicked", { tagValue: tagValue, abandon: true, evtSource: e.type} ) 
         }
      );

      /* Create visual feedback */
      /* Bind and Pulse on the toggle button for a tag */
      $('#tagButton_toggle_' + this.name).click(function() {
         if ($(this).val() != "") {
            $(this).val("");
            $(this).css({'opacity': '1', 'background-color': '#dbdbdb'}).stop();
         } else {
            $(this).val("pulsing");
         $(this).pulse({
            opacity: [0.25, 1],
            backgroundColor: ['red', 'yellow', 'green', 'blue'],
         }, 1000, 5, 'linear', function() {
         });
         }
      });
  
      /* Bind and pulse on the hold button for a tag */
      $('#tagButton_hold_' + this.name).mousedown(function() {
         $(this).pulse({
            opacity: [0.25, 1],
            backgroundColor: ['red', 'yellow', 'green', 'blue'],
         }, 1000, 9999, 'linear', function() {
         });
      });

      /* Turn pulsing off when the hold button is released */
      $('#tagButton_hold_' + this.name).mouseup(function() {
         $(this).css({'opacity': '1', 'background-color': '#dbdbdb'}).stop();
      });

      /* Turn pulsing off if the mouse is moved away */
      $('#tagButton_hold_' + this.name).mouseout(function() {
         $(this).css({'opacity': '1', 'background-color': '#dbdbdb'}).stop();
      });
	});
});
