/* 
   Author: Aaron Hunter
   Version: 0.1
   Date: Apr 21, 2011
   Description: Library to work with JWPlayer and handle interval tagging
*/

var tagArray = new Array();

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

function handleTagClick(tag) {
	resetTagDivs();

	var tagActive = isTagActive(tag);

	if (tagActive)
		markTag(tag);

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

		var activeTagText = tagName + "<br />";

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
	var startTag = false;

	/* Determine if we have an active tag */
	for (var i=0; i<activeTag.length; i++) {
		if (activeTag[i][0] == tag && activeTag[i][1] == true) {
			activeTag[i][1] = false;


	/* If the tag is finishing, just mark the end time */
	for (var i=0; i<tagArray.length; i++) {
		if (tagArray[i][0] == tag && tagArray[i][2] == null) {
			tagArray[i][2] = jwplayer().getPosition().toFixed(2);
		}
	}

		} else if (activeTag[i][0] == tag && activeTag[i][1] == false) {
			startTag = true;
			activeTag[i][1] = true;
		}
	}

	return startTag;
}

function resetTagDivs() {
	document.getElementById(activeTagDiv).innerHTML = "";
	document.getElementById(tagListDiv).innerHTML = "";
}

function markTag(tag) {
	/* Compensate for muscle delay and jump back */
	var curPosition = jwplayer().getPosition();
	var seekPosition = curPosition - (curPosition*seekBack);
	jwplayer().seek(seekPosition);

	var t = new Array(3);

	t[0] = tag;
	t[1] = seekPosition.toFixed(2);


	tagArray[tagArray.length] = t;
}
