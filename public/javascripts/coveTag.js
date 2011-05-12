/*   
	Description: Library to work with JWPlayer and handle interval tagging
*/
function coveTag() {

	/* Private variables */
	var tagArray = new Array();
	var halt = false;
	var curTimeDiv = '';
	var totTimeDiv = '';
	var progressBar = '';
	var activeTagDiv = '';
	var tagListDiv = '';
	var statusLength = '';
	var seekBack = '';
	var filepath = '';
	var videoId = '';
	var activeTag = '';
	var jwPlayer = '';
	var tagInterruptMSG = '';
	var tagAbandonMSG = '';
	var activeTagText = '';

	return createApi();

	function createApi() {
		return {
			handleTagClick : handleTagClick,
			jwTimeHandler : jwTimeHandler,
			setTotTimeDiv : setTotTimeDiv,
			setTotTime : setTotTime,
			setCurTimeDiv : setCurTimeDiv,
			setProgressBar : setProgressBar,
			setActiveTagDiv : setActiveTagDiv,
			setTagListDiv : setTagListDiv,
			setStatusLength : setStatusLength,
			setSeekBack : setSeekBack,
			setFilepath : setFilepath,
			setVideoId : setVideoId,
			setActiveTag : setActiveTag,
			setJwPlayer : setJwPlayer,
			setTagInterruptMSG : setTagInterruptMSG,
			setTagAbandonMSG : setTagAbandonMSG,
			setActiveTagText : setActiveTagText,
			getFilepath : getFilepath
		}
	}

	/* Setter Methods */
	function setTagInterruptMSG(in_tagInterruptMSG) { tagInterruptMSG = in_tagInterruptMSG; }
	function setTagAbandonMSG(in_tagAbandonMSG) { tagAbandonMSG = in_tagAbandonMSG; }
	function setActiveTagText(in_activeTagText) { activeTagText = in_activeTagText; }
	function setTotTimeDiv(in_totTimeDiv) { totTimeDiv = in_totTimeDiv; }
	function setCurTimeDiv(in_curTimeDiv) { curTimeDiv = in_curTimeDiv; }
	function setProgressBar(in_progressBar) { progressBar = in_progressBar; }
	function setActiveTagDiv(in_activeTagDiv) { activeTagDiv = in_activeTagDiv; }
	function setTagListDiv(in_tagListDiv) { tagListDiv = in_tagListDiv; }
	function setStatusLength(in_statusLength) { statusLength = in_statusLength; }
	function setSeekBack(in_seekBack) { seekBack = in_seekBack; }
	function setFilepath(in_filepath) { filepath = in_filepath; }
	function setVideoId(in_videoId) { videoId = in_videoId; }
	function setActiveTag(in_activeTag) { activeTag = in_activeTag; }
	function setJwPlayer(in_jwPlayer) { jwPlayer = in_jwPlayer; }

	/* Getter methods */
	function getFilepath() { return filepath; }

	function setTotTime(totTime) {
		var element = document.getElementById(totTimeDiv);
		element.innerHTML = totTime.toFixed(1);
	}

	function jwTimeHandler(jwTime) {
		currPosition = jwPlayer().getPosition();
		duration = jwPlayer().getDuration();

		updateTimer(currPosition);

		updateStatusBar(currPosition, duration);
	}

	function updateTimer(currPosition) {
		var element = document.getElementById(curTimeDiv);

		element.innerHTML = currPosition.toFixed(1);
	}

function updateStatusBar(currPosition, duration) {
	var remaining = 0;
	var statusText = "";
	var elapsedPosition = ( (currPosition/duration) * statusLength);

	var element = document.getElementById(progressBar);

	/* Create our ='s text for our current position */
	for (var i = 0; i < elapsedPosition; i++) {
		statusText = statusText + "=";
		++remaining;
	}

	/* Append our *'s text for our remaining length */
	for (var i = 0; i <= (statusLength - remaining); i++) {
		statusText = statusText + "*";
	}

	element.innerHTML = "[" + statusText + "]";
}


function handleTagClick(tag, haltTagging) {
	if (haltTagging == null && halt == false) {
		resetTagDivs();
		toggleTagActive(tag);
		updateTagDivs();
	}

	/* The user created an interrupt event
	 * and wishes to recover */
	if (haltTagging == null && halt == true) {
		halt = false;
		jwPlayer().pause("false");
	}

	if (haltTagging != null && isTagActive(tag)[0] == true) {
	//	interruptTagging();
		destroyPartialTags();
	}
}

function interruptTagging() {
	/* Pause the video player and instruct the user */
	jwPlayer().pause("true");

	if (confirm(tagInterruptMSG)) {
		halt = true;
	} else {
		destroyPartialTags();
		alert(tagAbandonMSG);
		jwPlayer().pause("false");
	}
}

function destroyPartialTags() {
	/* Loop through and destroy any tags without an end time,
	 * set all current active tags to false */

	for (var i=0; i<activeTag.length; i++) {
		activeTag[i][1] = false;
	}

	for (var i=0; i<tagArray.length; i++) {
		if (tagArray[i][2] == null) {
			tagArray.splice(i,1);
		}
	}

	resetTagDivs();
	updateTagDivs();
}

function updateTagDivs() {
	var tagListElement = document.getElementById(tagListDiv);
	var activeTagElement = document.getElementById(activeTagDiv);

	for (var i=0; i<tagArray.length; i++) {
		var tagName = tagArray[i][0];
		var startTime = tagArray[i][1];
		var endTime = tagArray[i][2];

		tagName = '<a href="#" onClick="jwplayer().seek('+ startTime +');">' +

			tagName + "</a>";
		var tagListText = tagName + " Start: " + startTime + 
			" End: " + endTime + "<br />";

		if (tagArray[i][2] != null) {
			appendDivText(tagListElement, tagListText);
		} else {
			appendDivText(activeTagElement, activeTagText);
		}
	}
}

function appendDivText(element, text) {
	element.innerHTML += text;
}

function isTagActive(tag) {
	for (var i=0; i<activeTag.length; i++) {
		if (activeTag[i][0] == tag) {
			/* Return tag state, and index */
			return [activeTag[i][1], i, activeTag[i][2]];
			break;
		}
	}

	/* Invalid */
	return [-1, -1, -1];
}

function toggleTagActive(tag) {
	var tagIndexStatus = isTagActive(tag);

	/* If the tag is finishing, just mark the end time */
	if (tagIndexStatus[0] == true) {
		endTag(tag);
		activeTag[tagIndexStatus[1]][1] = false;
		postTag(
			videoId,
			activeTag[tagIndexStatus[1]][2],
			tagArray[tagIndexStatus[1]][1],
			tagArray[tagIndexStatus[1]][2]
		);
	} else {
		startTag(tag);
		activeTag[tagIndexStatus[1]][1] = true;
	}
}

function resetTagDivs() {
	document.getElementById(activeTagDiv).innerHTML = "";
	document.getElementById(tagListDiv).innerHTML = "";
}

function endTag(tag) {
	/* Find the tag with no end point and end it */
	for (var i=0; i<tagArray.length; i++) {
		if (tagArray[i][0] == tag && tagArray[i][2] == null) 
			tagArray[i][2] = jwPlayer().getPosition().toFixed(2);
	}
}

function startTag(tag) {
	/* Compensate for muscle delay and jump the tag start
	 * time back */
	var curPosition = jwPlayer().getPosition();
	var seekPosition = curPosition - seekBack;

	var t = new Array(3);

	t[0] = tag;
	t[1] = seekPosition.toFixed(2);


	tagArray[tagArray.length] = t;

	t = null;
}

function postTag(video_id, tag_id, start_time, end_time) {
  var url = "/videos/" + video_id + "/tag";
  var data = {tag_id: tag_id, start_time: start_time, end_time: end_time};
  var callback = function(data) {
    // do something with the post response
  };
  $.post(url, data, callback);
}

}
