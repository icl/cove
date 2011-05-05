describe("coveTag", function() {
    beforeEach(function() {
	    /* Create some DIVs so we can test JS interaction */
	    $('#curTime').remove();
	    $('body').append('<div id="curTime"></div>');

	    $('#totTime').remove();
	    $('body').append('<div id="totTime"></div>');

	    $('#activeTags').remove();
	    $('body').append('<div id="activeTags"></div>');

	    $('#tagList').remove();
	    $('body').append('<div id="tagList"></div>');
    });

    it("reset some innerHTML", function() {
//	    $('#activeTagDiv').html("Hello World");

	    coveTag = new coveTag(true);


coveTag.setTimerDiv("prog");
coveTag.setProgressBar("progbar");
coveTag.setActiveTagDiv("activeTags");
coveTag.setTagListDiv("tagList");
coveTag.setStatusLength(10);
coveTag.setSeekBack(0.04);
coveTag.setFilepath('/videos/wabbit.mp4');
coveTag.setVideoId('1');

var activeTag = new Array(1);
activeTag[0] = ['riffing', false, '0'];
coveTag.setActiveTag(activeTag);
coveTag.handleTagClick('riffing', false);
expect($('#activeTagDiv').text().length).toEqual(0);
    });
});
