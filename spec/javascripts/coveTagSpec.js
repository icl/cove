describe("coveTagTest", function() {
    beforeEach(function() {
	/* Create some DIVs so we can test JS interaction */
	$('#curTime').remove();
	$('body').append('<div id="curTime"></div>');

	$('#totTime').remove();
	$('body').append('<div id="totTime"></div>');

	$('#progbar').remove();
	$('body').append('<div id="progbar"></div>');

	$('#activeTags').remove();
	$('body').append('<div id="activeTags"></div>');

	$('#tagList').remove();
	$('body').append('<div id="tagList"></div>');

	$('#jwplayer_container').remove();
	$('body').append('<div id="jwplayer_container"></div>');

	/* Init the coveTagObj library so we can test it */
	activeTagText = "YOU ARE NOW TAGGING!";
	coveTagObj = new coveTag();
	coveTagObj.setCurTimeDiv("curTime");
	coveTagObj.setTotTimeDiv("totTime");
	coveTagObj.setProgressBar("progbar");
	coveTagObj.setActiveTagDiv("activeTags");
	coveTagObj.setTagListDiv("tagList");
	coveTagObj.setStatusLength(10);
	coveTagObj.setSeekBack(0.04);
	coveTagObj.setFilepath('/videos/wabbit.mp4');
	coveTagObj.setVideoId('1');
	coveTagObj.setActiveTagText(activeTagText);

	/* Faux jwPlayer object */
	jwplayer = function() { 
		return createAPI();

		function createAPI() {
			return {
				getPosition : getPosition,
				getDuration : getDuration
			}
		}

		function getPosition() {
			return 1.0;
		}

		function getDuration() {
			return 50.0;
		}
	};
	coveTagObj.setJwPlayer(jwplayer);

	/* Faux tag array */
	var activeTag = new Array(1);
	activeTag[0] = ['fauxTag', false, '1'];
	coveTagObj.setActiveTag(activeTag);
    });

    it("Should put the total time into the proper div with one decimal place.", function() {
		coveTagObj.setTotTime(50);
		expect($("#totTime").text()).toEqual((50).toFixed(1));
    });

    it("Should update the current time into the proper div with one decimal place.", function() {
		coveTagObj.jwTimeHandler(1);
		expect($("#curTime").text()).toEqual((1).toFixed(1));
    });

    it("Should handle a tag click, start a tag, and update the notification div.", function() {
		coveTagObj.handleTagClick("fauxTag");
		expect($("#activeTags").text()).toEqual(activeTagText);
    });

    it("Should handle the tag click twice, which will end a tag, and null the notification div.", function() {
		coveTagObj.handleTagClick("fauxTag");
		coveTagObj.handleTagClick("fauxTag");
		expect($("#activeTags").text().length).toEqual(0);
	});

    it("Should complete a tag and show the complete tag in a div.", function() {
		expect($("#tagList").text().length).toEqual(0);
		coveTagObj.handleTagClick("fauxTag");
		coveTagObj.handleTagClick("fauxTag");
		expect($("#tagList").text().length).toBeGreaterThan(0);
	});
    it("Should complete two tags, and the completed tag div should grow.", function() {
		expect($("#tagList").text().length).toEqual(0);
		coveTagObj.handleTagClick("fauxTag");
		coveTagObj.handleTagClick("fauxTag");

		var curLen = $("#tagList").text().length;
		expect(curLen).toBeGreaterThan(0);

		coveTagObj.handleTagClick("fauxTag");
		coveTagObj.handleTagClick("fauxTag");
		expect($("#tagList").text().length).toBeGreaterThan(curLen);
	});

   it("Should simulate a tag abandonment, and abandon the tag.", function() {
		expect($("#tagList").text().length).toEqual(0);
		coveTagObj.handleTagClick("fauxTag");
		coveTagObj.handleTagClick("fauxTag", true);
		expect($("#tagList").text().length).toEqual(0);
   });

   it("Should return the file path the same way that we set it.", function() {
		coveTagObj.setFilepath("/fauxPath");
		expect(coveTagObj.getFilepath()).toEqual("/fauxPath");
	});
});
