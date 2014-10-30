$(document).ready(function(){

  $(".upvote").on("click", function(event){
    event.preventDefault();

    var url = $(this).parent().attr("action");
    var data = {
      id: $(this).parent().attr("id"),
      type: $(this).parent().attr("class")
    };

    $.ajax({
      url: url,
      method: "post",
      data: data,
      success: function(response){
        $(".upvote").css( { "color": "$upvote-color" } );
        $(".vote-number").css({ "color": "$upvote-color"});
        $(".vote-number").html(response);
      }
    });

  });

});