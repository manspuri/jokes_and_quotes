$(document).ready(function(){

  // var postVotes = $(".post-vote-count");

  // postVotes.each(function() {
  //   if ($(this).text().length > 5){
  //     $(this).parent().css({"padding-right": 0, "padding-left": 0});
  //   }
  //   console.log($(this).text());
  //   console.log($(this).parent());
  // });

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
});
