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
 
});

