$(document).ready(function(){

  $(".post-upvote").on("click", function(event){
    var url, method, upvoteId, countId;
    event.preventDefault();
    url = $(this).parent().attr("href");
    method = $(this).parent().attr("data-method");
    upvoteId = $(this).attr("id");
    countId = $(this).parent().parent().children(':first-child').next().attr("id");

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
  });

  $(".post-downvote").on("click", function(event){
    var url, method, upvoteId, countId;

    event.preventDefault();
    url = $(this).parent().attr("href");
    method = $(this).parent().attr("data-method");
    upvoteId = $(this).attr("id");
    countId = $(this).parent().parent().children(':first-child').next().attr("id");

    $.ajax({
      url: url,
      type: method,
      success: function(response){
        $("#" + countId).parent().replaceWith(response);
        $("#" + upvoteId).addClass("downvoted");
        $("#" + countId).addClass("downvoted");
      }
    });
  });
});
