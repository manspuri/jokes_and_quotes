$(document).ready(function(){

  $(".post-upvote").on("click", function(event){
    event.preventDefault();
    var url, method, upvoteId, countId;
    console.log(event);
    console.log(this);
    url = $(this).attr("href");
    console.log("this is the url: " + url);

    method = $(this).attr("data-method");
    console.log("this is the method: " + method);

    upvoteId = $(this).attr("id");
    countId = $(this).parent().children('div').attr("id");

    $.ajax({
      url: url,
      type: method,
      success: function(response){
        console.log(response);
        $("#" + countId).parent().replaceWith(response);
        $("#" + upvoteId).addClass("upvoted");
        $("#" + countId).addClass("upvoted");
      }
    });
    return false;
  });

  $(".post-downvote").on("click", function(event){
    event.preventDefault();
    var url, method, upvoteId, countId;
    url = $(this).attr("href");
    method = $(this).attr("data-method");
    upvoteId = $(this).attr("id");
    countId = $(this).parent().children(':first-child').next().attr("id");

    console.log(url);
    console.log(method);

    $.ajax({
      url: url,
      type: method,
      success: function(response){
        $("#" + countId).parent().replaceWith(response);
        $("#" + upvoteId).addClass("downvoted");
        $("#" + countId).addClass("downvoted");
      }
    });
  return false;
  });
});
