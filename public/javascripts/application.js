var myApp = {};

myApp.addVideoToList = function(video_id){
  var list = $('#added_video_list');
  var old_value = list.attr("value");
  if (old_value === "") {
    list.attr("value", old_value + video_id);
  }
  else{
    list.attr("value", old_value + "," + video_id);
  }
  
};
myApp.removeVideoFromList = function(video_id) {
  var list = $('#added_video_list');
  var old_value = list.attr("value");
  var new_value;
  if (old_value.length < 2) {
    new_value = "";
  }
  else if (old_value[0] === video_id.toString()){
    new_value = old_value.replace(("" + video_id + "," ), "");
  }
  else{
    new_value = old_value.replace(("," + video_id ), ""); 
  }
  list.attr("value", new_value);
};

$(document).ready(function(){
  // Javascript to handle autosubmitting the form when things change
  $('#filter_form select').bind("change", function(){
    console.log($(this).attr("value"));
    $('#filter_form').submit();
  });
  //This javascript will handle ajax updating of the filtered search results
  $('#filter_form').bind("ajax:success", function(event, response, status) {  
    $('#result_container').html(response);
  });

  $('#filter_form').bind("ajax:failure", function(event, response, status) {  
    $('#result_container').html("An Error Occured");
  });

  $('.job_video_search').delegate(".search_result", "click", function(){
    event.preventDefault();
    if ($(this).hasClass("selected")) { 
      myApp.removeVideoFromList($(this).data("video_id"));
      $(this).removeClass("selected");
    }  
    else {
      myApp.addVideoToList($(this).data("video_id"));
      $(this).addClass("selected");
    }
  });

});

