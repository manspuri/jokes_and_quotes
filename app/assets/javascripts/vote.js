$(document).ready(function(){

  $(".post-upvote").on("click", function(event){
    event.preventDefault();
    var url = $(this).parent().attr("href");
    var method = $(this).parent().attr("data-method");
    var upvoteId = $(this).attr("id");
    var countId = $(this).parent().parent().children(':first-child').next().attr("id");

    $.ajax({
      url: url,
      type: method,
      success: function(response){
        $("#" + countId).parent().replaceWith(response);
        $("#" + upvoteId).css({"border-bottom-color":"green"});
        $("#" + countId).css({"color":"green"});
      }
    });
  });

  $(".post-downvote").on("click", function(event){
    event.preventDefault();
    var url = $(this).parent().attr("href");
    var method = $(this).parent().attr("data-method");
    var upvoteId = $(this).attr("id");
    var countId = $(this).parent().parent().children(':first-child').next().attr("id");

    $.ajax({
      url: url,
      type: method,
      success: function(response){
        $("#" + countId).parent().replaceWith(response);
        $("#" + upvoteId).css({"border-top-color":"red"});
        $("#" + countId).css({"color":"red"});
      }
    });
  });
});
