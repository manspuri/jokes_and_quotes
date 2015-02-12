$(document).ready(function(){

  $(".post-index-individual").on("click", ".upvote", function(event){
    event.preventDefault();
    var url, method, upvoteId, countId;
    url = $(this).attr("href");
    method = $(this).attr("data-method");
    upvoteId = $(this).attr("id");
    countId = $(this).parent().children('div').attr("id");

    $.ajax({
      url: url,
      type: method,
      success: function(response){
        $("#" + countId).parent().replaceWith(response);
        $("#" + upvoteId).addClass("upvoted");
        $("#" + countId).addClass("upvoted");
      }
    });
    return false;
  });

  $(".post-index-individual").on("click", ".downvote", function(event){
    event.preventDefault();
    var url, method, upvoteId, countId;
    url = $(this).attr("href");
    method = $(this).attr("data-method");
    upvoteId = $(this).attr("id");
    countId = $(this).parent().children(':first-child').next().attr("id");

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

  $("#comments-container").on("click", ".comment-upvote", function(event){
    event.preventDefault();
    var url, method, upvoteId, countId;
    url = $(this).attr("href");
    method = $(this).attr("data-method");
    upvoteId = $(this).attr("id");
    countId = $(this).parent().children('div').attr("id");

    $.ajax({
      url: url,
      type: method,
      success: function(response){
        $("#" + countId).parent().replaceWith(response);
        $("#" + upvoteId).addClass("upvoted");
        $("#" + countId).addClass("upvoted");
      }
    });
    return false;
  });

  $("#comments-container").on("click", ".comment-downvote", function(event){
    event.preventDefault();
    var url, method, upvoteId, countId;
    url = $(this).attr("href");
    method = $(this).attr("data-method");
    upvoteId = $(this).attr("id");
    countId = $(this).parent().children(':first-child').next().attr("id");

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
