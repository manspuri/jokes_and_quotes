function deliverMyForm(deliveree){
  
  var url = deliveree.attr("href");

  $.get( url ).done(function(response){
      $("#sign-in-sign-up").html(response);
  });
}

$(document).ready(function(){

  $(".sign_in_link").click(function(e){
    e.preventDefault();
    deliverMyForm($(this));
  });

  $(".sign_up_link").click(function(e){
    e.preventDefault();
    deliverMyForm($(this));
  });
});
