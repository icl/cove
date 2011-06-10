/*   
	Description: Library to work with JWPlayer and handle interval tagging
*/
function coveTag() {

	/* Private variables */
	var tagArray = new Array();
	var halt = false;
	var curTimeDiv = '';
	var totTimeDiv = '';
	var seekBack = '';
	var filepath = '';
	var videoId = '';
	var postURL = '';
	var jwPlayer = '';
	var jobId = '';
	var progressID = '';
  	var progressBarID = '';
  	var playerFrameDiv = '';

   var tagSetJSON;
   var pausePlayDiv = '';
   var volLevelDiv = '';
   var pausePlayFilePath ='';
   var statusOffset = 0;

	return createApi();

	function createApi() {
		return {

			handleTagClick : handleTagClick,
			jwTimeHandler : jwTimeHandler,
			getFilepath : getFilepath,
        getTagSetJSON : getTagSetJSON,
			moveProgress : moveProgress,
			initPlayerContainer : initPlayerContainer,
			togglePausePlay : togglePausePlay,
   changeButtonState : changeButtonState,
        handleVolume : handleVolume,
        setPausePlayDiv : setPausePlayDiv,
        setVolLevelDiv : setVolLevelDiv,
        setPauseFilePath : setPauseFilePath,
        setPlayFilePath : setPlayFilePath,
        setStatusOffset : setStatusOffset,
			setJobId : setJobId,
			setTagSetJSON : setTagSetJSON,
			setTotTimeDiv : setTotTimeDiv,
			setCurTimeDiv : setCurTimeDiv,
			setSeekBack : setSeekBack,
			setFilepath : setFilepath,
			setVideoId : setVideoId,
			setPostURL : setPostURL,
			setJwPlayer : setJwPlayer,
			setProgressMeterDiv : setProgressMeterDiv,
			setProgressBarDiv : setProgressBarDiv,
			setPlayerFrameDiv : setPlayerFrameDiv
		}
	}

	/* Setter Methods */
	function setTagSetJSON(in_tagSetJSON) { tagSetJSON = in_tagSetJSON; }
	function setTotTimeDiv(in_totTimeDiv) { totTimeDiv = in_totTimeDiv; }
	function setCurTimeDiv(in_curTimeDiv) { curTimeDiv = in_curTimeDiv; }

   function setPausePlayDiv(in_pausePlayDiv) {  pausePlayDiv = in_pausePlayDiv; }
   function setPlayFilePath(in_playFilePath) {  playFilePath = in_playFilePath; }
   function setPauseFilePath(in_pauseFilePath) {  pauseFilePath = in_pauseFilePath; }

   function setVolLevelDiv(in_volLevelDiv) {  volLevelDiv = in_volLevelDiv; }
   function setStatusOffset(in_statusOffset) {  statusOffset = in_statusOffset; }

	function setSeekBack(in_seekBack) { seekBack = in_seekBack; }
	function setFilepath(in_filepath) { filepath = in_filepath; }
	function setVideoId(in_videoId) { videoId = in_videoId; }
	function setPostURL(in_postURL) { postURL = in_postURL; }
	function setJobId(in_jobId) { jobId = in_jobId; }
	function setJwPlayer(in_jwPlayer) { jwPlayer = in_jwPlayer; }
	function setProgressMeterDiv(in_progressID) { progressID = in_progressID; }
   function setProgressBarDiv(in_progressBarID) { progressBarID = in_progressBarID; }
   function setPlayerFrameDiv(in_playerFrameDiv) { playerFrameDiv = in_playerFrameDiv; }

	/* Getter methods */
	function getFilepath() { return filepath; }
   function getTagSetJSON() { return tagSetJSON; }

	function jwTimeHandler(jwTime) {
      /* Convert seconds into minutes and seconds, then update our timers */
		currPosition = jwPlayer().getPosition();
		duration = jwPlayer().getDuration();

      /* Total Duration */
      var totTime = new convertSecToMinSec(duration);
		$('#'+totTimeDiv).text(totTime.minutes + ":" + totTime.seconds);

      /* Elapsed Time */
      var curTime = new convertSecToMinSec(currPosition);
		$('#'+curTimeDiv).text(curTime.minutes + ":" + curTime.seconds);
	}

   function convertSecToMinSec(seconds) {
      this.minutes = Math.floor(seconds/60);
      this.seconds = Math.floor(seconds%60);
   }

   function handleTagClick(tag, haltTagging, evtSource) {
      /* We are starting or ending a tag */
	   if (haltTagging == null && halt == false) {
		   toggleTagActive(tag, evtSource);
	   }

      /* Due to an interrupt event we are going to cancel any active tags */
	   if (haltTagging != null) {
		   destroyPartialTag(tag);
	   }
   }

   function destroyPartialTag(tag) {
	   /* Loop through and destroy any tags without an end time,
	    * set all current active tags to false */
      for (var i=0; i<tagArray.length; i++) {
         if (tagArray[i].isActive == true && tagArray[i].name == tag && tagArray[i].evtSource == "mousedown") {
            tagArray.splice(i,1);
         }
      }
   }

   /* Determine if we are starting or ending a particular tag */
   function toggleTagActive(tag, evtSource) {
      /* The current position will be needed for any work we do */
      var curPosition = jwPlayer().getPosition().toFixed(2);

      /* Assume we are creating a new tag */
      var newTag = true;

      /* Look for any tags that match the given name, and check if they're already active */
      for (var i=0; i<tagArray.length; i++) {
         if (tagArray[i].name == tag && tagArray[i].isActive == true) {
            /* An active tag was found. Don't create a new one. */
            newTag = false;

            /* Make this tag object no longer active */
            tagArray[i].setTagActive(false);

            /* Update the time the tag obj ended at */
            tagArray[i].setEndTime(curPosition);

            /* Send the tag information to the database */
            tagArray[i].postTag();

            /* Update the progress bar to show the tag */
            updateProgressBar(tagArray[i].startTime, tagArray[i].endTime, tagArray[i].name);

            break;
         }
      }

      if (newTag == true) {
               /* Create a new tag */

               /* Subtract any given additional time */
	            var seekPosition = (curPosition - seekBack).toFixed(2);

               /* Create the new tag object */
               var newTagObj = new tagEntries(tag, seekPosition, true, evtSource);

               /* Find the database ID for the tag from the page tag object */
               $.each(tagSetJSON, function() {
                  if (this.name == tag)
                     newTagObj.setTagID(this.id);
               });

               /* Add the new object to our tag object array */
               tagArray[tagArray.length] = newTagObj;
      }
   }

   function togglePausePlay() {
      var state = jwPlayer().getState();

      /* Change the state and switch up the images */
      if (state == "PLAYING") {
         jwPlayer().pause(true);
         $("#" + pausePlayDiv).attr("src", playFilePath);
         changeButtonState();
      } else {
         jwPlayer().play(true);
         $("#" + pausePlayDiv).attr("src", pauseFilePath);
         changeButtonState();
      }
   }

   function changeButtonState() {
      var state = jwPlayer().getState();

      $.each(tagSetJSON, function() {
         if (state == "PLAYING") {
			   $("#tagButton_toggle_" + this.name).attr("disabled", false);
			   $("#tagButton_hold_" + this.name).attr("disabled", false);
		   } else {
			   $("#tagButton_toggle_" + this.name).attr("disabled", true);
			   $("#tagButton_hold_" + this.name).attr("disabled", true);
		   }
      });
   }

   function handleVolume(percent) {

      var newVolume = (jwPlayer().getVolume() + percent);
      
      if (newVolume > 100)
         newVolume = 100;

      if (newVolume < 0)
         newVolume = 0;

      jwPlayer().setVolume(newVolume);
      $("#" + volLevelDiv).text(newVolume + "%");
   }

   function initPlayerContainer(jwEvent) {
      $("#player_wrapper").css('width', (jwPlayer().getWidth()) + "px");
      $("#player_wrapper").css('height', (jwPlayer().getHeight()+50) + "px");
      $("#progress_bar").css('width', (jwPlayer().getWidth()-54) + "px");
      $("#player_progress_bar_interior").css('width', (jwPlayer().getWidth()-54) + "px");
      $("#jwplayer_wrapper").css('width', (jwPlayer().getWidth()) + "px");
      $("#control_wrapper").css('width', (jwPlayer().getWidth()) + "px");
      $("#lower_control_wrapper").css('width', (jwPlayer().getWidth()) + "px");
      $("#volLevel").text(jwPlayer().getVolume() + "%");

      $(".button_container").css('width', (jwPlayer().getWidth()) + "px");
   }

   function updateProgressBar(startTime, endTime, tagName) {
      var width = jwPlayer().getWidth() * 1;
      width = (width-statusOffset);

      var duration = jwPlayer().getDuration() * 1;

      var offset = ((width/duration)*startTime).toFixed(2);
      
      var tagLen = (endTime - startTime);

      var tagWidth = ((width/duration)*tagLen).toFixed(2);

      $("#"+progressBarID).after('<a id="tagHref" class="playerBarTag" style="width: '+tagWidth+'px;  margin-left: '
         +offset+'px;" title="'+ tagName +' From: '+ startTime +' To: '
         +endTime+'" onclick="amplify.publish(\'coveSeek\', { mode: \'fixed\', time: '+startTime+' })">&nbsp;</a>');
   }

   function moveProgress(jwEvent) {
      var width = jwPlayer().getWidth() * 1;
      width = (width-statusOffset);
      var duration = jwPlayer().getDuration() * 1;
      var pos = jwPlayer().getPosition() * 1;

      var offset = (((width/duration)*pos)).toFixed(2);

      $("#"+progressID).css('margin-left', offset + "px");
   }

   /* Tag Entry object constructor */
   function tagEntries(name, startTime, isActive, evtSource) {
      /* Variables */
      this.name = name;
      this.startTime = startTime;
      this.isActive = isActive;
      this.evtSource = evtSource;

      /* Methods */
      this.setEndTime = setEndTime;
      this.postTag = postTag;
      this.setTagID = setTagID;
      this.setTagActive = setTagActive;
   }

   /* Tag entry setter methods */
   function setTagActive(isActive) {
      this.isActive = isActive;
   }

   function setTagID(tagID) {
      this.tagID = tagID;
   }

   function setEndTime(endTime) {
      this.endTime = endTime
   }


   function postTag() {
     // Ryan's code from last quarter
     $.ajax({
       url: postURL,
       type: 'POST',
       dateType: 'JSON',
       data: {job_id: jobId, tag_id: this.tagID, start_time: this.startTime, end_time: this.endTime},
       beforeSend: function(xhr) {
         xhr.setRequestHeader('X-CSRF-Token', $('meta[name=csrf-token]').attr('content'));
       },
       failure:function(){
         alert("failure");
         $("body").append('<div class="flash alert"> Your tag could not be submitted at this time </div>');
       },
       success: function(data, status, xhr){
         // do something
       }
     });
   }
}
