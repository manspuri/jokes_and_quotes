$(document).ready(function(){
  
  $('.main_add_comment_btn').on('click', function(e){
    var button, url, request;

    e.preventDefault();
    button = $(this);
    
    url = button.find('a').attr('href');
    request = $.get( url );

    request.done(function(response){
      $('#main-add-comment-input').append(response);
      button.hide();
      if ( $('.edit_post_button') ) {
       $('.edit_post_button').hide();
      }
    });
  });

  $('#main-add-comment-input').on('submit', '.add-comment', function(e){
    var url, comment, form;
    e.preventDefault();
    form = $(this);
    url = form.attr('action');
    comment = form.serialize();
    console.log(comment);
    request = $.post( url, comment );

    request.done(function(response){
      form.hide();
      $('.main_add_comment_btn').show();
      $('#comments-container').append(response);
    });
    return false;
  });

  $('.sub_add_comment_btn').on('click', function(e){
    var button, url, request;
    e.preventDefault();

    button = $(this);

    var buttonID = button.attr('id');
    console.log(buttonID);

    url = button.find('a').attr('href');
    console.log(url);
    // console.log(button.siblings().);

    request = $.get( url );

    request.done(function(response){
      console.log(response);
      console.log($('#' + buttonID));

      $('#comment-' + buttonID + '-input').append(response);
      button.hide();
    });
  });

  // $('#main-add-comment-input').on('submit', '.add-comment', function(e){
  //   var url, comment, form;
  //   e.preventDefault();
  //   form = $(this);
  //   url = form.attr('action');
  //   comment = form.serialize();
  //   console.log(comment);
  //   request = $.post( url, comment );

  //   request.done(function(response){
  //     form.hide();
  //     $('.sub_add_comment_btn').show();
  //     $('#comments-container').append(response);
  //   });
  // });

});