describe("coveTagTest", function() {
    beforeEach(function() {
   coveTagObj = new coveTag();
	/* Create some DIVs so we can test JS interaction */
	$('#player_wrapper').remove();
	$('body').append('<div id="player_wrapper"></div>');

	$('#jwplayer_wrapper').remove();
	$('body').append('<div id="jwplayer_wrapper"></div>');

	$('#jwplayer_container').remove();
	$('body').append('<div id="jwplayer_container"></div>');

	$('#control_wrapper').remove();
	$('body').append('<div id="control_wrapper"></div>');

	$('#player_play_button').remove();
	$('body').append('<div id="player_play_button"></div>');

	$('#progress_bar').remove();
	$('body').append('<div id="progress_bar"></div>');

	$('#player_progress_bar_interior').remove();
	$('body').append('<div id="player_progress_bar_interior"></div>');

	$('#player_progress_meter').remove();
	$('body').append('<div id="player_progress_meter"></div>');

	$('#player_time').remove();
	$('body').append('<div id="player_time"></div>');

	$('#lower_control_wrapper').remove();
	$('body').append('<div id="lower_control_wrapper"></div>');

	$('#timeContainer').remove();
	$('body').append('<div id="timeContainer"></div>');

	$('#curTime').remove();
	$('body').append('<div id="curTime"></div>');

	$('#totTime').remove();
	$('body').append('<div id="totTime"></div>');

	$('#volLevel').remove();
	$('body').append('<div id="volLevel"></div>');

	$('#tagHref').remove();

	/* Init the coveTagObj library so we can test it */
  coveTagObj.setCurTimeDiv("curTime");
  coveTagObj.setTotTimeDiv("totTime");
  coveTagObj.setSeekBack(0.04);
  coveTagObj.setFilepath('/videos/test.mp4');
  coveTagObj.setVideoId('1');
  coveTagObj.setProgressMeterDiv('player_progress_meter');
  coveTagObj.setProgressBarDiv('player_progress_bar_interior');
  coveTagObj.setPlayerFrameDiv('player_wrapper');
  coveTagObj.setPausePlayDiv('pausePlay');
  coveTagObj.setVolLevelDiv('volLevel');

  /* Set this to the amount of pixels taken up by buttons on the status bar vs player width */
  coveTagObj.setStatusOffset(50);

  coveTagObj.setPauseFilePath("/images/icons/pause.png");
  coveTagObj.setPlayFilePath("/images/icons/play.png");

  var tagSetJSON = [
    {"name": "test", "id": "1"}
  ];

  coveTagObj.setTagSetJSON(tagSetJSON);
	
  	/* Faux tiptip function */
  	function tipTip() {
		//null
	}

	/* Faux jwPlayer object */
	jwplayer = function() { 
		var volume = 95;
		var state = "PAUSED";

		return createAPI();

		function createAPI() {
			return {
				getPosition : getPosition,
				getWidth : getWidth,
				getHeight : getHeight,
				getVolume : getVolume,
				getState : getState,
				pause : pause,
				play : play,
				getDuration : getDuration
			}
		}

		function pause() {
			state="PAUSED";
		}
		function play() {
			state="PLAYING";
		}
		function getState() {
			alert(state);
			return state;
		}
		function getPosition() {
			return 1.0;
		}
		function getVolume() {
			return volume;
		}
		function getDuration() {
			return 124.9;
		}
		function getWidth() {
			return 400;
		}
		function getHeight() {
			return 600;
		}
	};
	coveTagObj.setJwPlayer(jwplayer);

    });

    it("Should update the current and total time in minutes and seconds.", function() {
		coveTagObj.jwTimeHandler();
		expect($("#totTime").text()).toEqual(("2:4"));
		expect($("#curTime").text()).toEqual(("0:1"));
    });

   it("Should return the file path the same way that we set it.", function() {
		coveTagObj.setFilepath("/fauxPath");
		expect(coveTagObj.getFilepath()).toEqual("/fauxPath");
   });

   it("Should create a tag, and add the tag to the progress bar.", function() {
		expect($('body').children('a').length).toEqual(0);
		coveTagObj.handleTagClick("testTag");
		coveTagObj.handleTagClick("testTag");
		expect($('body').children('a').length).toEqual(1);
   });

   it("Should create a tag, then abandon the tag.", function() {
		expect($('body').children('a').length).toEqual(0);
		coveTagObj.handleTagClick("testTag", null, "mousedown");
		coveTagObj.handleTagClick("testTag", true, "mousedown");
		expect($('body').children('a').length).toEqual(0);
   });

   it("Should create two tags at the same time.", function() {
		expect($('body').children('a').length).toEqual(0);
		coveTagObj.handleTagClick("testTag");
		coveTagObj.handleTagClick("testTag2");
		coveTagObj.handleTagClick("testTag2");
		coveTagObj.handleTagClick("testTag");
		expect($('body').children('a').length).toEqual(2);
   });

   it("Should move the play meter margin.", function () {
	expect($('#player_progress_meter').css("margin-left")).toEqual("0px");
	coveTagObj.moveProgress();
	expect($('#player_progress_meter').css("margin-left")).toEqual("2.8px");
   });

   it("Should make the player_wrapper the same width as the player", function() {
	expect($('#player_wrapper').css("width")).toNotEqual("400px");
	coveTagObj.initPlayerContainer();
	expect($('#player_wrapper').css("width")).toEqual("400px");
   });

});
