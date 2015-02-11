function deliverMyForm(deliveree){
  
  var url = deliveree.attr("href");

  $.get( url ).done(function(response){
    // $('.modal').css({ 'height': $(document).innerHeight(), 'width': $(document).innerWidth() });
    $('.modal').show();
    $("#sign-in-sign-up").html(response);
  });
}

function submitUser(user){
  var url, data;
  
  url = user.attr('action');
  data = user.serialize();

  $.post( url, data ).done(function(response){
    var error = $(response).find('.error-text');
    if (error.length > 0) {
      // $('.modal').show();
      $('#sign-in-sign-up').html(response);
    } else {
      location.reload();
    }
  });
}

$(document).ready(function(){
  $(".sign_in_link").click(function(e) {
    e.preventDefault();
    deliverMyForm($(this));
  });

  $(".sign_up_link").click(function(e) {
    e.preventDefault();
    deliverMyForm($(this));
  });

  $("#sign-in-sign-up").on('submit', '.user-form', function(e){
    e.preventDefault();
    submitUser($(this));
  });
});
