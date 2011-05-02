/* 
   Author: Aaron Hunter
   Version: 0.1
   Date: Apr 21, 2011
   Description: Library to work with JWPlayer and handle interval tagging
*/

var tagArray = new Array();
var halt = false;

function jwTimeHandler(jwTime) {
	currPosition = jwplayer().getPosition();
	duration = jwTime.duration;

	updateTimer(currPosition, duration);

	updateStatusBar(currPosition, duration);
}

function updateTimer(currPosition, duration) {
	var element = document.getElementById(timerDiv);

	element.innerHTML = currPosition.toFixed(1) + " of " + duration.toFixed(1);
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
		jwplayer().pause("false");
	}

	if (haltTagging != null && isTagActive(tag)[0] == true) {
	//	interruptTagging();
		destroyPartialTags();
	}
}

function interruptTagging() {
	/* Pause the video player and instruct the user */
	jwplayer().pause("true");

	if (confirm("You left the tagging area in the middle of a tag. To continue tagging, choose OK, then go hold the tag button again.")) {
		halt = true;
	} else {
		destroyPartialTags();
		alert("You decided to abandon the tag. Click ok to resume.");
		jwplayer().pause("false");
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

	 	var activeTagText = "!! YOU ARE TAGGING HOLD THE BUTTON " +
			"UNTIL YOU ARE DONE !!";


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
			return [activeTag[i][1], i];
			break;
		}
	}

	/* Invalid */
	return [-1, -1];
}

function toggleTagActive(tag) {
	var tagIndexStatus = isTagActive(tag);

	/* If the tag is finishing, just mark the end time */
	if (tagIndexStatus[0] == true) {
		endTag(tag);
		activeTag[tagIndexStatus[1]][1] = false;
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
			tagArray[i][2] = jwplayer().getPosition().toFixed(2);
	}
}

function startTag(tag) {
	/* Compensate for muscle delay and jump the tag start
	 * time back */
	var curPosition = jwplayer().getPosition();
	var seekPosition = curPosition - seekBack;

	var t = new Array(3);

	t[0] = tag;
	t[1] = seekPosition.toFixed(2);


	tagArray[tagArray.length] = t;

	t = null;
}

function postTag(video_id, code_id, start_time, end_time) {
  var url = "/videos/" + video_id + "/tag";
  var data = {code_id: code_id, start_time: start_time, end_time: end_time};
  var callback = function(data) {
    // do something with the post response
  };
  $.post(url, data, callback);
}